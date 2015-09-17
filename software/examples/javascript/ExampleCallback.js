var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'XYZ'; // Change to your UID

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var o = new Tinkerforge.BrickletOzone(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function (error) {
        console.log('Error: ' + error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function (connectReason) {
        // Set period for ozone concentration callback to 1s (1000ms)
        // Note: The ozone concentration callback is only called every second
        //       if the ozone concentration has changed since the last call!
        o.setOzoneConcentrationCallbackPeriod(1000);
    }
);

// Register ozone concentration callback
o.on(Tinkerforge.BrickletOzone.CALLBACK_OZONE_CONCENTRATION,
    // Callback function for ozone concentration callback (parameter has unit ppb)
    function (ozoneConcentration) {
        console.log('Ozone Concentration: ' + ozoneConcentration + ' ppb');
    }
);

console.log('Press key to exit');
process.stdin.on('data',
    function (data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
