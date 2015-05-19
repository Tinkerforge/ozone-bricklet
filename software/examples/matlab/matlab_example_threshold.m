function matlab_example_threshold()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletOzone;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'amb'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    oz = BrickletOzone(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set threshold callbacks with a debounce time of 10 seconds (10000ms)
    oz.setDebouncePeriod(10000);

    % Register threshold reached callback to function cb_reached
    set(oz, 'OzoneConcentrationReachedCallback', @(h, e) cb_reached(e));

    % Configure threshold for "greater than 20 ppb" (unit is ppb)
    oz.setOzoneConcentrationCallbackThreshold('>', 20, 0);

    input('Press any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback for ozone concentration greater than 20 ppb
function cb_reached(e)
    fprintf('Ozone Concentration %g ppb.\n', e.ozone_concentration);
end
