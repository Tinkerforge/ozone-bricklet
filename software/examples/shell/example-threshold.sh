#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Ozone Bricklet

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
tinkerforge call ozone-bricklet $uid set-debounce-period 10000

# Handle incoming ozone concentration reached callbacks (parameter has unit ppb)
tinkerforge dispatch ozone-bricklet $uid ozone-concentration-reached &

# Configure threshold for ozone concentration "greater than 20 ppb" (unit is ppb)
tinkerforge call ozone-bricklet $uid set-ozone-concentration-callback-threshold greater 20 0

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
