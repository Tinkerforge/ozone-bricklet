import com.tinkerforge.BrickletOzone;
import com.tinkerforge.IPConnection;

public class ExampleCallback {
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

		// Set Period for ozone concentration callback to 1s (1000ms)
		// Note: The ozone concentration callback is only called every second if the
		//       ozone concentration has changed since the last call!
		oz.setOzoneConcentrationCallbackPeriod(1000);

		// Add and implement ozone concentration listener (called if ozone concentration changes)
		oz.addOzoneConcentrationListener(new BrickletOzone.OzoneConcentrationListener() {
			public void ozoneConcentration(int ozoneConcentration) {
				System.out.println("Ozone Concentration: " + ozoneConcentration + " ppb");
			}
		});

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
