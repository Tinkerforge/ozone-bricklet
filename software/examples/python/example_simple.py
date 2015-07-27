#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_ozone import Ozone

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    o = Ozone(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Get current ozone concentration (unit is ppb)
    ozone_concentration = o.get_ozone_concentration()
    print('Ozone Concentration: ' + str(ozone_concentration) + ' ppb')

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
