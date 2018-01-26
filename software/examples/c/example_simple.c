#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_ozone.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change XYZ to the UID of your Ozone Bricklet

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

	// Get current ozone concentration (unit is ppb)
	uint16_t ozone_concentration;
	if(ozone_get_ozone_concentration(&o, &ozone_concentration) < 0) {
		fprintf(stderr, "Could not get ozone concentration, probably timeout\n");
		return 1;
	}

	printf("Ozone Concentration: %u ppb\n", ozone_concentration);

	printf("Press key to exit\n");
	getchar();
	ozone_destroy(&o);
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
	return 0;
}
