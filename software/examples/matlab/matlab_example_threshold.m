function matlab_example_threshold()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletOzone;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    o = handle(BrickletOzone(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 10 seconds (10000ms)
    o.setDebouncePeriod(10000);

    % Register ozone concentration reached callback to function cb_ozone_concentration_reached
    set(o, 'OzoneConcentrationReachedCallback', @(h, e) cb_ozone_concentration_reached(e));

    % Configure threshold for ozone concentration "greater than 20 ppb" (unit is ppb)
    o.setOzoneConcentrationCallbackThreshold('>', 20, 0);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for ozone concentration reached callback (parameter has unit ppb)
function cb_ozone_concentration_reached(e)
    fprintf('Ozone Concentration: %i ppb\n', e.ozoneConcentration);
end
