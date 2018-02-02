function octave_example_threshold()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Ozone Bricklet

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    o = javaObject("com.tinkerforge.BrickletOzone", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 10 seconds (10000ms)
    o.setDebouncePeriod(10000);

    % Register ozone concentration reached callback to function
    % cb_ozone_concentration_reached
    o.addOzoneConcentrationReachedCallback(@cb_ozone_concentration_reached);

    % Configure threshold for ozone concentration "greater than 20 ppb"
    o.setOzoneConcentrationCallbackThreshold(">", 20, 0);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for ozone concentration reached callback
function cb_ozone_concentration_reached(e)
    fprintf("Ozone Concentration: %d ppb\n", e.ozoneConcentration);
end
