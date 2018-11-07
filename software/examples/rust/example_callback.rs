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

    // Create receiver for ozone concentration events.
    let ozone_concentration_receiver = o.get_ozone_concentration_receiver();

    // Spawn thread to handle received events. This thread ends when the `o` object
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for ozone_concentration in ozone_concentration_receiver {
            println!("Ozone Concentration: {} ppb", ozone_concentration);
        }
    });

    // Set period for ozone concentration receiver to 1s (1000ms).
    // Note: The ozone concentration callback is only called every second
    //       if the ozone concentration has changed since the last call!
    o.set_ozone_concentration_callback_period(1000);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
