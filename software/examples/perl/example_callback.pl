#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletOzone;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $oz = Tinkerforge::BrickletOzone->new(&UID, $ipcon); # Create device object

# Callback function for ozone concentration callback (parameter has unit ppb)
sub cb_ozone_concentration
{
    my ($ozone_concentration) = @_;

    print "Ozone Concentration: ".$ozone_concentration." ppb\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Set Period for ozone concentration callback to 1s (1000ms)
# Note: The ozone concentration callback is only called every second if the 
#       ozone concentration has changed since the last call!
$oz->set_ozone_concentration_callback_period(1000);

# Register ozone concentration callback to function cb_ozone_concentration
$oz->register_callback($oz->CALLBACK_OZONE_CONCENTRATION, 'cb_ozone_concentration');

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
