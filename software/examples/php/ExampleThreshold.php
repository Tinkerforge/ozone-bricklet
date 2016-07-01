<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletOzone.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletOzone;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change XYZ to the UID of your Ozone Bricklet

// Callback function for ozone concentration reached callback (parameter has unit ppb)
function cb_ozoneConcentrationReached($ozone_concentration)
{
    echo "Ozone Concentration: $ozone_concentration ppb\n";
}

$ipcon = new IPConnection(); // Create IP connection
$o = new BrickletOzone(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$o->setDebouncePeriod(10000);

// Register ozone concentration reached callback to function cb_ozoneConcentrationReached
$o->registerCallback(BrickletOzone::CALLBACK_OZONE_CONCENTRATION_REACHED,
                     'cb_ozoneConcentrationReached');

// Configure threshold for ozone concentration "greater than 20 ppb" (unit is ppb)
$o->setOzoneConcentrationCallbackThreshold('>', 20, 0);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
