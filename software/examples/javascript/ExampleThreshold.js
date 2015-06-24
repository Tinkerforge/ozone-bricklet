var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'XYZ'; // Change to your UID

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var oz = new Tinkerforge.BrickletOzone(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        console.log('Error: '+error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        // Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        oz.setDebouncePeriod(10000);
        // Configure threshold for "greater than 20 ppb"
        oz.setOzoneConcentrationCallbackThreshold('>', 20, 0);
    }
);

// Register threshold reached callback to function cb_reached
oz.on(Tinkerforge.BrickletOzone.CALLBACK_OZONE_CONCENTRATION_REACHED,
    // Callback for ozone concentration greater than 20 ppb
    function(ozoneConcentration) {
        console.log('Ozone Concentration: '+ozoneConcentration+' ppb');
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data',
    function(data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
