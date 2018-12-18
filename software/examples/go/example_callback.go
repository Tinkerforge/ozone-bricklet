package main

import (
	"fmt"
	"github.com/Tinkerforge/go-api-bindings/ipconnection"
	"github.com/Tinkerforge/go-api-bindings/ozone_bricklet"
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

	o.RegisterOzoneConcentrationCallback(func(ozoneConcentration uint16) {
		fmt.Printf("Ozone Concentration: %d ppb\n", ozoneConcentration)
	})

	// Set period for ozone concentration receiver to 1s (1000ms).
	// Note: The ozone concentration callback is only called every second
	//       if the ozone concentration has changed since the last call!
	o.SetOzoneConcentrationCallbackPeriod(1000)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
