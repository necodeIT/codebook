using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Diagnostics;
using System.Runtime.InteropServices;

namespace url_protocol_handler
{
	internal class Program
	{
		const string FILE_NAME = "sync-auth-config.json";
		const string APP_DIR = "CodeBook";

		#region WINDOWS_ONLY

		[DllImport("USER32.DLL")]
		public static extern bool SetForegroundWindow(IntPtr hWnd);

		#endregion


		static void Main(string[] args)
		{
			var file = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments), APP_DIR, FILE_NAME);

			if(!File.Exists(file) || args.Length < 1) return;

			var config = JsonConvert.DeserializeObject<Dictionary<string, string>>(File.ReadAllText(file));
			var path = config["path"];
			var keyword = config["keyword"];


			var token = args[0].Split(keyword)[1][0..^1]; // dunno why but there is a trailing ' which makes the code invalid
			File.WriteAllText(path, token);

			
			File.Delete(file);

			if(IsWindows)
			{
				var pid = int.Parse(config["pid"]);
				var app = Process.GetProcessById(pid);

				SetForegroundWindow(app.MainWindowHandle);
			}
		}

		public static bool IsLinux
		{
			get => RuntimeInformation.IsOSPlatform(OSPlatform.Linux);
		}

		public static bool IsWindows
		{
			get => RuntimeInformation.IsOSPlatform(OSPlatform.Windows);
		}

		public static bool IsMacOS
		{
			get => RuntimeInformation.IsOSPlatform(OSPlatform.OSX);
		}
	}
}
