#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=XYZ

# get threshold callbacks with a debounce time of 10 seconds (10000ms)
tinkerforge call ozone-bricklet $uid set-debounce-period 10000

# configure threshold for "greater than 20 ppb"
tinkerforge call ozone-bricklet $uid set-ozone-concentration-callback-threshold greater 20 0

# handle incoming ozone concentration-reached callbacks (unit is ppb)
tinkerforge dispatch ozone-bricklet $uid ozone-concentration-reached\
 --execute "echo Ozone Concentration: {ozone-concentration} ppb"
