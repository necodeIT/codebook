using System;

namespace htttp_protocol_handler
{
	internal class Program
	{
		static void Main(string[] args)
		{
			// print every arg in args
			foreach (var arg in args)
			{
				Console.WriteLine(arg);
			}
			Console.ReadKey();
		}
	}
}
