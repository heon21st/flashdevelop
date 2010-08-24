﻿using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;
using System.IO;

namespace SourceControl.Sources.Git
{
    static class TortoiseProc
    {
        static private string resolvedCmd;
        static private string qualifiedCmd;

        static public void Execute(string command, string path)
        {
            string args = String.Format("/command:{0} /path:\"{1}\"", command, path);
            ProcessStartInfo info = new ProcessStartInfo(GetTortoiseProc(), args);
            info.UseShellExecute = true;
            Process.Start(info);
        }

        static public void Execute(string command, string path1, string path2)
        {
            string args = String.Format("/command:{0} /path:\"{1}\" /path2:\"{2}\"", command, path1, path2);
            ProcessStartInfo info = new ProcessStartInfo(GetTortoiseProc(), args);
            info.UseShellExecute = true;
            Process.Start(info);
        }

        static private string GetTortoiseProc()
        {
            string cmd = PluginMain.SCSettings.TortoiseGITProcPath;
            if (cmd == null) cmd = "TortoiseProc.exe";
            return ResolveTortoiseProcPath(cmd);
        }

        static private string ResolveTortoiseProcPath(string cmd)
        {
            if (resolvedCmd == cmd || Path.IsPathRooted(cmd))
                return qualifiedCmd;

            resolvedCmd = cmd;
            qualifiedCmd = cmd;
            string cp = Environment.GetEnvironmentVariable("PATH");
            foreach (string path in cp.Split(';'))
            {
                if (path.IndexOf("git", StringComparison.OrdinalIgnoreCase) > 0 && Directory.Exists(path))
                {
                    string test = Path.Combine(path, cmd);
                    if (File.Exists(test)) { qualifiedCmd = test; break; }
                }
            }
            return qualifiedCmd;
        }
    }
}