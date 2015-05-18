using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	// Callback for ozone concentration greater than 20 ppb
	static void ReachedCB(BrickletOzone sender, int ozoneConcentration)
	{
		System.Console.WriteLine("Ozone Concentration: " + ozoneConcentration + " ppb.");
	}

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletOzone oz = new BrickletOzone(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		oz.SetDebouncePeriod(10000);

		// Register threshold reached callback to function ReachedCB
		oz.OzoneConcentrationReached += ReachedCB;

		// Configure threshold for "greater than 20 ppb"
		oz.SetOzoneConcentrationCallbackThreshold('>', 20, 0);

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
