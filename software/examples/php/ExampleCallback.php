<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletOzone.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletOzone;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change to your UID

// Callback function for ozone concentration callback (parameter has unit ppb)
function cb_ozone_concentration($ozoneConcentration)
{
    echo "Ozone Concentration: " . $ozoneConcentration . " ppb\n";
}

$ipcon = new IPConnection(); // Create IP connection
$oz = new BrickletOzone(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Set Period for ozone concentration callback to 1s (1000ms)
// Note: The ozone concentration callback is only called every second if the
//       ozone concentration has changed since the last call!
$oz->setOzoneConcentrationCallbackPeriod(1000);

// Register ozone concentration callback to function cb_ozone_concentration
$oz->registerCallback(BrickletOzone::CALLBACK_OZONE_CONCENTRATION, 'cb_ozone_concentration');

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
