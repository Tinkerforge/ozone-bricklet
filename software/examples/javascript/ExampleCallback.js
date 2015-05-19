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
        // Set Period for ozone concentration callback to 1s (1000ms)
        // Note: The ozone concentration callback is only called every second if the
        // ozone concentration has changed since the last call!
        oz.setOzoneConcentrationCallbackPeriod(1000);
    }
);

// Register position callback
oz.on(Tinkerforge.BrickletOzone.CALLBACK_OZONE_CONCENTRATION,
    // Callback function for ozone concentration callback (parameter has unit ppb)
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
