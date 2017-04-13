using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change XYZ to the UID of your Ozone Bricklet

	// Callback function for ozone concentration reached callback (parameter has unit ppb)
	static void OzoneConcentrationReachedCB(BrickletOzone sender, int ozoneConcentration)
	{
		Console.WriteLine("Ozone Concentration: " + ozoneConcentration + " ppb");
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletOzone o = new BrickletOzone(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		o.SetDebouncePeriod(10000);

		// Register ozone concentration reached callback to function OzoneConcentrationReachedCB
		o.OzoneConcentrationReachedCallback += OzoneConcentrationReachedCB;

		// Configure threshold for ozone concentration "greater than 20 ppb" (unit is ppb)
		o.SetOzoneConcentrationCallbackThreshold('>', 20, 0);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
