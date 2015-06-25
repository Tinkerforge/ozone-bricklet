function octave_example_callback()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "hbo"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    oz = java_new("com.tinkerforge.BrickletOzone", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set Period for ozone concentration callback to 1s (1000ms)
    % Note: The callback is only called every second if the
    %       ozone concentration has changed since the last call!
    oz.setOzoneConcentrationCallbackPeriod(1000);

    % Register ozone concentration callback to function cb_ozone_concentration
    oz.addOzoneConcentrationCallback(@cb_ozone_concentration);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end

% Callback function for ozone concentration callback (parameter has unit ppb)
function cb_ozone_concentration(e)
    fprintf("Ozone Concentration: %g ppb\n", e.ozoneConcentration);
end
