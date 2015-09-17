#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change to your UID

# Handle incoming ozone concentration callbacks (parameter has unit ppb)
tinkerforge dispatch ozone-bricklet $uid ozone-concentration &

# Set period for ozone concentration callback to 1s (1000ms)
# Note: The ozone concentration callback is only called every second
#       if the ozone concentration has changed since the last call!
tinkerforge call ozone-bricklet $uid set-ozone-concentration-callback-period 1000

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
