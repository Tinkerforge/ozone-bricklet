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

    //Create listener for ozone concentration events.
    let ozone_concentration_listener = ozone_bricklet.get_ozone_concentration_receiver();
    // Spawn thread to handle received events. This thread ends when the ozone_bricklet
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for event in ozone_concentration_listener {
            println!("Ozone Concentration: {}{}", event, " ppb");
        }
    });

    // Set period for ozone concentration listener to 1s (1000ms)
    // Note: The ozone concentration callback is only called every second
    //       if the ozone concentration has changed since the last call!
    ozone_bricklet.set_ozone_concentration_callback_period(1000);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
