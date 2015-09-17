#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change to your UID

# Get current ozone concentration (unit is ppb)
tinkerforge call ozone-bricklet $uid get-ozone-concentration
