#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletOzone;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $o = Tinkerforge::BrickletOzone->new(&UID, $ipcon); # Create device object

# Callback subroutine for ozone concentration greater than 20 ppb (parameter has unit ppb)
sub cb_ozone_concentration_reached
{
    my ($ozone_concentration) = @_;

    print "Ozone Concentration: " . $ozone_concentration . " ppb\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$o->set_debounce_period(10000);

# Register threshold reached callback to subroutine cb_ozone_concentration_reached
$o->register_callback($o->CALLBACK_OZONE_CONCENTRATION_REACHED, 'cb_ozone_concentration_reached');

# Configure threshold for "greater than 20 ppb" (unit is ppb)
$o->set_ozone_concentration_callback_threshold('>', 20, 0);

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
