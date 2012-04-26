using System;
using System.IO;
using System.Drawing;
using System.Collections;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Windows.Forms;
using System.ComponentModel;
using PluginCore.Helpers;
using PluginCore.Managers;
using PluginCore.Utilities;
using PluginCore.Controls;
using PluginCore.Localization;
using ScintillaNet.Configuration;
using ScintillaNet;
using PluginCore;

namespace BasicCompletion
{
	public class PluginMain : IPlugin
	{
        private String pluginName = "BasicCompletion";
        private String pluginGuid = "c5564dec-5288-4bbb-b286-a5678536698b";
        private String pluginHelp = "www.flashdevelop.org/community/";
        private String pluginDesc = "Adds global basic code completion support to FlashDevelop.";
        private String pluginAuth = "FlashDevelop Team";
        private Hashtable keywordTable = new Hashtable();
        private String settingFilename;
        private Settings settingObject;

	    #region Required Properties

        /// <summary>
        /// Api level of the plugin
        /// </summary>
        public Int32 Api
        {
            get { return 1; }
        }

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
                case EventType.Keys:
                {
                    Keys keys = (e as KeyEvent).Value;
                    ITabbedDocument document = PluginBase.MainForm.CurrentDocument;
                    if (document == null && !document.IsEditable) return;
                    if (this.IsSupported(document) && keys == (Keys.Control | Keys.Space))
                    {
                        String lang = document.SciControl.ConfigurationLanguage.ToLower();
                        List<ICompletionListItem> items = this.keywordTable[lang] as List<ICompletionListItem>;
                        if (items != null && items.Count > 0)
                        {
                            items.Sort();
                            CompletionList.Show(items, false);
                            e.Handled = true;
                        }
                    }
                    else if (this.IsSupported(document) && keys == (Keys.Control | Keys.Alt | Keys.Space))
                    {
                        PluginBase.MainForm.CallCommand("InsertSnippet", "null");
                        e.Handled = true;
                    }
                    break;
                }
                case EventType.FileSwitch:
                case EventType.SyntaxChange:
                case EventType.ApplySettings:
                {
                    ITabbedDocument document = PluginBase.MainForm.CurrentDocument;
                    if (document != null && document.IsEditable && this.IsSupported(document))
                    {
                        String language = document.SciControl.ConfigurationLanguage.ToLower();
                        if (!this.keywordTable.ContainsKey(language))
                        {
                            this.AddKeywords(language);
                            UITools.Manager.OnCharAdded += new UITools.CharAddedHandler(this.SciControlCharAdded);
                        }
                    }
                    break;
                }
            }
		}

		#endregion

        #region Custom Methods
       
        /// <summary>
        /// Initializes important variables
        /// </summary>
        public void InitBasics()
        {
            String dataPath = Path.Combine(PathHelper.DataDir, "BasicCompletion");
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
            this.pluginDesc = TextHelper.GetString("Info.Description");
        }

        /// <summary>
        /// Adds the required event handlers
        /// </summary> 
        public void AddEventHandlers()
        {
            EventType eventTypes = EventType.Keys | EventType.ApplySettings | EventType.SyntaxChange | EventType.FileSwitch;
            EventManager.AddEventHandler(this, eventTypes);
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
        }

        /// <summary>
        /// Saves the plugin settings
        /// </summary>
        public void SaveSettings()
        {
            ObjectSerializer.Serialize(this.settingFilename, this.settingObject);
        }

        /// <summary>
        /// Shows the completion list after typing three chars
        /// </summary>
        private void SciControlCharAdded(ScintillaControl sci, Int32 value)
        {
            String lang = sci.ConfigurationLanguage.ToLower();
            List<ICompletionListItem> items = this.keywordTable[lang] as List<ICompletionListItem>;
            if (items != null && items.Count > 0)
            {
                items.Sort();
                String curWord = sci.GetWordFromPosition(sci.CurrentPos);
                if (curWord != null && curWord.Length > 2 && !Char.IsWhiteSpace((char)value))
                {
                    CompletionList.Show(items, false, curWord);
                }
            }
        }

        /// <summary>
        /// Adds keywords from config file to hashtable
        /// </summary>
        public void AddKeywords(String language)
        {
            List<String> keywords = new List<String>();
            Language lang = ScintillaControl.Configuration.GetLanguage(language);
            for (Int32 i = 0; i < lang.usekeywords.Length; i++)
            {
                UseKeyword usekeyword = lang.usekeywords[i];
                KeywordClass kc = ScintillaControl.Configuration.GetKeywordClass(usekeyword.cls);
                if (kc != null)
                {
                    String entry = Regex.Replace(kc.val, @"\t|\n|\r", "");
                    String[] words = entry.Split(new char[]{' '}, StringSplitOptions.RemoveEmptyEntries);
                    for (Int32 j = 0; j < words.Length; j++) keywords.Add(words[j]);
                }
            }
            keywords = this.RemoveDuplicates(keywords);
            List<ICompletionListItem> items = new List<ICompletionListItem>();
            for (Int32 k = 0; k < keywords.Count; k++)
            {
                if (!keywords[k].StartsWith("\x5E")) items.Add(new CompletionItem(keywords[k]));
            }
            this.keywordTable.Add(language, items);
        }

        /// <summary>
        /// Removes duplicates from a list and returns a new one
        /// </summary>
        public List<String> RemoveDuplicates(List<String> input)
        {
            List<String> result = new List<String>();
            foreach (String entry in input)
            {
                if (!result.Contains(entry)) result.Add(entry);
            }
            return result;
        }

        /// <summary>
        /// Checks if the language should use basic completion 
        /// </summary>
        public Boolean IsSupported(ITabbedDocument document)
        {
            String lang = document.SciControl.ConfigurationLanguage;
            return this.settingObject.EnabledLanguages.Contains(lang);
        }

		#endregion

	}

    #region Extra Classes

    /// <summary>
    /// Simple completion list item
    /// </summary>
    public class CompletionItem : ICompletionListItem, IComparable, IComparable<ICompletionListItem>
    {
        private string label;
        public CompletionItem(string label)
        {
            this.label = label;
        }
        public string Label
        {
            get { return label; }
        }
        public string Description
        {
            get { return TextHelper.GetString("Info.CompletionItemDesc"); }
        }
        public System.Drawing.Bitmap Icon
        {
            get { return (System.Drawing.Bitmap)PluginBase.MainForm.FindImage("315"); }
        }
        public string Value
        {
            get { return label; }
        }
        Int32 IComparable.CompareTo(Object obj)
        {
            return String.Compare(Label, (obj as ICompletionListItem).Label, true);
        }
        Int32 IComparable<ICompletionListItem>.CompareTo(ICompletionListItem other)
        {
            return String.Compare(Label, other.Label, true);
        }
    }

    #endregion

}
