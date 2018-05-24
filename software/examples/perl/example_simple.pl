#!/usr/bin/perl

use strict;
use Tinkerforge::IPConnection;
use Tinkerforge::BrickletOzone;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change XYZ to the UID of your Ozone Bricklet

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $o = Tinkerforge::BrickletOzone->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current ozone concentration
my $ozone_concentration = $o->get_ozone_concentration();
print "Ozone Concentration: $ozone_concentration ppb\n";

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
