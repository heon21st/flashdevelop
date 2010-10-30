﻿using System;
using System.Collections.Generic;
using System.Text;
using System.Drawing.Design;
using System.Windows.Forms.Design;
using System.ComponentModel;
using PluginCore.Localization;

namespace PHPContext
{
    public delegate void ClasspathChangedEvent();

    [Serializable]
    public class ContextSettings : ASCompletion.Settings.IContextSettings
    {
        public event ClasspathChangedEvent OnClasspathChanged;

        #region IContextSettings Documentation

        const string LANGUAGE_WEBSITE = "http://php.net/manual";
        const string DEFAULT_DOC_COMMAND = 
            "http://www.google.com/search?q=$(ItmTypPkg)+$(ItmTypName)+$(ItmName)+site:" + LANGUAGE_WEBSITE;
        protected string documentationCommandLine = DEFAULT_DOC_COMMAND;

        [DisplayName("Documentation Command Line")]
        [LocalizedCategory("ASCompletion.Category.Documentation"), LocalizedDescription("ASCompletion.Description.DocumentationCommandLine"), DefaultValue(DEFAULT_DOC_COMMAND)]
        public string DocumentationCommandLine
        {
            get { return documentationCommandLine; }
            set { documentationCommandLine = value; }
        }

        #endregion

        #region IContextSettings Members

        const bool DEFAULT_CHECKSYNTAX = false;
        const bool DEFAULT_COMPLETIONENABLED = true;
        const bool DEFAULT_GENERATEIMPORTS = false;
        const bool DEFAULT_PLAY = false;
        const bool DEFAULT_LAZYMODE = false;
        const bool DEFAULT_LISTALL = true;
        const bool DEFAULT_QUALIFY = true;

        protected bool checkSyntaxOnSave = DEFAULT_CHECKSYNTAX;
        private bool lazyClasspathExploration = DEFAULT_LAZYMODE;
        protected bool completionListAllTypes = DEFAULT_LISTALL;
        protected bool completionShowQualifiedTypes = DEFAULT_QUALIFY;
        protected bool completionEnabled = DEFAULT_COMPLETIONENABLED;
        protected bool generateImports = DEFAULT_GENERATEIMPORTS;
        protected bool playAfterBuild = DEFAULT_PLAY;
        protected string[] userClasspath = null;

        [Browsable(false)]
        public string LanguageId
        {
            get { return "PHP"; }
        }

        [Browsable(false)]
        public string DefaultExtension
        {
            get { return ".php"; }
        }

        [Browsable(false)]
        public string CheckSyntaxRunning
        {
            get { return LanguageId  + " Running"; }
        }

        [Browsable(false)]
        public string CheckSyntaxDone
        {
            get { return LanguageId + " Done"; }
        }

        [DisplayName("Check Syntax On Save")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.CheckSyntaxOnSave"), DefaultValue(DEFAULT_CHECKSYNTAX)]
        public bool CheckSyntaxOnSave
        {
            get { return checkSyntaxOnSave; }
            set { checkSyntaxOnSave = value; }
        }

        [DisplayName("User Classpath")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.UserClasspath")]
        public string[] UserClasspath
        {
            get { return userClasspath; }
            set
            {
                userClasspath = value;
                FireChanged();
            }
        }

        [DisplayName("Enable Completion")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.CompletionEnabled"), DefaultValue(DEFAULT_COMPLETIONENABLED)]
        public bool CompletionEnabled
        {
            get { return completionEnabled; }
            set { completionEnabled = value; }
        }

        [DisplayName("Generate Imports")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.GenerateImports"), DefaultValue(DEFAULT_GENERATEIMPORTS)]
        public bool GenerateImports
        {
            get { return generateImports; }
            set { generateImports = value; }
        }

        /// <summary>
        /// In completion, show all known types in project
        /// </summary>
        [DisplayName("List All Types In Completion")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.CompletionListAllTypes"), DefaultValue(DEFAULT_LISTALL)]
        public bool CompletionListAllTypes
        {
            get { return completionListAllTypes; }
            set { completionListAllTypes = value; }
        }

        /// <summary>
        /// In completion, show qualified type names (package + type)
        /// </summary>
        [DisplayName("Show QualifiedTypes In Completion")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.CompletionShowQualifiedTypes"), DefaultValue(DEFAULT_QUALIFY)]
        public bool CompletionShowQualifiedTypes
        {
            get { return completionShowQualifiedTypes; }
            set { completionShowQualifiedTypes = value; }
        }

        /// <summary>
        /// Defines if each classpath is explored immediately (PathExplorer) 
        /// </summary>
        [DisplayName("Lazy Classpath Exploration")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.LazyClasspathExploration"), DefaultValue(DEFAULT_LAZYMODE)]
        public bool LazyClasspathExploration
        {
            get { return lazyClasspathExploration; }
            set { lazyClasspathExploration = value; }
        }

        [DisplayName("Play After Build")]
        [LocalizedCategory("ASCompletion.Category.Common"), LocalizedDescription("ASCompletion.Description.PlayAfterBuild"), DefaultValue(DEFAULT_PLAY)]
        public bool PlayAfterBuild
        {
            get { return playAfterBuild; }
            set { playAfterBuild = value; }
        }

        #endregion

        #region Language specific members

        private string intrinsicPath;

        [DisplayName("Intrinsic Definitions")]
        [LocalizedCategory("ASCompletion.Category.Language"), LocalizedDescription("PHPContext.Description.IntrinsicDefinitions")]
        public string LanguageDefinitions
        {
            get { return intrinsicPath; }
            set
            {
                if (value == intrinsicPath) return;
                intrinsicPath = value;
                FireChanged();
            }
        }

        #endregion

        [Browsable(false)]
        private void FireChanged()
        {
            if (OnClasspathChanged != null) OnClasspathChanged();
        }
    }
}