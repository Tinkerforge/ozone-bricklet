#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_ozone.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change XYZ to the UID of your Ozone Bricklet

// Callback function for ozone concentration reached callback
void cb_ozone_concentration_reached(uint16_t ozone_concentration, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Ozone Concentration: %u ppb\n", ozone_concentration);
}

int main(void) {
	// Create IP connection
	IPConnection ipcon;
	ipcon_create(&ipcon);

	// Create device object
	Ozone o;
	ozone_create(&o, UID, &ipcon);

	// Connect to brickd
	if(ipcon_connect(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not connect\n");
		return 1;
	}
	// Don't use device before ipcon is connected

	// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
	ozone_set_debounce_period(&o, 10000);

	// Register ozone concentration reached callback to function
	// cb_ozone_concentration_reached
	ozone_register_callback(&o,
	                        OZONE_CALLBACK_OZONE_CONCENTRATION_REACHED,
	                        (void (*)(void))cb_ozone_concentration_reached,
	                        NULL);

	// Configure threshold for ozone concentration "greater than 20 ppb"
	ozone_set_ozone_concentration_callback_threshold(&o, '>', 20, 0);

	printf("Press key to exit\n");
	getchar();
	ozone_destroy(&o);
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
	return 0;
}
