using System;
using System.Diagnostics;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;
using PluginCore.Managers;
using ASCompletion.Context;
using ASCompletion.Model;
using PluginCore.Localization;
using PluginCore.Controls;
using PluginCore.Helpers;
using PluginCore;
using ASCompletion.Completion;
using System.Collections;
using System.Windows.Forms;
using ProjectManager.Projects.Haxe;
using ProjectManager.Projects;
using AS3Context;

namespace HaXeContext
{
    public class Context : AS2Context.Context
    {
        #region initialization
        new static readonly protected Regex re_CMD_BuildCommand =
            new Regex("@haxe[\\s]+(?<params>.*)", RegexOptions.Compiled | RegexOptions.Multiline);

        static readonly protected Regex re_genericType =
                    new Regex("(?<gen>[^<]+)<(?<type>.+)>", RegexOptions.Compiled | RegexOptions.IgnoreCase);

        static public string FLASH_OLD = "flash";
        static public string FLASH_NEW = "flash9";

        private HaXeSettings hxsettings;
        private string currentSDK;
        private Dictionary<string, string> haxelibsCache;
        private bool hasAIRSupport;
        private bool hasMobileSupport;

        public Context(HaXeSettings initSettings)
        {
            hxsettings = initSettings;
            hxsettings.Init();

            /* AS-LIKE OPTIONS */

            hasLevels = false;
            docType = "Void"; // "flash.display.MovieClip";

            /* DESCRIBE LANGUAGE FEATURES */

            // language constructs
            features.hasPackages = true;
            features.hasImports = true;
            features.hasImportsWildcard = false;
            features.hasClasses = true;
            features.hasExtends = true;
            features.hasImplements = true;
            features.hasInterfaces = true;
            features.hasEnums = true;
            features.hasTypeDefs = true;
            features.hasGenerics = true;
            features.hasEcmaTyping = true;
            features.hasVars = true;
            features.hasConsts = false;
            features.hasMethods = true;
            features.hasStatics = true;
            features.hasTryCatch = true;
            features.hasInference = true;
            features.checkFileName = false;

            // haxe directives
            features.hasDirectives = true;
            features.Directives = new List<string>();
            features.Directives.Add("true");

            // allowed declarations access modifiers
            Visibility all = Visibility.Public | Visibility.Private;
            features.classModifiers = all;
            features.varModifiers = all;
            features.methodModifiers = all;

            // default declarations access modifiers
            features.classModifierDefault = Visibility.Public;
            features.enumModifierDefault = Visibility.Public;
            features.typedefModifierDefault = Visibility.Public;
            features.varModifierDefault = Visibility.Private;
            features.methodModifierDefault = Visibility.Private;

            // keywords
            features.dot = ".";
            features.voidKey = "Void";
            features.objectKey = "Dynamic";
            features.importKey = "import";
            features.importKeyAlt = "using";
            features.typesPreKeys = new string[] { "import", "new", "extends", "implements", "using" };
            features.codeKeywords = new string[] { 
                "enum", "typedef", "class", "interface", "var", "function", "new", "cast", "return", "break", 
                "continue", "callback", "if", "else", "for", "while", "do", "switch", "case", "default", "type",
                "null", "untyped", "true", "false", "try", "catch", "throw", "inline", "dynamic"
            };
            features.varKey = "var";
            features.overrideKey = "override";
            features.functionKey = "function";
            features.staticKey = "static";
            features.publicKey = "public";
            features.privateKey = "private";
            features.intrinsicKey = "extern";
            features.inlineKey = "inline";

            /* INITIALIZATION */

            settings = initSettings;

            currentSDK = PathHelper.ResolvePath(hxsettings.GetDefaultSDK().Path);
            initSettings.CompletionModeChanged += OnCompletionModeChange;
            OnCompletionModeChange();

            haxelibsCache = new Dictionary<string,string>();
            //BuildClassPath(); // defered to first use
        }
        #endregion

        #region classpath management

        public bool IsFlashTarget
        {
            get { return platform == HaxeMovieOptions.FLASHPLAYER_PLATFORM || platform == HaxeMovieOptions.AIR_PLATFORM; }
        }
        public bool IsJavaScriptTarget
        {
            get { return platform == HaxeMovieOptions.JAVASCRIPT_PLATFORM; }
        }
        public bool IsNekoTarget
        {
            get { return platform == HaxeMovieOptions.NEKO_PLATFORM; }
        }
        public bool IsPhpTarget
        {
            get { return platform == HaxeMovieOptions.PHP_PLATFORM; }
        }
        public bool IsCppTarget
        {
            get { return platform == HaxeMovieOptions.CPP_PLATFORM; }
        }
        public bool IsNmeTarget
        {
            get { return platform == HaxeMovieOptions.NME_PLATFORM; }
        }


        private string LookupLibrary(string lib)
        {
            if (haxelibsCache.ContainsKey(lib))
                return haxelibsCache[lib];

            try
            {
                string haxelib = "haxelib";

                string hxPath = currentSDK;
                if (hxPath != null && Path.IsPathRooted(hxPath))
                    haxelib = Path.Combine(hxPath, haxelib);
                
                ProcessStartInfo pi = new ProcessStartInfo();
                pi.FileName = haxelib;
                pi.Arguments = "path " + lib;
                pi.RedirectStandardOutput = true;
                pi.UseShellExecute = false;
                pi.CreateNoWindow = true;
                pi.WindowStyle = ProcessWindowStyle.Hidden;
                Process p = Process.Start(pi);
                p.WaitForExit();
                
                string path = "";
                do { path = p.StandardOutput.ReadLine(); }
                while (path.StartsWith("-") && !p.StandardOutput.EndOfStream);
                p.Close();

                if (path != null && path.Length > 0 && Directory.Exists(path))
                {
                    haxelibsCache.Add(lib, path);
                    return path;
                }
                else return null;
            }
            catch (Exception)
            {
                return null;
            }
        }

        /// <summary>
        /// Classpathes & classes cache initialisation
        /// </summary>
        public override void BuildClassPath()
        {
            ReleaseClasspath();
            started = true;
            if (hxsettings == null) throw new Exception("BuildClassPath() must be overridden");
            if (contextSetup == null)
            {
                contextSetup = new ContextSetupInfos();
                contextSetup.Lang = settings.LanguageId;
                contextSetup.Platform = "Flash Player";
                contextSetup.Version = "10.0";
            }

            // external version definition
            platform = contextSetup.Platform;
            majorVersion = hxsettings.DefaultFlashVersion;
            minorVersion = 0;
            ParseVersion(contextSetup.Version, ref majorVersion, ref minorVersion);

            // NOTE: version > 10 for non-Flash platforms
            string lang;
            hasAIRSupport = hasMobileSupport = false;
            features.Directives = new List<string>();
            if (IsJavaScriptTarget)
            {
                lang = "js";
            }
            else if (IsPhpTarget)
            {
                lang = "php";
            }
            else if (IsNekoTarget)
            {
                lang = "neko";
            }
            else if (IsCppTarget)
            {
                lang = "cpp";
            }
            else if (IsNmeTarget)
            {
                lang = "cpp";
                features.Directives.Add("--remap flash:nme");
            }
            else if (IsFlashTarget)
            {
                lang = "flash";
                hasAIRSupport = platform == "AIR" || platform == "AIR Mobile";
                hasMobileSupport = platform == "AIR Mobile";
            }
            else lang = platform;
            features.Directives.Add(lang);

            //
            // Class pathes
            //
            classPath = new List<PathModel>();
            // haXe std
            string hxPath = PluginBase.CurrentProject != null
                    ? PluginBase.CurrentProject.CurrentSDK
                    : PathHelper.ResolvePath(hxsettings.GetDefaultSDK().Path);
            if (hxPath != null)
            {
                if (currentSDK != hxPath)
                {
                    currentSDK = hxPath;
                    haxelibsCache = new Dictionary<string, string>();
                    OnCompletionModeChange();
                }

                string haxeCP = Path.Combine(hxPath, "std");
                if (Directory.Exists(haxeCP))
                {
                    if (Directory.Exists(Path.Combine(haxeCP, "flash9")))
                    {
                        FLASH_NEW = "flash9";
                        FLASH_OLD = "flash";
                    }
                    else
                    {
                        FLASH_NEW = "flash";
                        FLASH_OLD = "flash8";
                    }
                    if (lang == "flash")
                        lang = (majorVersion >= 6 && majorVersion < 9) ? FLASH_OLD : FLASH_NEW;

                    PathModel std = PathModel.GetModel(haxeCP, this);
                    if (!std.WasExplored && !Settings.LazyClasspathExploration)
                    {
                        PathExplorer stdExplorer = new PathExplorer(this, std);
                        string[] keep = new string[] { "sys", "haxe" };
                        List<String> hide = new List<string>();
                        foreach (string dir in Directory.GetDirectories(haxeCP))
                            if (Array.IndexOf<string>(keep, Path.GetFileName(dir)) < 0)
                                hide.Add(Path.GetFileName(dir));
                        stdExplorer.HideDirectories(hide);
                        stdExplorer.OnExplorationDone += new PathExplorer.ExplorationDoneHandler(RefreshContextCache);
                        stdExplorer.Run();
                    }
                    AddPath(std);

                    PathModel specific = PathModel.GetModel(Path.Combine(haxeCP, lang), this);
                    if (!specific.WasExplored && !Settings.LazyClasspathExploration)
                    {
                        PathExplorer speExplorer = new PathExplorer(this, specific);
                        speExplorer.OnExplorationDone += new PathExplorer.ExplorationDoneHandler(RefreshContextCache);
                        speExplorer.Run();
                    }
                    AddPath(specific);
                }
            }
            HaxeProject proj = PluginBase.CurrentProject as HaxeProject;

            // swf-libs
            if (IsFlashTarget && (majorVersion < 6 || majorVersion >= 9) && proj != null )
            {
                foreach(LibraryAsset asset in proj.LibraryAssets)
                    if (asset.IsSwf)
                    {
                        string path = proj.GetAbsolutePath(asset.Path);
                        if (File.Exists(path)) AddPath(path);
                    }
                foreach( string p in proj.CompilerOptions.Additional )
                    if( p.IndexOf("-swf-lib ") == 0 ) {
                        string path = proj.GetAbsolutePath(p.Substring(9));
                        if (File.Exists(path)) AddPath(path);
                    }
            }

            // add haxe libraries
            if (proj != null)
            {
                foreach (string param in proj.BuildHXML(new string[0], "", false))
                    if (param.IndexOf("-lib ") == 0)
                        AddPath(LookupLibrary(param.Substring(5)));
            }


            // add external pathes
            List<PathModel> initCP = classPath;
            classPath = new List<PathModel>();
            if (contextSetup.Classpath != null)
            {
                foreach (string cpath in contextSetup.Classpath)
                    AddPath(cpath.Trim());
            }

            // add user pathes from settings
            if (settings.UserClasspath != null && settings.UserClasspath.Length > 0)
            {
                foreach (string cpath in settings.UserClasspath) AddPath(cpath.Trim());
            }
            // add initial pathes
            foreach (PathModel mpath in initCP) AddPath(mpath);

            // parse top-level elements
            InitTopLevelElements();
            if (cFile != null) UpdateTopLevelElements();

            // add current temporaty path
            if (temporaryPath != null)
            {
                string tempPath = temporaryPath;
                temporaryPath = null;
                SetTemporaryPath(tempPath);
            }
            FinalizeClasspath();
        }

        /// <summary>
        /// Parse a packaged library file
        /// </summary>
        /// <param name="path">Models owner</param>
        public override void ExploreVirtualPath(PathModel path)
        {
            try
            {
                if (File.Exists(path.Path))
                {
                    SwfOp.ContentParser parser = new SwfOp.ContentParser(path.Path);
                    parser.Run();
                    AbcConverter.Convert(parser, path, this);
                }
            }
            catch (Exception ex)
            {
                string message = TextHelper.GetString("Info.ExceptionWhileParsing");
                TraceManager.AddAsync(message + " " + path.Path);
                TraceManager.AddAsync(ex.Message);
            }
        }

        /// <summary>
        /// Delete current class's cached file
        /// </summary>
        public override void RemoveClassCompilerCache()
        {
            // not implemented - is there any?
        }
        #endregion

        #region class resolution
        /// <summary>
        /// Evaluates the visibility of one given type from another.
        /// Caller is responsible of calling ResolveExtends() on 'inClass'
        /// </summary>
        /// <param name="inClass">Completion context</param>
        /// <param name="withClass">Completion target</param>
        /// <returns>Completion visibility</returns>
        public override Visibility TypesAffinity(ClassModel inClass, ClassModel withClass)
        {
            // same file
            if (withClass != null && inClass.InFile == withClass.InFile)
                return Visibility.Public | Visibility.Private;
            // inheritance affinity
            ClassModel tmp = inClass;
            while (!tmp.IsVoid())
            {
                if (tmp == withClass)
                    return Visibility.Public | Visibility.Private;
                tmp = tmp.Extends;
            }
            // same package
            if (withClass != null && inClass.InFile.Package == withClass.InFile.Package)
                return Visibility.Public;
            // public only
            else
                return Visibility.Public;
        }

        /// <summary>
        /// Return the full project classes list
        /// </summary>
        /// <returns></returns>
        public override MemberList GetAllProjectClasses()
        {
            // from cache
            if (!completionCache.IsDirty && completionCache.AllTypes != null)
                return completionCache.AllTypes;

            MemberList fullList = new MemberList();
            MemberModel item;
            // public & internal classes
            string package = CurrentModel.Package;
            foreach (PathModel aPath in classPath) if (aPath.IsValid && !aPath.Updating)
            {
                aPath.ForeachFile((aFile) =>
                {
                    string module = Path.GetFileNameWithoutExtension(aFile.FileName);
                    string qmodule = aFile.Package.Length > 0 ? aFile.Package + "." + module : module;
                    bool needModule = true;

                    if (aFile.Classes.Count > 0 && !aFile.Classes[0].IsVoid())
                        foreach (ClassModel aClass in aFile.Classes)
                        {
                            string tpackage = aClass.InFile.Package;
                            if (aClass.IndexType == null
                                && (aClass.Access == Visibility.Public
                                    || (aClass.Access == Visibility.Internal && tpackage == package)))
                            {
                                if (aClass.Name == module)
                                {
                                    needModule = false;
                                    item = aClass.ToMemberModel();
                                    if (tpackage != package) item.Name = item.Type;
                                    fullList.Add(item);
                                }
                                else if (tpackage == "") fullList.Add(aClass.ToMemberModel());
                                else if (tpackage == package) fullList.Add(aClass.ToMemberModel());
                            }
                        }
                    // HX files correspond to a "module" which should appear in code completion
                    // (you don't import classes defined in modules but the module itself)
                    if (needModule)
                    {
                        item = new MemberModel(qmodule, qmodule, FlagType.Class, Visibility.Public);
                        fullList.Add(item);
                    }
                    return true;
                });
            }
            // display imported classes and classes declared in imported modules
            MemberList imports = ResolveImports(cFile);
            FlagType mask = FlagType.Class | FlagType.Enum;
            foreach (MemberModel import in imports)
            {
                if ((import.Flags & mask) > 0)
                {
                    fullList.Add(import);
                }
            }

            // in cache
            fullList.Sort();
            completionCache.AllTypes = fullList;
            return fullList;
        }

        /// <summary>
        /// Return imported classes list (not null)
        /// </summary>
        /// <param name="package">Package to explore</param>
        /// <param name="inFile">Current file</param>
        public override MemberList ResolveImports(FileModel inFile)
        {
            bool filterImports = (inFile == cFile);
            int lineMin = (filterImports && inPrivateSection) ? inFile.PrivateSectionIndex : 0;
            int lineMax = (filterImports && inPrivateSection) ? int.MaxValue : inFile.PrivateSectionIndex;
            MemberList imports = new MemberList();
            foreach (MemberModel item in inFile.Imports)
            {
                if (filterImports && (item.LineFrom < lineMin || item.LineFrom > lineMax)) continue;
                if (settings.LazyClasspathExploration) {
                    imports.Add(item);
                    continue;
                }
                // HX files are "modules": when imported all the classes contained are available
                string fileName = item.Type.Replace(".", dirSeparator) + ".hx";
                
                if (fileName.StartsWith("flash" + dirSeparator) && (!IsFlashTarget || majorVersion > 8)) // flash9 remap
                    fileName = "flash9" + fileName.Substring(5);

                foreach (PathModel aPath in classPath) 
                    if (aPath.IsValid && !aPath.Updating)
                    {
                        string path;
                        try {
                            path = Path.Combine(aPath.Path, fileName);
                        }
                        catch { continue; }

                        FileModel file = null;
                        // cached file
                        if (aPath.HasFile(path))
                        {
                            file = aPath.GetFile(path);
                            if (file.Context != this)
                            {
                                // not associated with this context -> refresh
                                file.OutOfDate = true;
                                file.Context = this;
                            }
                        }
                        else if (File.Exists(path))
                        {
                            file = GetFileModel(path);
                            if (file != null)
                                aPath.AddFile(file);
                        }
                        if (file != null)
                            foreach (ClassModel c in file.Classes)
                                if (c.IndexType == null)
                                    imports.Add(c);
                    }
            }
            return imports;
        }

        /// <summary>
        /// Check if a type is already in the file's imports
        /// Throws an Exception if the type name is ambiguous 
        /// (ie. same name as an existing import located in another package)
        /// </summary>
        /// <param name="member">Element to search in imports</param>
        /// <param name="atLine">Position in the file</param>
        public override bool IsImported(MemberModel member, int atLine)
        {
            int p = member.Name.IndexOf('#');
            if (p > 0)
            {
                member = member.Clone() as MemberModel;
                member.Name = member.Name.Substring(0, p);
            }

            FileModel cFile = ASContext.Context.CurrentModel;
            string fullName = member.Type;
            string name = member.Name;
            int lineMin = (ASContext.Context.InPrivateSection) ? cFile.PrivateSectionIndex : 0;
            int lineMax = atLine;
            foreach (MemberModel import in cFile.Imports)
            {
                if (import.LineFrom >= lineMin && import.LineFrom <= lineMax && import.Name == name)
                {
                    if (import.Type != fullName) throw new Exception(TextHelper.GetString("Info.AmbiguousType"));
                    return true;
                }
                else if (import.Name == "*" && import.Type.Replace("*", name) == fullName)
                    return true;
            }
            return false;
        }

        /// <summary>
		/// Retrieves a class model from its name
		/// </summary>
		/// <param name="cname">Class (short or full) name</param>
		/// <param name="inClass">Current file</param>
		/// <returns>A parsed class or an empty ClassModel if the class is not found</returns>
        public override ClassModel ResolveType(string cname, FileModel inFile)
        {
            // handle generic types
            if (cname != null && cname.IndexOf('<') > 0)
            {
                Match genType = re_genericType.Match(cname);
                if (genType.Success)
                    return ResolveGenericType(genType.Groups["gen"].Value + "<T>", genType.Groups["type"].Value, inFile);
                else return ClassModel.VoidClass;
            }
            return base.ResolveType(cname, inFile);
        }

        /// <summary>
        /// Retrieve/build typed copies of generic types
        /// </summary>
        private ClassModel ResolveGenericType(string baseType, string indexType, FileModel inFile)
        {
            ClassModel aClass = base.ResolveType(baseType, inFile);
            if (aClass.IsVoid()) return aClass;

            if (aClass.QualifiedName == "Dynamic<T>")
            {
                ClassModel indexClass = ResolveType(indexType, inFile);
                if (!indexClass.IsVoid()) return indexClass;
                return MakeCustomObjectClass(aClass, indexType);
            }

            FileModel aFile = aClass.InFile;
            // is the type already cloned?
            foreach (ClassModel otherClass in aFile.Classes)
                if (otherClass.IndexType == indexType) return otherClass;

            // clone the type
            aClass = aClass.Clone() as ClassModel;

            aClass.Name = baseType.Substring(baseType.LastIndexOf('.') + 1) + "@" + indexType;
            aClass.IndexType = indexType;

            string typed = "<" + indexType + ">";
            foreach (MemberModel member in aClass.Members)
            {
                if (member.Name == baseType) member.Name = baseType.Replace("<T>", typed);
                if (member.Type != null && member.Type.IndexOf('T') >= 0)
                {
                    if (member.Type == "T") member.Type = indexType;
                    else member.Type = member.Type.Replace("<T>", typed);
                }
                if (member.Parameters != null)
                {
                    foreach (MemberModel param in member.Parameters)
                    {
                        if (param.Type != null && param.Type.IndexOf('T') >= 0)
                        {
                            if (param.Type == "T") param.Type = indexType;
                            else
                            {
                                param.Type = param.Type.Replace("<T>", typed);
                                if (param.Type.IndexOf('-') > 0)
                                {
                                    param.Type = Regex.Replace(param.Type, "T\\s?->", indexType + " ->");
                                    param.Type = Regex.Replace(param.Type, "->\\s?T", "-> " + indexType);
                                }
                            }
                        }
                    }
                }
            }

            aFile.Classes.Add(aClass);
            return aClass;
        }

        /// <summary>
        /// Prepare haXe intrinsic known vars/methods/classes
        /// </summary>
        protected override void InitTopLevelElements()
        {
            string filename = "toplevel.hx";
            topLevel = new FileModel(filename);

            // search top-level declaration
            foreach (PathModel aPath in classPath)
                if (File.Exists(Path.Combine(aPath.Path, filename)))
                {
                    filename = Path.Combine(aPath.Path, filename);
                    topLevel = GetCachedFileModel(filename);
                    break;
                }

            if (File.Exists(filename))
            {
                // copy declarations as file-level
                ClassModel tlClass = topLevel.GetPublicClass();
                if (!tlClass.IsVoid())
                {
                    topLevel.Members = tlClass.Members;
                    tlClass.Members = null;
                    topLevel.Classes = new List<ClassModel>();
                }
            }
            // not found
            else
            {
                //ErrorHandler.ShowInfo("Top-level elements class not found. Please check your Program Settings.");
            }

            topLevel.Members.Add(new MemberModel("this", "", FlagType.Variable, Visibility.Public));
            topLevel.Members.Add(new MemberModel("super", "", FlagType.Variable, Visibility.Public));
            //topLevel.Members.Add(new MemberModel("Void", "", FlagType.Intrinsic, Visibility.Public));
            topLevel.Members.Sort();
            foreach (MemberModel member in topLevel.Members)
                member.Flags |= FlagType.Intrinsic;
        }

        /// <summary>
        /// Retrieves a package content
        /// </summary>
        /// <param name="name">Package path</param>
        /// <param name="lazyMode">Force file system exploration</param>
        /// <returns>Package folders and types</returns>
        public override FileModel ResolvePackage(string name, bool lazyMode)
        {
            if ((settings.LazyClasspathExploration || lazyMode) && majorVersion >= 9 && name == "flash") 
                name = "flash9";
            return base.ResolvePackage(name, lazyMode);
        }
        #endregion

        #region Custom code completion

        private IHaxeCompletionHandler completionModeHandler;

        /// <summary>
        /// Checks completion mode changes to start/restart/stop the haXe completion server if needed.
        /// </summary>
        private void OnCompletionModeChange()
        {
            if (completionModeHandler != null)
            {
                completionModeHandler.Stop();
                completionModeHandler = null;
            }

            var haxeSettings = (settings as HaXeSettings);
            switch (haxeSettings.CompletionMode)
            {
                case HaxeCompletionModeEnum.Compiler:
                    completionModeHandler = new CompilerCompletionHandler(createHaxeProcess(""));
                    break;
                case HaxeCompletionModeEnum.CompletionServer:
                    if (haxeSettings.CompletionServerPort < 1024)
                        completionModeHandler = new CompilerCompletionHandler(createHaxeProcess(""));
                    else 
                        completionModeHandler =
                            new CompletionServerCompletionHandler(
                                createHaxeProcess("--wait " + haxeSettings.CompletionServerPort),
                                haxeSettings.CompletionServerPort);
                    break;
            }
        }

        /**
         * Starts a haxe.exe process with the given arguments.
         */
        private Process createHaxeProcess(string args)
        {
            // compiler path
            var hxPath = currentSDK; 
            var process = Path.Combine(hxPath, "haxe.exe");
            if (!File.Exists(process))
            {
                ErrorManager.ShowInfo(String.Format(TextHelper.GetString("Info.HaXeExeError"), "\n"));
                return null;
            }

            // Run haxe compiler
            Process proc = new Process();
            proc.StartInfo.FileName = process;
            proc.StartInfo.Arguments = args;
            proc.StartInfo.UseShellExecute = false;
            proc.StartInfo.RedirectStandardError = true;
            proc.StartInfo.CreateNoWindow = true;
            proc.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
            proc.EnableRaisingEvents = true;
            return proc;
        }

        /// <summary>
        /// Let contexts handle code completion
        /// </summary>
        /// <param name="sci">Scintilla control</param>
        /// <param name="expression">Completion context</param>
        /// <param name="autoHide">Auto-started completion (is false when pressing Ctrl+Space)</param>
        /// <returns>Null (not handled) or member list</returns>
        public override MemberList ResolveDotContext(ScintillaNet.ScintillaControl sci, ASExpr expression, bool autoHide)
        {
            if (hxsettings.CompletionMode == HaxeCompletionModeEnum.FlashDevelop)
                return null;

            if (autoHide && !hxsettings.DisableCompletionOnDemand)
                return null;

            // auto-started completion, can be ignored for performance (show default completion tooltip)
            if (expression.Value.IndexOf(".") < 0 || (autoHide && !expression.Value.EndsWith(".")))
                if (hxsettings.DisableMixedCompletion) return new MemberList();
                else return null;

            // empty expression
            if (expression.Value == "")
                return null; // not supported yet

            MemberList list = new MemberList();
           
            HaXeCompletion hc = new HaXeCompletion(sci, expression.Position, completionModeHandler);
            ArrayList al = hc.getList();
            if (al == null || al.Count == 0) 
                return null; // haxe.exe not found
            
            string outputType = al[0].ToString();

            if( outputType == "error" )
            {
                string err = al[1].ToString();
                sci.CallTipShow(sci.CurrentPos, err);
                sci.CharAdded += new ScintillaNet.CharAddedHandler(removeTip);
                
                // show default completion tooltip
                if (!hxsettings.DisableMixedCompletion)
                    return null;
            }
            else if (outputType == "list")
            {
                foreach (ArrayList i in al[ 1 ] as ArrayList)
                {
                    string var = i[0].ToString();
                    string type = i[1].ToString();
                    string desc = i[2].ToString();

                    FlagType flag = FlagType.Variable;

                    MemberModel member = new MemberModel();
                    member.Name = var;
                    member.Access = Visibility.Public;
                    member.Comments = desc;
                    
                    // Package or Class
                    if (type == "")
                    {
                        string bl = var.Substring( 0, 1 );
                        if (bl == bl.ToLower())
                            flag = FlagType.Package;
                        else
                            flag = FlagType.Class;
                    }
                    // Function or Variable
                    else
                    {
                        Array types = type.Split(new string[] { "->" }, StringSplitOptions.RemoveEmptyEntries);

                        // Function
                        if (types.Length > 1)
                        {
                            flag = FlagType.Function;

                            // Function's arguments
                            member.Parameters = new List<MemberModel>();
                            int j = 0;
                            while (j < types.Length - 1)
                            {
                                MemberModel param = new MemberModel(types.GetValue(j).ToString(), "", FlagType.ParameterVar, Visibility.Public);
                                member.Parameters.Add(param);
                                j++;
                            }

                            // Function's return type
                            member.Type = types.GetValue(types.Length - 1).ToString();
                        }
                        // Variable
                        else
                        {
                            flag = FlagType.Variable;
                            // Variable's type
                            member.Type = type;
                        }    
                       
                    }
                                        
                    member.Flags = flag;
                    
                   list.Add(member);
                }
            }
            return list;
        }

        public override MemberList GetVisibleExternalElements(bool typesOnly)
        {
            MemberList visibleElements = new MemberList();
            if (!IsFileValid) return visibleElements;

            // top-level elements
            if (!typesOnly && topLevel != null)
            {
                if (topLevel.OutOfDate) InitTopLevelElements();
                visibleElements.Add(topLevel.Members);
            }

            if (completionCache.IsDirty || !typesOnly)
            {
                MemberList elements = new MemberList();
                // root types & packages
                FileModel baseElements = ResolvePackage(null, false);
                if (baseElements != null)
                {
                    elements.Add(baseElements.Imports);
                    foreach(MemberModel decl in baseElements.Members)
                        if ((decl.Flags & (FlagType.Class | FlagType.Enum | FlagType.TypeDef)) > 0)
                            elements.Add(decl);
                }
                elements.Add(new MemberModel(features.voidKey, features.voidKey, FlagType.Class | FlagType.Intrinsic, 0));

                bool qualify = Settings.CompletionShowQualifiedTypes && settings.GenerateImports;

                // other classes in same package
                if (features.hasPackages && cFile.Package != "")
                {
                    FileModel packageElements = ResolvePackage(cFile.Package, false);
                    if (packageElements != null)
                    {
                        foreach (MemberModel member in packageElements.Imports)
                        {
                            if (member.Flags != FlagType.Package)
                            {
                                if (qualify) member.Name = member.Type;
                                elements.Add(member);
                            }
                        }
                        foreach (MemberModel member in packageElements.Members)
                        {
                            string pkg = member.InFile.Package;
                            if (qualify && pkg != "") member.Name = pkg + "." + member.Name;
                            elements.Add(member);
                        }
                    }
                }
                // other types in same file
                if (cFile.Classes.Count > 1)
                {
                    ClassModel mainClass = cFile.GetPublicClass();
                    foreach (ClassModel aClass in cFile.Classes)
                    {
                        if (mainClass == aClass) continue;
                        elements.Add(aClass.ToMemberModel());
                        if (!typesOnly && aClass.IsEnum())
                            elements.Add(aClass.Members);
                    }
                }

                // imports
                MemberList imports = ResolveImports(CurrentModel);
                elements.Add(imports);
                if (!typesOnly)
                    foreach (MemberModel import in imports)
                    {
                        if (import is ClassModel)
                        {
                            ClassModel aClass = import as ClassModel;
                            if (aClass.IsEnum()) elements.Add(aClass.Members);
                        }
                    }
                elements.Sort();

                // in cache
                if (typesOnly)
                {
                    completionCache = new CompletionCache(this, elements);
                    // known classes colorization
                    if (!CommonSettings.DisableKnownTypesColoring && !settings.LazyClasspathExploration && CurSciControl != null)
                    {
                        try
                        {
                            CurSciControl.KeyWords(1, completionCache.Keywords); // additional-keywords index = 1
                            CurSciControl.Colourise(0, -1); // re-colorize the editor
                        }
                        catch (AccessViolationException) { } // catch memory errors
                    }
                }
                visibleElements.Merge(elements);
            }
            else
                visibleElements.Merge(completionCache.Elements);
            return visibleElements;
        }

        /// <summary>
        /// Let contexts handle code completion
        /// </summary>
        /// <param name="sci">Scintilla control</param>
        /// <param name="expression">Completion context</param>
        /// <returns>Null (not handled) or function signature</returns>
        public override MemberModel ResolveFunctionContext(ScintillaNet.ScintillaControl sci, ASExpr expression, bool autoHide)
        {
            if (hxsettings.CompletionMode == HaxeCompletionModeEnum.FlashDevelop)
                return null;

            if (autoHide && !hxsettings.DisableCompletionOnDemand)
                return null;

            string[] parts = expression.Value.Split('.');
            string name = parts[parts.Length - 1];
            
            MemberModel member = new MemberModel();

            // Do not show error
            string val = expression.Value;
            if (val == "for" || 
                val == "while" ||
                val == "if" ||
                val == "switch" ||
                val == "function" ||
                val == "catch" ||
                val == "trace")
                return null;

            HaXeCompletion hc = new HaXeCompletion(sci, expression.Position, completionModeHandler);
            ArrayList al = hc.getList();
            if (al == null || al.Count == 0)
                return null; // haxe.exe not found

            string outputType = al[0].ToString();

            if (outputType == "type" )
            {
                member.Name = name;
                member.Flags = FlagType.Function;
                member.Access = Visibility.Public;

                string type = al[1].ToString();

                Array types = type.Split(new string[] { "->" }, StringSplitOptions.RemoveEmptyEntries);

                // Function's arguments
                member.Parameters = new List<MemberModel>();
                int j = 0;
                while (j < types.Length - 1)
                {
                    MemberModel param = new MemberModel(types.GetValue(j).ToString(), "", FlagType.ParameterVar, Visibility.Public);
                    member.Parameters.Add(param);
                    j++;
                }
                // Function's return type
                member.Type = types.GetValue(types.Length - 1).ToString();
            }
            else if ( outputType == "error" )
            {
                string err = al[1].ToString();
                sci.CallTipShow(sci.CurrentPos, err);
                sci.CharAdded += new ScintillaNet.CharAddedHandler(removeTip);
            }
                        
            return member;
        }

        void removeTip(ScintillaNet.ScintillaControl sender, int ch)
        {
            sender.CallTipCancel();
            sender.CharAdded -= removeTip;
        }
        #endregion

        #region command line compiler

        static public string TemporaryOutputFile;

        /// <summary>
        /// Retrieve the context's default compiler path
        /// </summary>
        public override string GetCompilerPath()
        {
            return hxsettings.GetDefaultSDK().Path;
        }

        /// <summary>
        /// Check current file's syntax
        /// </summary>
        public override void CheckSyntax()
        {
            EventManager.DispatchEvent(this, new NotifyEvent(EventType.ProcessStart));
            HaXeCompletion hc = new HaXeCompletion(ASContext.CurSciControl, 0, completionModeHandler);
            ArrayList result = hc.getList();
            if (result.Count == 0 || (string)result[0] != "error")
            {
                EventManager.DispatchEvent(this, new TextEvent(EventType.ProcessEnd, "Done(0)"));
                return;
            }
            foreach (string line in result)
            {
                if (line != "error") TraceManager.Add(line);
            }
            EventManager.DispatchEvent(this, new TextEvent(EventType.ProcessEnd, "Done(1)"));
        }

        /// <summary>
        /// Run haXe compiler in the current class's base folder with current classpath
        /// </summary>
        /// <param name="append">Additional comiler switches</param>
        public override void RunCMD(string append)
        {
            if (!IsFileValid || !File.Exists(CurrentFile))
                return;

            string haxePath = PathHelper.ResolvePath(hxsettings.GetDefaultSDK().Path);
            if (!Directory.Exists(haxePath) && !File.Exists(haxePath))
            {
                ErrorManager.ShowInfo(TextHelper.GetString("Info.InvalidHaXePath"));
                return;
            }

            SetStatusText(settings.CheckSyntaxRunning);

            try
            {
                // save modified files if needed
                if (outputFile != null) MainForm.CallCommand("SaveAllModified", null);
                else MainForm.CallCommand("SaveAllModified", ".hx");

                // change current directory
                string currentPath = System.IO.Directory.GetCurrentDirectory();
                string filePath = (temporaryPath == null) ? Path.GetDirectoryName(cFile.FileName) : temporaryPath;
                filePath = NormalizePath(filePath);
                System.IO.Directory.SetCurrentDirectory(filePath);
                
                // prepare command
                string command = haxePath;
                if (Path.GetExtension(command) == "") command = Path.Combine(command, "haxe.exe");

                command += ";";
                if (cFile.Package.Length > 0) command += cFile.Package+".";
                string cname = cFile.GetPublicClass().Name;
                if (cname.IndexOf('<') > 0) cname = cname.Substring(0, cname.IndexOf('<'));
                command += cname;

                if (IsFlashTarget && (append == null || append.IndexOf("-swf-version") < 0)) 
                    command += " -swf-version " + majorVersion;
                // classpathes
                string hxPath = PathHelper.ResolvePath(hxsettings.GetDefaultSDK().Path);
                foreach (PathModel aPath in classPath)
                    if (aPath.Path != temporaryPath
                        && !aPath.Path.StartsWith(hxPath, StringComparison.OrdinalIgnoreCase))
                        command += " -cp \"" + aPath.Path.TrimEnd('\\') + "\"";
                command = command.Replace(filePath, "");

                // run
                MainForm.CallCommand("RunProcessCaptured", command + " " + append);
                // restaure current directory
                if (System.IO.Directory.GetCurrentDirectory() == filePath)
                    System.IO.Directory.SetCurrentDirectory(currentPath);
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Calls RunCMD with additional parameters taken from the classes @haxe doc tag
        /// </summary>
        public override bool BuildCMD(bool failSilently)
        {
            if (!File.Exists(CurrentFile))
                return false;
            // check if @haxe is defined
            Match mCmd = null;
            ClassModel cClass = cFile.GetPublicClass();
            if (IsFileValid)
            {
                if (cFile.Comments != null)
                    mCmd = re_CMD_BuildCommand.Match(cFile.Comments);
                if ((mCmd == null || !mCmd.Success) && cClass.Comments != null)
                    mCmd = re_CMD_BuildCommand.Match(cClass.Comments);
            }

            if (mCmd == null || !mCmd.Success)
            {
                if (!failSilently)
                {
                    MessageBar.ShowWarning(TextHelper.GetString("Info.InvalidForQuickBuild"));
                }
                return false;
            }

            // build command
            string command = mCmd.Groups["params"].Value.Trim();
            try
            {
                command = Regex.Replace(command, "[\\r\\n]\\s*\\*", "", RegexOptions.Singleline);
                command = " " + MainForm.ProcessArgString(command) + " ";
                if (command == null || command.Length == 0)
                {
                    if (!failSilently)
                        throw new Exception(TextHelper.GetString("Info.InvalidQuickBuildCommand"));
                    return false;
                }
                outputFile = null;
                outputFileDetails = "";
                trustFileWanted = false;

                // get some output information url
                MatchCollection mPar = re_SplitParams.Matches(command + "-eof");
                int mPlayIndex = -1;
                bool noPlay = false;
                if (mPar.Count > 0)
                {
                    string op;
                    for (int i = 0; i < mPar.Count; i++)
                    {
                        op = mPar[i].Groups["switch"].Value;
                        int start = mPar[i].Index + mPar[i].Length;
                        int end = (mPar.Count > i + 1) ? mPar[i + 1].Index : start;
                        if ((op == "-swf") && (outputFile == null) && (mPlayIndex < 0))
                        {
                            if (end > start)
                                outputFile = command.Substring(start, end - start).Trim();
                        }
                        else if (op == "-swf-header")
                        {
                            if (end > start)
                            {
                                string[] dims = command.Substring(start, end - start).Trim().Split(':');
                                if (dims.Length > 2) outputFileDetails = ";" + dims[0] + ";" + dims[1];
                            }
                        }
                        else if (op == "-play")
                        {
                            if (end > start)
                            {
                                mPlayIndex = i;
                                outputFile = command.Substring(start, end - start).Trim();
                            }
                        }
                        else if (op == "-trust")
                        {
                            trustFileWanted = true;
                        }
                        else if (op == "-noplay")
                        {
                            noPlay = true;
                        }
                    }
                }
                if (outputFile != null && outputFile.Length == 0) outputFile = null;

                // cleaning custom switches
                if (mPlayIndex >= 0)
                {
                    command = command.Substring(0, mPar[mPlayIndex].Index) + command.Substring(mPar[mPlayIndex + 1].Index);
                }
                if (trustFileWanted)
                {
                    command = command.Replace("-trust", "");
                }
                if (noPlay || !settings.PlayAfterBuild)
                {
                    command = command.Replace("-noplay", "");
                    outputFile = null;
                    runAfterBuild = false;
                }
                else runAfterBuild = (outputFile != null);
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return false;
            }

            // run
            RunCMD(command);
            return true;
        }

        public bool NmeRun(string config)
        {
            HaxeProject project = PluginBase.CurrentProject as HaxeProject;
            if (project == null || project.OutputType != OutputType.Application) 
                return false;

            string compiler = project.CurrentSDK;
            if (compiler == null) compiler = "haxelib";
            else if (Directory.Exists(compiler)) compiler = Path.Combine(compiler, "haxelib.exe");
            else compiler = compiler.Replace("haxe.exe", "haxelib.exe");

            if (String.IsNullOrEmpty(config)) config = "flash";
            else if (config.IndexOf("android") >= 0) CheckADB();
            if (project.TraceEnabled) config += " -debug";

            if (config.StartsWith("flash") && config.IndexOf("-DSWF_PLAYER") < 0)
                config += GetSwfPlayer();
            
            string args = "run nme run \"" + project.OutputPathAbsolute + "\" " + config;
            string oldWD = MainForm.WorkingDirectory;
            MainForm.WorkingDirectory = project.Directory;
            MainForm.CallCommand("RunProcessCaptured", compiler + ";" + args);
            MainForm.WorkingDirectory = oldWD;
            return true;
        }

        private void CheckADB()
        {
            if (Process.GetProcessesByName("adb").Length > 0) 
                return;

            string adb = Environment.ExpandEnvironmentVariables("%ANDROID_SDK%/platform-tools");
            if (adb.StartsWith("%") || !Directory.Exists(adb)) 
                adb = Path.Combine(PathHelper.ToolDir, "android/platform-tools");
            if (Directory.Exists(adb)) 
            {
                adb = Path.Combine(adb, "adb.exe");
                ProcessStartInfo p = new ProcessStartInfo(adb, "get-state");
                p.UseShellExecute = true;
                p.WindowStyle = ProcessWindowStyle.Hidden;
                Process.Start(p);
            }
        }

        private string GetSwfPlayer()
        {
            DataEvent de = new DataEvent(EventType.Command, "FlashViewer.GetFlashPlayer", null);
            EventManager.DispatchEvent(this, de);
            if (de.Handled && !String.IsNullOrEmpty((string)de.Data)) return " -DSWF_PLAYER=\"" + de.Data + "\"";
            else return "";
        }
        #endregion

    }
}
