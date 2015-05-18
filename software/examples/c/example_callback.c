#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_ozone.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change to your UID

// Callback function for ozone concentration callback (parameter has unit ppb)
void cb_ozone_concentration(uint16_t ozone_concentration, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Ozone Concentration: %d ppb.\n", ozone_concentration);
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

	// Set Period for ozone concentration callback to 1s (1000ms)
	// Note: The ozone concentration callback is only called every second if the 
	//       ozone concentration has changed since the last call!
	ozone_set_ozone_concentration_callback_period(&oz, 1000);

	// Register ozone concentration callback to function cb_ozone concentration
	ozone_register_callback(&oz,
	                        OZONE_CALLBACK_OZONE_CONCENTRATION,
	                        (void *)cb_ozone_concentration,
	                        NULL);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
