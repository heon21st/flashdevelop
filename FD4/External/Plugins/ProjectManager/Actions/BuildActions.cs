using System;
using System.Collections;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;
using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Channels.Ipc;
using PluginCore;
using PluginCore.Managers;
using PluginCore.Helpers;
using PluginCore.Localization;
using ProjectManager.Helpers;
using ProjectManager.Projects;
using ProjectManager.Projects.AS2;
using ProjectManager.Projects.AS3;
using ProjectManager.Controls;

namespace ProjectManager.Actions
{
	public delegate void BuildCompleteHandler(bool runOutput);

	/// <summary>
	/// Provides methods for building a project inside FlashDevelop
	/// </summary>
	public class BuildActions
	{
        static public int LatestSDKMatchQuality;

		IMainForm mainForm;
        FDMenus menus;
		FDProcessRunner fdProcess;
        string ipcName;

		public event BuildCompleteHandler BuildComplete;
        public event BuildCompleteHandler BuildFailed;

        public string IPCName { get { return ipcName; } }

		public BuildActions(IMainForm mainForm, FDMenus menus)
		{
			this.mainForm = mainForm;
            this.menus = menus;

			// setup FDProcess helper class
			this.fdProcess = new FDProcessRunner(mainForm);

            // setup remoting service so FDBuild can use our in-memory services like FlexCompilerShell
            this.ipcName = Guid.NewGuid().ToString();
            SetupRemotingServer();
		}

        private void SetupRemotingServer()
        {
            IpcChannel channel = new IpcChannel(ipcName);
            ChannelServices.RegisterChannel(channel, false);
            RemotingConfiguration.RegisterWellKnownServiceType(typeof(FlexCompilerShell), "FlexCompilerShell", WellKnownObjectMode.Singleton);
        }

        public bool Build(Project project, bool runOutput, bool releaseMode)
        {
            // save modified files
            mainForm.CallCommand("SaveAllModified", null);

            InstalledSDK sdk = GetProjectSDK(project);
            string compiler = GetCompilerPath(project, sdk);
            project.TraceEnabled = !releaseMode;

            if (project.OutputType == OutputType.OtherIDE)
            {
                // compile using associated IDE
                string error;
                string command = project.GetOtherIDE(runOutput, releaseMode, out error);

                if (error != null) ErrorManager.ShowInfo(TextHelper.GetString(error));
                else
                {
                    if (command == "FlashIDE") RunFlashIDE(project, runOutput, releaseMode);
                    else
                    {
                        Hashtable data = new Hashtable();
                        data["command"] = command;
                        data["project"] = project;
                        data["runOutput"] = runOutput;
                        data["releaseMode"] = releaseMode;
                        DataEvent de = new DataEvent(EventType.Command, "ProjectManager.RunWithAssociatedIDE", data);
                        EventManager.DispatchEvent(project, de);
                    }
                }
                return false;
            }
            else if (project.OutputType == OutputType.CustomBuild)
            {
                // validate commands not empty
                if (project.PreBuildEvent.Trim().Length == 0 && project.PostBuildEvent.Trim().Length == 0)
                {
                    String info = TextHelper.GetString("Info.NoOutputAndNoBuild");
                    ErrorManager.ShowInfo(info);
                    return false;
                }
            }
            else
            {
                // ask the project to validate itself
                string error;
                project.ValidateBuild(out error);

                if (error != null)
                {
                    ErrorManager.ShowInfo(TextHelper.GetString(error));
                    return false;
                }

                if (project.OutputPath.Length < 1)
                {
                    String info = TextHelper.GetString("Info.SpecifyValidOutputSWF");
                    ErrorManager.ShowInfo(info);
                    return false;
                }

                if (compiler == null || (!Directory.Exists(compiler) && !File.Exists(compiler)))
                {
                    string info = TextHelper.GetString("Info.CheckSDKSettings");
                    MessageBox.Show(info, TextHelper.GetString("Title.ConfigurationRequired"), MessageBoxButtons.OK);
                    return false;
                }
            }
            
            // close running AIR projector
            if (project.MovieOptions.Platform == "AIR")
            {
                foreach (Process proc in Process.GetProcessesByName("adl"))
                {
                    try { proc.Kill(); proc.WaitForExit(10 * 1000); }
                    catch { }
                }
            }

            return FDBuild(project, runOutput, releaseMode, sdk);
        }

        static public void RunFlashIDE(Project project, bool runOutput, bool releaseMode)
        {
            string cmd = (runOutput) ? "testmovie" : "buildmovie";
            if (!PluginMain.Settings.DisableExtFlashIntegration) cmd += "-fd";

            cmd += ".jsfl";
            if (!releaseMode) cmd = "debug-" + cmd;

            cmd = Path.Combine("Tools", Path.Combine("flashide", cmd));
            cmd = PathHelper.ResolvePath(cmd, null);
            if (cmd == null || !File.Exists(cmd))
            {
                ErrorManager.ShowInfo(TextHelper.GetString("Info.JsflNotFound"));
            }
            else
            {
                DataEvent de = new DataEvent(EventType.Command, "ASCompletion.CallFlashIDE", cmd);
                EventManager.DispatchEvent(project, de);
            }
        }

        public bool FDBuild(Project project, bool runOutput, bool releaseMode, InstalledSDK sdk)
		{
            string directory = Environment.CurrentDirectory;
            Environment.CurrentDirectory = project.Directory;

			string fdBuildDir = Path.Combine(PathHelper.ToolDir, "fdbuild");
			string fdBuildPath = Path.Combine(fdBuildDir, "fdbuild.exe");

			string arguments = " -ipc " + ipcName;
            if (sdk.Version != null) arguments += " -version \"" + sdk.Version.Replace(',', ';') + "\"";
            arguments += " -compiler \"" + project.CurrentSDK + "\"";

            if (releaseMode) arguments += " -notrace";
            arguments += " -library \"" + PathHelper.LibraryDir + "\"";

            foreach (string cp in PluginMain.Settings.GlobalClasspaths)
            {
                arguments += " -cp \"" + Environment.ExpandEnvironmentVariables(cp) + "\"";
            }
			
			arguments = arguments.Replace("\\\"", "\""); // c# console args[] bugfix

            SetStatusBar(TextHelper.GetString("Info.BuildStarted"));
            menus.DisabledForBuild = true;
            menus.ConfigurationSelector.Enabled = false;

            fdProcess.StartProcess(fdBuildPath, "\"" + project.ProjectPath + "\"" + arguments,
                project.Directory, delegate(bool success)
                {
                    menus.DisabledForBuild = false;
                    menus.ConfigurationSelector.Enabled = true; // !project.NoOutput;
                    if (success)
                    {
                        SetStatusBar(TextHelper.GetString("Info.BuildSucceeded"));
                        AddTrustFile(project);
                        OnBuildComplete(runOutput);
                    }
                    else
                    {
                        SetStatusBar(TextHelper.GetString("Info.BuildFailed"));
                        OnBuildFailed(runOutput);
                    }
                    Environment.CurrentDirectory = directory;
                });
            return true;
		}

        void OnBuildComplete(bool runOutput)
        {
            if (BuildComplete != null) BuildComplete(runOutput);
        }

        void OnBuildFailed(bool runOutput)
        {
            if (BuildFailed != null) BuildFailed(runOutput);
        }

        void AddTrustFile(Project project)
        {
            string directory = Path.GetDirectoryName(project.OutputPathAbsolute);
            if (!Directory.Exists(directory)) return;
            string trustParams = "FlashDevelop.cfg;" + directory;
            DataEvent de = new DataEvent(EventType.Command, "ASCompletion.CreateTrustFile", trustParams);
            EventManager.DispatchEvent(this, de);
        }

		public void NotifyBuildStarted() { fdProcess.ProcessStartedEventCaught(); }
		public void NotifyBuildEnded(string result) { fdProcess.ProcessEndedEventCaught(result); }
        public void SetStatusBar(string text) { mainForm.StatusLabel.Text = " " + text; }

        /* SDK MANAGEMENT */

        static public InstalledSDK GetProjectSDK(Project project)
        {
            if (project == null) return null;
            InstalledSDK[] sdks = GetInstalledSDKs(project);
            return MatchSDK(sdks, project);
        }

        static public string GetCompilerPath(Project project)
        {
            return GetCompilerPath(project, GetProjectSDK(project));
        }

        static public string GetCompilerPath(Project project, InstalledSDK sdk)
        {
            if (project == null) return null;
            project.CurrentSDK = PathHelper.ResolvePath(sdk.Path, project.Directory);
            return project.CurrentSDK;
        }

        static public InstalledSDK MatchSDK(InstalledSDK[] sdks, IProject project)
        {
            return MatchSDK(sdks, project.PreferredSDK);
        }

        static public InstalledSDK MatchSDK(InstalledSDK[] sdks, string preferredSDK)
        {
            if (sdks == null) sdks = new InstalledSDK[] { };

            // default sdk
            if (String.IsNullOrEmpty(preferredSDK))
            {
                LatestSDKMatchQuality = -1;
                foreach (InstalledSDK sdk in sdks)
                    if (sdk.IsValid) return sdk;
                return InstalledSDK.INVALID_SDK;
            }

            string[] parts = (";;" + preferredSDK).Split(';'); // name;version
            
            // match name
            string name = parts[parts.Length - 3];
            if (name != "")
                foreach (InstalledSDK sdk in sdks)
                    if (sdk.IsValid && sdk.Name == name)
                    {
                        LatestSDKMatchQuality = 0;
                        return sdk;
                    }

            // match version
            string version = parts[parts.Length - 2];
            if (version != "")
            {
                InstalledSDK bestMatch = null;
                int bestScore = int.MaxValue;
                foreach (InstalledSDK sdk in sdks)
                {
                    if (!sdk.IsValid) continue;
                    int score = CompareVersions(sdk.Version ?? "", version);
                    if (score < bestScore)
                    {
                        bestScore = score;
                        bestMatch = sdk;
                    }
                }
                if (bestMatch != null)
                {
                    LatestSDKMatchQuality = bestScore;
                    return bestMatch;
                }
            }

            // new SDK from path
            InstalledSDK newSdk = new InstalledSDK();
            newSdk.Path = parts[parts.Length - 1];
            LatestSDKMatchQuality = -1;
            return newSdk;
        }

        private static int CompareVersions(string sdkVersion, string version)
        {
            int score = 0;
            string[] sa = sdkVersion.Split(',');
            string[] sb = version.Split(',');

            for (int j = 0; j < sb.Length; j++)
            {
                try
                {
                    string[] pa = (sa[j].Trim() + ".0.0").Split('.');
                    string[] pb = (sb[j].Trim() + ".0.0").Split('.');
                    int major = int.Parse(pa[0]) - int.Parse(pb[0]);
                    if (major < 0) return int.MaxValue;
                    else if (major > 0) score += 10;
                    else
                    {
                        int minor = int.Parse(pa[1]) - int.Parse(pb[1]);
                        if (minor < 0) score += 5;
                        else if (minor > 0) score += 2;
                        else
                        {
                            int detail = int.Parse(pa[2]) - int.Parse(pb[2]);
                            if (detail < 0) score += 2;
                            else if (minor > 0) score += 1;
                        }
                    }
                }
                catch { score += 40; }
            }
            if (sb.Length > sa.Length) score += 20;
            return score;
        }

        static public InstalledSDK[] GetInstalledSDKs(IProject project)
        {
            return GetInstalledSDKs(project.Language);
        }

        static public InstalledSDK[] GetInstalledSDKs(string language)
        {
            Hashtable infos = new Hashtable();
            infos["language"] = language;
            DataEvent de = new DataEvent(EventType.Command, "ASCompletion.InstalledSDKs", infos);
            EventManager.DispatchEvent(null, de);
            if (infos.ContainsKey("sdks") && infos["sdks"] != null) return (InstalledSDK[])infos["sdks"];
            else return null;
        }
    }

}
