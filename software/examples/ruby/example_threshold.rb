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

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
o.set_debounce_period 10000

# Register ozone concentration reached callback
o.register_callback(BrickletOzone::CALLBACK_OZONE_CONCENTRATION_REACHED) do |ozone_concentration|
  puts "Ozone Concentration: #{ozone_concentration} ppb"
end

# Configure threshold for ozone concentration "greater than 20 ppb"
o.set_ozone_concentration_callback_threshold '>', 20, 0

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
