﻿using System;
using System.IO;
using System.Text;
using System.Collections;
using System.Windows.Forms;
using System.Collections.Generic;
using PluginCore.Managers;
using PluginCore.Utilities;
using FlashDevelop.Helpers;
using PluginCore;

namespace FlashDevelop.Managers
{
    class ShortcutManager
    {
        public static List<Keys> AllShortcuts = new List<Keys>();
        public static List<ShortcutItem> RegistedItems = new List<ShortcutItem>();

        /// <summary>
        /// Registers a shortcut item
        /// </summary>
        public static void RegisterItem(String key, Keys keys)
        {
            ShortcutItem registered = new ShortcutItem(key, keys);
            RegistedItems.Add(registered);
        }

        /// <summary>
        /// Registers a shortcut item
        /// </summary>
        public static void RegisterItem(String key, ToolStripMenuItem item)
        {
            ShortcutItem registered = new ShortcutItem(key, item);
            RegistedItems.Add(registered);
        }

        /// <summary>
        /// Gets the specified registered shortcut item
        /// </summary>
        public static ShortcutItem GetRegisteredItem(String id)
        {
            foreach (ShortcutItem item in RegistedItems)
            {
                if (item.Id == id) return item;
            }
            return null;
        }

        /// <summary>
        /// Updates the list of all shortcuts
        /// </summary>
        public static void UpdateAllShortcuts()
        {
            List<Keys> keys = new List<Keys>();
            foreach (ShortcutItem item in RegistedItems)
            {
                if (!AllShortcuts.Contains(item.Custom))
                {
                    AllShortcuts.Add(item.Custom);
                }
            }
        }

        /// <summary>
        /// Applies all shortcuts to the items
        /// </summary>
        public static void ApplyAllShortcuts()
        {
            ShortcutManager.UpdateAllShortcuts();
            foreach (ShortcutItem item in RegistedItems)
            {
                if (item.Item != null)
                {
                    if (item.Item.Owner != null && item.Item.Owner.InvokeRequired)
                    {
                        item.Item.Owner.BeginInvoke((MethodInvoker)delegate { item.Item.ShortcutKeys = item.Custom; });
                    }
                    else item.Item.ShortcutKeys = item.Custom;
                }
                else if (item.Default != item.Custom)
                {
                    DataEvent de = new DataEvent(EventType.Shortcut, item.Id, item.Custom);
                    EventManager.DispatchEvent(Globals.MainForm, de);
                }
            }
        }

        /// <summary>
        /// Saves the custom shorcuts from a file
        /// </summary>
        public static void LoadCustomShortcuts()
        {
            foreach (Argument arg in Globals.Settings.CustomShortcuts)
            {
                ShortcutItem item = GetRegisteredItem(arg.Key);
                if (item != null) item.Custom = (Keys)Enum.Parse(typeof(Keys), arg.Value);
            }
        }

        /// <summary>
        /// Saves the custom shorcuts to a file
        /// </summary>
        public static void SaveCustomShortcuts()
        {
            Globals.Settings.CustomShortcuts.Clear();
            foreach (ShortcutItem item in RegistedItems)
            {
                if (item.Custom != item.Default)
                {
                    Globals.Settings.CustomShortcuts.Add(new Argument(item.Id, item.Custom.ToString()));
                }
            }
        }

    }

    #region Helper Classes

    public class ShortcutItem
    {
        public Keys Custom = Keys.None;
        public Keys Default = Keys.None;
        public ToolStripMenuItem Item = null;
        public String Id = String.Empty;

        public ShortcutItem(String id, Keys keys)
        {
            this.Id = id;
            this.Default = this.Custom = keys;
        }

        public ShortcutItem(String id, ToolStripMenuItem item)
        {
            this.Id = id;
            this.Item = item;
            this.Default = this.Custom = item.ShortcutKeys;
        }

    }

    #endregion

}
