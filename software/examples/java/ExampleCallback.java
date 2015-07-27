import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletOzone;

public class ExampleCallback {
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

		// Set period for ozone concentration callback to 1s (1000ms)
		// Note: The ozone concentration callback is only called every second
		//       if the ozone concentration has changed since the last call!
		o.setOzoneConcentrationCallbackPeriod(1000);

		// Add ozone concentration listener (parameter has unit ppb)
		o.addOzoneConcentrationListener(new BrickletOzone.OzoneConcentrationListener() {
			public void ozoneConcentration(int ozoneConcentration) {
				System.out.println("Ozone Concentration: " + ozoneConcentration + " ppb");
			}
		});

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
