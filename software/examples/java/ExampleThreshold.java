import com.tinkerforge.BrickletOzone;
import com.tinkerforge.IPConnection;

public class ExampleThreshold {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;
	private static final String UID = "XYZ"; // Change to your UID

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletOzone oz = new BrickletOzone(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		oz.setDebouncePeriod(10000);

		// Configure threshold for "greater than 75 ppb"
		oz.setOzoneConcentrationCallbackThreshold('>', (short)75, (short)0);

		// Add and implement ozone concentration reached listener
		// (called if ozone concentration is greater than 75 ppb)
		oz.addOzoneConcentrationReachedListener(new BrickletOzone.OzoneConcentrationReachedListener() {
			public void ozoneConcentrationReached(int ozoneConcentration) {
				System.out.println("Ozone Concentration: " + ozoneConcentration + " ppb");
			}
		});

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
