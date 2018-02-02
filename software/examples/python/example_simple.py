#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change XYZ to the UID of your Ozone Bricklet

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_ozone import BrickletOzone

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    o = BrickletOzone(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Get current ozone concentration
    ozone_concentration = o.get_ozone_concentration()
    print("Ozone Concentration: " + str(ozone_concentration) + " ppb")

    raw_input("Press key to exit\n") # Use input() in Python 3
    ipcon.disconnect()
