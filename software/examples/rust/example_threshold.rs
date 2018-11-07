use std::{error::Error, io, thread};
use tinkerforge::{ip_connection::IpConnection, ozone_bricklet::*};

const HOST: &str = "localhost";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Ozone Bricklet.

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection.
    let o = OzoneBricklet::new(UID, &ipcon); // Create device object.

    ipcon.connect((HOST, PORT)).recv()??; // Connect to brickd.
                                          // Don't use device before ipcon is connected.

    // Get threshold receivers with a debounce time of 10 seconds (10000ms).
    o.set_debounce_period(10000);

    // Create receiver for ozone concentration reached events.
    let ozone_concentration_reached_receiver = o.get_ozone_concentration_reached_receiver();

    // Spawn thread to handle received events. This thread ends when the `o` object
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for ozone_concentration_reached in ozone_concentration_reached_receiver {
            println!("Ozone Concentration: {} ppb", ozone_concentration_reached);
        }
    });

    // Configure threshold for ozone concentration "greater than 20 ppb".
    o.set_ozone_concentration_callback_threshold('>', 20, 0);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
