package main

import (
	"fmt"
	"github.com/tinkerforge/go-api-bindings/ipconnection"
	"github.com/tinkerforge/go-api-bindings/ozone_bricklet"
)

const ADDR string = "localhost:4223"
const UID string = "XYZ" // Change XYZ to the UID of your Ozone Bricklet.

func main() {
	ipcon := ipconnection.New()
	defer ipcon.Close()
	o, _ := ozone_bricklet.New(UID, &ipcon) // Create device object.

	ipcon.Connect(ADDR) // Connect to brickd.
	defer ipcon.Disconnect()
	// Don't use device before ipcon is connected.

	// Get current ozone concentration.
	ozoneConcentration, _ := o.GetOzoneConcentration()
	fmt.Printf("Ozone Concentration:  ppb\n", ozoneConcentration)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
