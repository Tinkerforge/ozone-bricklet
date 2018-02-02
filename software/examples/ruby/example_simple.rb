#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_ozone'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change XYZ to the UID of your Ozone Bricklet

ipcon = IPConnection.new # Create IP connection
o = BrickletOzone.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Get current ozone concentration
ozone_concentration = o.get_ozone_concentration
puts "Ozone Concentration: #{ozone_concentration} ppb"

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
