using System;
using System.Diagnostics;
using System.IO;
using System.Runtime.InteropServices;
using Microsoft.Win32;

namespace KodiLauncher
{
    static class Program
    {
        [DllImport("user32.dll")]
        private static extern bool SetForegroundWindow(IntPtr hWnd);

        [DllImport("user32.dll")]
        private static extern bool ShowWindow(IntPtr hWnd, int cmdShow);

        private const int SW_SHOWMAXIMIZED = 3;

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        static void Main()
        {
            // Attempt to bring an existing Kodi to the foreground.
            // If none exists, open Kodi.
            if(!BringProcessToForeground())
                OpenKodi();               
        }

        private static bool BringProcessToForeground()
        {
            Process[] processes = Process.GetProcessesByName("Kodi");
            if (processes.Length != 0)
            {
                // If Kodi is currently running, bring it to the foreground
                IntPtr hWnd = processes[0].MainWindowHandle;
                ShowWindow(hWnd, SW_SHOWMAXIMIZED);
                SetForegroundWindow(hWnd);
                return true;
            }
            return false;
        }

        private static void OpenKodi()
        {
            string kodiPath = null;

            // Attempt to find the Kodi executable location via the registry
            RegistryKey key = Registry.CurrentUser.OpenSubKey(@"Software\Kodi");

            if (key != null) // If the path is in the registry use it to open Kodi
            {
                kodiPath = key.GetValue("") as string;
                if (LaunchKodiProcess(kodiPath + @"\Kodi.exe"))
                    return;
            }
            else // Otherwise, we'll try to use the default locations
            {
                string x86Path = @"C:\Program Files\Kodi\Kodi.exe";
                string x64Path = @"C:\Program Files (x86)\Kodi\Kodi.exe";

                if (LaunchKodiProcess(x86Path))
                    return;
                else
                    LaunchKodiProcess(x64Path);
            }           
        }

        private static bool LaunchKodiProcess(string path)
        {
            if (path != null && File.Exists(path))
            {
                string args = "";
                Process proc = new Process();

                if(File.Exists("KodiLauncherArgs.txt"))
                {
                    using (StreamReader argStream = File.OpenText("KodiLauncherArgs.txt"))
                    {
                        args = argStream.ReadLine();
                        argStream.Close();
                    }
                }
                       
                proc.StartInfo = new ProcessStartInfo(path, args);
                proc.Start();
                BringProcessToForeground();
                return true;
            }
            return false;
        }
    }
}