#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_ozone'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change to your UID

ipcon = IPConnection.new # Create IP connection
o = BrickletOzone.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Set period for ozone concentration callback to 1s (1000ms)
# Note: The ozone concentration callback is only called every second
#       if the ozone concentration has changed since the last call!
o.set_ozone_concentration_callback_period 1000

# Register ozone concentration callback (parameter has unit ppb)
o.register_callback(BrickletOzone::CALLBACK_OZONE_CONCENTRATION) do |ozone_concentration|
  puts "Ozone Concentration: #{ozone_concentration} ppb"
end

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
