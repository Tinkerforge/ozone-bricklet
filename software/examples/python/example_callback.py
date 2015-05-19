#!/usr/bin/env python
# -*- coding: utf-8 -*-  

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_ozone import Ozone

# Callback function for ozone concentration callback (parameter has unit ppb)
def cb_ozone_concentration(ozone_concentration):
    print('Ozone Concentration: ' + str(ozone_concentration) + ' ppb')

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    oz = Ozone(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Set Period for ozone concentration callback to 1s (1000ms)
    # Note: The ozone concentration callback is only called every second if the 
    #       ozone concentration has changed since the last call!
    oz.set_ozone_concentration_callback_period(1000)

    # Register ozone concentration callback to function cb_ozone_concentration
    oz.register_callback(oz.CALLBACK_OZONE_CONCENTRATION, cb_ozone_concentration)

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
