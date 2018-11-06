use std::{error::Error, io, thread};
use tinkerforge::{ipconnection::IpConnection, ozone_bricklet::*};

const HOST: &str = "127.0.0.1";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Ozone Bricklet

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection
    let ozone_bricklet = OzoneBricklet::new(UID, &ipcon); // Create device object

    ipcon.connect(HOST, PORT).recv()??; // Connect to brickd
                                        // Don't use device before ipcon is connected

    // Get threshold listeners with a debounce time of 10 seconds (10000ms)
    ozone_bricklet.set_debounce_period(10000);

    //Create listener for ozone concentration reached events.
    let ozone_concentration_reached_listener = ozone_bricklet.get_ozone_concentration_reached_receiver();
    // Spawn thread to handle received events. This thread ends when the ozone_bricklet
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for event in ozone_concentration_reached_listener {
            println!("Ozone Concentration: {}{}", event, " ppb");
        }
    });

    // Configure threshold for ozone concentration "greater than 20 ppb"
    ozone_bricklet.set_ozone_concentration_callback_threshold('>', 20, 0);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
