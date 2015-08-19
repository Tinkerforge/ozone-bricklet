#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletOzone;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $o = Tinkerforge::BrickletOzone->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current ozone concentration (unit is ppb)
my $ozone_concentration = $o->get_ozone_concentration();
print "Ozone Concentration: " . $ozone_concentration . " ppb\n";

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
