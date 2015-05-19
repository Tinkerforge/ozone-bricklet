#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=XYZ

# set period for ozone concentration callback to 1s (1000ms)
# note: the ozone concentration callback is only called every second if the
#       ozone concentration has changed since the last call!
tinkerforge call ozone-bricklet $uid set-ozone-concentration-callback-period 1000

# handle incoming ozone concentration callbacks (unit is ppb)
tinkerforge dispatch ozone-bricklet $uid ozone-concentration
