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

	// Get threshold receivers with a debounce time of 10 seconds (10000ms).
	o.SetDebouncePeriod(10000)

	o.RegisterOzoneConcentrationReachedCallback(func(ozoneConcentration uint16) {
		fmt.Printf("Ozone Concentration: %d ppb\n", ozoneConcentration)
	})

	// Configure threshold for ozone concentration "greater than 20 ppb".
	o.SetOzoneConcentrationCallbackThreshold('>', 20, 0)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
