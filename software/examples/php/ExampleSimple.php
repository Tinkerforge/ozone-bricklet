<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletOzone.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletOzone;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change to your UID

$ipcon = new IPConnection(); // Create IP connection
$oz = new BrickletOzone(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get current ozone concentration (unit is ppb)
$ozoneConcentration = $oz->getOzoneConcentration();

echo "Ozone Concentration: $ozoneConcentration ppb\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->disconnect();

?>
