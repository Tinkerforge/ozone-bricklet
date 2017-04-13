using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change XYZ to the UID of your Ozone Bricklet

	// Callback function for ozone concentration callback (parameter has unit ppb)
	static void OzoneConcentrationCB(BrickletOzone sender, int ozoneConcentration)
	{
		Console.WriteLine("Ozone Concentration: " + ozoneConcentration + " ppb");
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletOzone o = new BrickletOzone(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Register ozone concentration callback to function OzoneConcentrationCB
		o.OzoneConcentrationCallback += OzoneConcentrationCB;

		// Set period for ozone concentration callback to 1s (1000ms)
		// Note: The ozone concentration callback is only called every second
		//       if the ozone concentration has changed since the last call!
		o.SetOzoneConcentrationCallbackPeriod(1000);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
