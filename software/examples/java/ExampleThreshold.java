import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletOzone;

public class ExampleThreshold {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;
	private static final String UID = "XYZ"; // Change to your UID

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletOzone o = new BrickletOzone(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		o.setDebouncePeriod(10000);

		// Configure threshold for "greater than 20 ppb" (unit is ppb)
		o.setOzoneConcentrationCallbackThreshold('>', 20, 0);

		// Add threshold reached listener for ozone concentration greater than 20 ppb (parameter has unit ppb)
		o.addOzoneConcentrationReachedListener(new BrickletOzone.OzoneConcentrationReachedListener() {
			public void ozoneConcentrationReached(int ozoneConcentration) {
				System.out.println("Ozone Concentration: " + ozoneConcentration + " ppb");
			}
		});

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
