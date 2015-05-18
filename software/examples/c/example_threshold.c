#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_ozone.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change to your UID

// Callback for ozone concentration greater than 20 ppb
void cb_reached(uint16_t ozone_concentration, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Ozone concentration: %d ppb.\n", ozone_concentration);
}

int main() {
	// Create IP connection
	IPConnection ipcon;
	ipcon_create(&ipcon);

	// Create device object
	Ozone oz;
	ozone_create(&oz, UID, &ipcon); 

	// Connect to brickd
	if(ipcon_connect(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not connect\n");
		exit(1);
	}
	// Don't use device before ipcon is connected

	// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
	ozone_set_debounce_period(&oz, 10000);

	// Register threshold reached callback to function cb_reached
	ozone_register_callback(&oz,
	                        OZONE_CALLBACK_OZONE_CONCENTRATION_REACHED,
	                        (void *)cb_reached,
	                        NULL);

	// Configure threshold for "greater than 20 ppb"
	ozone_set_ozone_concentration_callback_threshold(&oz, '>', 20, 0);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
