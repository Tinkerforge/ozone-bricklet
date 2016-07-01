#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Ozone Bricklet

# Get current ozone concentration (unit is ppb)
tinkerforge call ozone-bricklet $uid get-ozone-concentration
