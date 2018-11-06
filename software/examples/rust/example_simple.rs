use std::{error::Error, io};

use tinkerforge::{ipconnection::IpConnection, ozone_bricklet::*};

const HOST: &str = "127.0.0.1";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Ozone Bricklet

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection
    let ozone_bricklet = OzoneBricklet::new(UID, &ipcon); // Create device object

    ipcon.connect(HOST, PORT).recv()??; // Connect to brickd
                                        // Don't use device before ipcon is connected

    // Get current ozone concentration
    let ozone_concentration = ozone_bricklet.get_ozone_concentration().recv()?;
    println!("Ozone Concentration: {}{}", ozone_concentration, " ppb");

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
