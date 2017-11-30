#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change XYZ to the UID of your Ozone Bricklet

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_ozone import BrickletOzone

# Callback function for ozone concentration reached callback (parameter has unit ppb)
def cb_ozone_concentration_reached(ozone_concentration):
    print("Ozone Concentration: " + str(ozone_concentration) + " ppb")

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    o = BrickletOzone(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Get threshold callbacks with a debounce time of 10 seconds (10000ms)
    o.set_debounce_period(10000)

    # Register ozone concentration reached callback to function
    # cb_ozone_concentration_reached
    o.register_callback(o.CALLBACK_OZONE_CONCENTRATION_REACHED,
                        cb_ozone_concentration_reached)

    # Configure threshold for ozone concentration "greater than 20 ppb" (unit is ppb)
    o.set_ozone_concentration_callback_threshold(">", 20, 0)

    raw_input("Press key to exit\n") # Use input() in Python 3
    ipcon.disconnect()
