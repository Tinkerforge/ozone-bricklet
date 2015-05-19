#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=XYZ

# get current ozone concentration (unit is ppb)
tinkerforge call ozone-bricklet $uid get-ozone-concentration
