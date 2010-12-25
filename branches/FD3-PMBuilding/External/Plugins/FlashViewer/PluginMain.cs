using System;
using System.IO;
using System.Drawing;
using System.Reflection;
using System.Diagnostics;
using System.Windows.Forms;
using System.ComponentModel;
using System.Collections.Generic;
using WeifenLuo.WinFormsUI.Docking;
using PluginCore.Localization;
using FlashViewer.Controls;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore.Helpers;
using PluginCore;

namespace FlashViewer
{
	public class PluginMain : IPlugin
	{
        private String pluginName = "FlashViewer";
        private String pluginGuid = "cba5ca4c-db80-43c2-9219-a15ee4d76aac";
        private String pluginHelp = "www.flashdevelop.org/community/";
        private String pluginDesc = "Displays flash movies in FlashDevelop.";
        private String pluginAuth = "FlashDevelop Team";
        private List<Form> popups = new List<Form>();
        private String settingFilename;
        private Settings settingObject;
        private Icon playerIcon;

	    #region Required Properties

        /// <summary>
        /// Name of the plugin
        /// </summary> 
        public String Name
		{
			get { return this.pluginName; }
		}

        /// <summary>
        /// GUID of the plugin
        /// </summary>
        public String Guid
		{
			get { return this.pluginGuid; }
		}

        /// <summary>
        /// Author of the plugin
        /// </summary> 
        public String Author
		{
			get { return this.pluginAuth; }
		}

        /// <summary>
        /// Description of the plugin
        /// </summary> 
        public String Description
		{
			get { return this.pluginDesc; }
		}

        /// <summary>
        /// Web address for help
        /// </summary> 
        public String Help
		{
			get { return this.pluginHelp; }
		}

        /// <summary>
        /// Object that contains the settings
        /// </summary>
        [Browsable(false)]
        public Object Settings
        {
            get { return this.settingObject; }
        }
		
		#endregion
		
		#region Required Methods
		
		/// <summary>
		/// Initializes the plugin
		/// </summary>
		public void Initialize()
		{
            this.InitBasics();
            this.LoadSettings();
            this.AddEventHandlers();
        }
		
		/// <summary>
		/// Disposes the plugin
		/// </summary>
		public void Dispose()
		{
            this.SaveSettings();
		}
		
		/// <summary>
		/// Handles the incoming events
		/// </summary>
		public void HandleEvent(Object sender, NotifyEvent e, HandlingPriority prority)
		{
            switch (e.Type)
            {
                case EventType.Command : 
                    this.HandleCommand(((DataEvent)e));
                    break;

                case EventType.FileOpening : 
                    this.HandleFileOpening(((TextEvent)e));
                    break;
            }
		}
		
		#endregion

        #region Custom Methods
       
        /// <summary>
        /// Initializes important variables
        /// </summary>
        public void InitBasics()
        {
            String dataPath = Path.Combine(PathHelper.DataDir, "FlashViewer");
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
            Assembly assembly = Assembly.GetExecutingAssembly();
            String resource = "FlashViewer.Resources.Player.ico";
            Stream stream = assembly.GetManifestResourceStream(resource);
            this.pluginDesc = TextHelper.GetString("Info.Description");
            this.playerIcon = new Icon(stream);
        }

        /// <summary>
        /// Adds the required event handlers
        /// </summary> 
        public void AddEventHandlers()
        {
            EventManager.AddEventHandler(this, EventType.FileOpening, HandlingPriority.High);
            EventManager.AddEventHandler(this, EventType.Command);
        }

        /// <summary>
        /// Loads the plugin settings
        /// </summary>
        public void LoadSettings()
        {
            this.settingObject = new Settings();
            if (!File.Exists(this.settingFilename)) this.SaveSettings();
            else
            {
                Object obj = ObjectSerializer.Deserialize(this.settingFilename, this.settingObject);
                this.settingObject = (Settings)obj;
            }
            // Try to find player path from: Tools/flexsdk/
            if (this.settingObject.PlayerPath == null || this.settingObject.PlayerPath == String.Empty)
            {
                String playerPath = Path.Combine(PathHelper.ToolDir, @"flexsdk\runtimes\player\10\win\FlashPlayer.exe");
                if (File.Exists(playerPath)) this.settingObject.PlayerPath = playerPath;
            }
        }

        /// <summary>
        /// Saves the plugin settings
        /// </summary>
        public void SaveSettings()
        {
            ObjectSerializer.Serialize(this.settingFilename, this.settingObject);
        }

        /// <summary>
        /// Handles the Command event and displays the movie
        /// </summary>
        public void HandleCommand(DataEvent evnt)
        {
            try
            {
                if (evnt.Action.StartsWith("FlashViewer."))
                {
                    String action = evnt.Action;
                    String[] args = evnt.Data.ToString().Split(',');
                    if (action == "FlashViewer.Default")
                    {
                        switch (this.settingObject.DisplayStyle)
                        {
                            case ViewStyle.Popup:
                                action = "FlashViewer.Popup";
                                break;

                            case ViewStyle.Document:
                                action = "FlashViewer.Document";
                                break;

                            case ViewStyle.External:
                                action = "FlashViewer.External";
                                break;
                        }
                    }
                    switch (action)
                    {
                        case "FlashViewer.Popup":
                            Int32 width = Convert.ToInt32(args[1]);
                            Int32 height = Convert.ToInt32(args[2]);
                            this.CreatePopup(args[0], new Size(width, height));
                            break;

                        case "FlashViewer.Document":
                            this.CreateDocument(args[0]);
                            break;

                        case "FlashViewer.External":
                            this.LaunchExternal(args[0]);
                            break;

                        case "FlashViewer.GetDisplayStyle":
                            evnt.Data = this.settingObject.DisplayStyle.ToString();
                            break;

                        case "FlashViewer.SetDisplayStyle":
                            ViewStyle vs = (ViewStyle)Enum.Parse(typeof(ViewStyle), evnt.Data.ToString());
                            this.settingObject.DisplayStyle = vs;
                            break;
                    }
                    evnt.Handled = true;
                }
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Handles the FileOpen event and displays the movie
        /// </summary>
        public void HandleFileOpening(TextEvent evnt)
        {
            if (File.Exists(evnt.Value) && Path.GetExtension(evnt.Value) == ".swf")
            {
                switch (this.settingObject.DisplayStyle)
                {
                    case ViewStyle.Popup : 
                        this.CreatePopup(evnt.Value, new Size(550, 400));
                        break;

                    case ViewStyle.Document : 
                        this.CreateDocument(evnt.Value);
                        break;

                    case ViewStyle.External:
                        this.LaunchExternal(evnt.Value);
                        break;
                }
                evnt.Handled = true;
            }
        }

        /// <summary>
        /// Displays the flash movie in a popup
        /// </summary>
        public void CreatePopup(String file, Size size)
        {
            FlashView flashView;
            if (!File.Exists(file)) return;
            foreach (Form form in this.popups)
            {
                flashView = form.Controls[0] as FlashView;
                if (flashView != null && flashView.MoviePath.Equals(file, StringComparison.OrdinalIgnoreCase))
                {
                    form.Controls.Remove(flashView);
                    flashView.Dispose();
                    flashView = CreateFlashView(file);
                    if (flashView == null) return;
                    flashView.Dock = DockStyle.Fill;
                    form.Controls.Add(flashView);
                    form.Activate();
                    return;
                }
            }
            Form popup = new Form();
            popup.Icon = this.playerIcon;
            popup.Text = Path.GetFileName(file);
            popup.ClientSize = new Size(size.Width, size.Height);
            popup.StartPosition = FormStartPosition.CenterScreen;
            flashView = this.CreateFlashView(null);
            if (flashView == null) return;
            flashView.Size = popup.ClientSize;
            flashView.Dock = DockStyle.Fill;
            popup.Controls.Add(flashView);
            flashView.MoviePath = file;
            popup.Show();
            popup.FormClosing += this.PopupFormClosing;
            popup.Disposed += delegate { NotifyDisposed(file); };
            this.popups.Add(popup);
        }

        /// <summary>
        /// Removes the popup from the tracking
        /// </summary>
        private void PopupFormClosing(Object sender, FormClosingEventArgs e)
        {
            popups.Remove(sender as Form);
        }

        /// <summary>
        /// Displays the flash movie in a document
        /// </summary>
        public void CreateDocument(String file)
        {
            FlashView flashView;
            if (!File.Exists(file)) return;
            foreach (ITabbedDocument document in PluginBase.MainForm.Documents)
            {
                if (!document.IsEditable)
                {
                    foreach (Control ctrl in document.Controls) if (ctrl is FlashView)
                    {
                        flashView = ctrl as FlashView;
                        if (flashView != null && flashView.MoviePath.Equals(file, StringComparison.OrdinalIgnoreCase))
                        {
                            document.Controls.Remove(flashView);
                            flashView.Dispose();
                            flashView = CreateFlashView(file);
                            if (flashView == null) return;
                            flashView.Dock = DockStyle.Fill;
                            document.Controls.Add(flashView);
                            document.Activate();
                            return;
                        }
                    }
                }
            }
            flashView = this.CreateFlashView(null);
            if (flashView == null) return;
            flashView.Dock = DockStyle.Fill;
            DockContent flashDoc = PluginBase.MainForm.CreateCustomDocument(flashView);
            flashDoc.Text = Path.GetFileName(file);
            flashView.MoviePath = file;
            flashDoc.Disposed += delegate { NotifyDisposed(file); };
        }
        private void NotifyDisposed(String file)
        {
            DataEvent de = new DataEvent(EventType.Command, "FlashViewer.Closed", file);
            EventManager.DispatchEvent(this, de);
        }

        /// <summary>
        /// Creates a flash view control and if it fails gives an error message
        /// </summary>
        private FlashView CreateFlashView(string file)
        {
            try
            {
                return new FlashView(file);
            }
            catch (Exception ex)
            {
                String msg = TextHelper.GetString("Info.FlashMissing");
                ErrorManager.ShowWarning(msg, ex);
                return null;
            }
        }

        /// <summary>
        /// Displays the flash movie in an external player
        /// </summary>
        public void LaunchExternal(String file)
        {
            try
            {
                String player = this.settingObject.PlayerPath;
                if (File.Exists(player)) ProcessHelper.StartAsync(player, file); 
                else ProcessHelper.StartAsync(file);
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

		#endregion

	}
	
}