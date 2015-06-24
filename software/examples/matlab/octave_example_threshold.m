function octave_example_threshold()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "amb"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    oz = java_new("com.tinkerforge.BrickletOzone", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set threshold callbacks with a debounce time of 10 seconds (10000ms)
    oz.setDebouncePeriod(10000);

    % Configure threshold for "greater than 20 ppb"
    oz.setOzoneConcentrationCallbackThreshold(oz.THRESHOLD_OPTION_GREATER, 20, 0);

    % Register threshold reached callback to function cb_reached
    oz.addOzoneConcentrationReachedCallback(@cb_reached);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end

% Callback function for ozone concentration callback (parameter has unit ppb)
function cb_reached(e)
    fprintf("Ozone Concentration: %g ppb\n", e.ozone_concentration);
end
