#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_ozone'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change to your UID

ipcon = IPConnection.new # Create IP connection
oz = BrickletOzone.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Get current ozone concentration (unit is ppb)
ozone_concentration = oz.get_ozone_concentration
puts "Ozone Concentration: #{ozone_concentration} ppb"

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
