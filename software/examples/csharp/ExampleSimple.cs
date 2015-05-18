using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletOzone oz = new BrickletOzone(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current ozone concentration (unit is ppb)
		int ozoneConcentration = oz.GetOzoneConcentration();

		System.Console.WriteLine("Ozone Concentration: " + ozoneConcentration + " ppb");

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
