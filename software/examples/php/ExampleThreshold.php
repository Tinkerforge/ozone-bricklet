<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletOzone.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletOzone;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change to your UID

// Callback for ozone concentration greater than 20 ppb
function cb_reached($ozoneConcentration)
{
    echo "Ozone Concentration " . $ozoneConcentration . " ppb.\n";
}

$ipcon = new IPConnection(); // Create IP connection
$oz = new BrickletOzone(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$oz->setDebouncePeriod(10000);

// Register threshold reached callback to function cb_reached
$oz->registerCallback(BrickletOzone::CALLBACK_OZONE_CONCENTRATION_REACHED, 'cb_reached');

// Configure threshold for "greater than 20 ppb" (unit is ppb)
$oz->setOzoneConcentrationCallbackThreshold('>', 20, 0);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
