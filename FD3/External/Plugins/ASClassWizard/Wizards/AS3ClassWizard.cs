﻿
#region Imports
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.IO;
using System.Windows.Forms;
using System.Text.RegularExpressions;

using PluginCore;
using ProjectManager.Projects;

using ASClassWizard.Wizards;
using ASClassWizard.Resources;

using ASCompletion.Context;
using ASCompletion.Model;

using AS3Context;
using AS2Context;
using System.Reflection;
using System.Diagnostics;
#endregion


namespace ASClassWizard.Wizards
{
    public partial class AS3ClassWizard : Form
    {
        private string directoryPath;
        private Project project;
        public const string REG_IDENTIFIER = "^[a-zA-Z_$][a-zA-Z0-9_$]+$";

        public AS3ClassWizard()
        {
            InitializeComponent();
            LocalizeText();
            CenterToParent();

            this.errorIcon.Image = PluginMain.MainForm.FindImage("197");
        }

        private void LocalizeText()
        {
            this.errorIcon.Image = PluginBase.MainForm.FindImage("166");
            this.classLabel.Text = LocaleHelper.GetString("Wizard.Label.Name");
            this.accessLabel.Text = LocaleHelper.GetString("Wizard.Label.Modifiers");
            this.baseLabel.Text = LocaleHelper.GetString("Wizard.Label.SuperClass");
            this.implementLabel.Text = LocaleHelper.GetString("Wizard.Label.Interfaces");
            this.generationLabel.Text = LocaleHelper.GetString("Wizard.Label.CodeGeneration");
            this.implementBrowse.Text = LocaleHelper.GetString("Wizard.Button.Add");
            this.implementRemove.Text = LocaleHelper.GetString("Wizard.Button.Remove");
            this.constructorCheck.Text = LocaleHelper.GetString("Wizard.Label.GenerateConstructor");
            this.superCheck.Text = LocaleHelper.GetString("Wizard.Label.GenerateInherited");
            this.packageLabel.Text = LocaleHelper.GetString("Wizard.Label.Package");
            this.packageBrowse.Text = LocaleHelper.GetString("Wizard.Button.Browse");
            this.baseBrowse.Text = LocaleHelper.GetString("Wizard.Button.Browse");
            this.okButton.Text = LocaleHelper.GetString("Wizard.Button.Ok");
            this.cancelButton.Text = LocaleHelper.GetString("Wizard.Button.Cancel");
        }

        public String StartupPackage
        {
            set { packageBox.Text = value; }
        }

        public string Directory
        {
            get { return this.directoryPath; }
            set { this.directoryPath = value; }
        }

        public Project Project
        {
            get { return project; }
            set { 
                this.project = value;
                if (project.Language == "as2")
                {
                    this.publicRadio.Enabled = false;
                    this.internalRadio.Enabled = false;
                    this.finalCheck.Enabled = false;
                    this.titleLabel.Text = LocaleHelper.GetString("Wizard.Label.NewAs2Class");
                }
                else
                {
                    this.titleLabel.Text = LocaleHelper.GetString("Wizard.Label.NewAs3Class");
                }
            }
        }

        private void ValidateClass()
        {
            string errorMessage = "";

            if (getClassName() == "" || Regex.Match(getClassName(), REG_IDENTIFIER, RegexOptions.Singleline).Success == false)
                errorMessage = LocaleHelper.GetString("Wizard.Error.InvalidClassName");


            if (errorMessage != "")
            {
                okButton.Enabled = false;
                errorIcon.Visible = true;
            }
            else
            {
                okButton.Enabled = true;
                errorIcon.Visible = false;
            }

            this.errorLabel.Text = errorMessage;
        }

        #region EventHandlers

        /// <summary>
        /// Browse project packages
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void button3_Click(object sender, EventArgs e)
        {

            PackageBrowser browser = new PackageBrowser();
            browser.Project = this.Project;

            foreach (string item in Project.AbsoluteClasspaths)
                browser.AddClassPath(item);

            if (browser.ShowDialog(this) == DialogResult.OK)
            {
                if (browser.Package != null)
                {
                    string classpath = this.Project.AbsoluteClasspaths.GetClosestParent(browser.Package);
                    string package = Path.GetDirectoryName(ProjectPaths.GetRelativePath(classpath, Path.Combine(browser.Package, "foo")));
                    if (package != null)
                    {
                        directoryPath = browser.Package;
                        package = package.Replace(Path.DirectorySeparatorChar, '.');
                        this.packageBox.Text = package;
                    }
                }
                else
                {
                    this.directoryPath = browser.Project.Directory;
                    this.packageBox.Text = "";
                }
            }
        }

        private void AS3ClassWizard_Load(object sender, EventArgs e)
        {
            this.classBox.Select();
            this.ValidateClass();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.Cancel;
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.OK;
            this.Close();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            ClassBrowser browser = new ClassBrowser();
            IASContext context   = ASContext.GetLanguageContext(PluginBase.CurrentProject.Language);
            try
            {
                browser.ClassList = context.GetAllProjectClasses();
            }
            catch { }
            browser.ExcludeFlag  = FlagType.Interface;
            browser.IncludeFlag  = FlagType.Class;
            if (browser.ShowDialog(this) == DialogResult.OK)
            {
                this.baseBox.Text = browser.SelectedClass;
            }
        }

        /// <summary>
        /// Added interface
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void button5_Click(object sender, EventArgs e)
        {
            ClassBrowser browser = new ClassBrowser();
            MemberList known = null;
            browser.IncludeFlag = FlagType.Interface;
            IASContext context = ASContext.GetLanguageContext(PluginBase.CurrentProject.Language);
            try
            {
                known = context.GetAllProjectClasses();
                known.Merge(ASContext.Context.GetVisibleExternalElements(true));
            }
            catch (Exception error)
            {
                Debug.WriteLine(error.StackTrace);
            }
            
            browser.ClassList = known;

            if (browser.ShowDialog(this) == DialogResult.OK)
            {
                if (browser.SelectedClass != null)
                {
                    foreach (string item in this.implementList.Items)
                    {
                        if (item == browser.SelectedClass) return;
                    }
                    this.implementList.Items.Add(browser.SelectedClass);
                }
            }
            this.implementRemove.Enabled = this.implementList.Items.Count > 0;
            this.implementList.SelectedIndex = this.implementList.Items.Count - 1;
            this.superCheck.Enabled = this.implementList.Items.Count > 0;
            ValidateClass();
        }

        /// <summary>
        /// Remove interface
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void button6_Click(object sender, EventArgs e)
        {
            if (this.implementList.SelectedItem != null)
            {
                this.implementList.Items.Remove(this.implementList.SelectedItem);
            }

            if (this.implementList.Items.Count > 0)
            {
                this.implementList.SelectedIndex = this.implementList.Items.Count - 1;
            }

            this.implementRemove.Enabled   = this.implementList.Items.Count > 0;
            this.superCheck.Enabled = this.implementList.Items.Count > 0;
            ValidateClass();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            ValidateClass();
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            ValidateClass();
        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {
            this.constructorCheck.Enabled = this.baseBox.Text != "";
            ValidateClass();
        }

        #endregion

        public static Image GetResource( string resourceID )
        {
            resourceID = "ASClassWizard." + resourceID;
            Assembly assembly = Assembly.GetExecutingAssembly();
            Image image = new Bitmap(assembly.GetManifestResourceStream(resourceID));
            return image;
        }

        #region user_options

        public string getPackage()
        {
            return this.packageBox.Text;
        }

        public string getClassName()
        {
            return this.classBox.Text;
        }

        public bool isDynamic()
        {
            return this.dynamicCheck.Checked;
        }

        public bool isFinal()
        {
            return this.finalCheck.Checked;
        }

        public bool isPublic()
        {
            return this.publicRadio.Checked;
        }

        public string getSuperClass()
        {
            return this.baseBox.Text;
        }

        public List<string> getInterfaces()
        {
            List<string> _interfaces = new List<string>(this.implementList.Items.Count);
            foreach (string item in this.implementList.Items)
            {
                _interfaces.Add(item);
            }
            return _interfaces;
        }

        public bool hasInterfaces()
        {
            return this.implementList.Items.Count > 0;
        }

        public bool getGenerateConstructor()
        {
            return this.constructorCheck.Checked;
        }

        public bool getGenerateInheritedMethods()
        {
            return this.superCheck.Checked;
        }

        #endregion


    }
}
