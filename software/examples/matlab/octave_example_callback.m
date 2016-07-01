function octave_example_callback()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Ozone Bricklet

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    o = java_new("com.tinkerforge.BrickletOzone", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register ozone concentration callback to function cb_ozone_concentration
    o.addOzoneConcentrationCallback(@cb_ozone_concentration);

    % Set period for ozone concentration callback to 1s (1000ms)
    % Note: The ozone concentration callback is only called every second
    %       if the ozone concentration has changed since the last call!
    o.setOzoneConcentrationCallbackPeriod(1000);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for ozone concentration callback (parameter has unit ppb)
function cb_ozone_concentration(e)
    fprintf("Ozone Concentration: %d ppb\n", e.ozoneConcentration);
end
