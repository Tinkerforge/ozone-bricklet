function matlab_example_callback()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletOzone;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'amb'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    oz = BrickletOzone(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set Period for ozone concentration callback to 1s (1000ms)
    % Note: The callback is only called every second if the
    %       ozone concentration has changed since the last call!
    oz.setOzoneConcentrationCallbackPeriod(1000);

    % Register ozone concentration callback to function cb_ozone_concentration
    set(oz, 'OzoneConcentrationCallback', @(h, e) cb_ozone_concentration(e));

    input('Press any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback function for ozone concentration callback (parameter has unit ppb)
function cb_ozone_concentration(e)
    fprintf('Ozone Concentration: %g ppb\n', e.ozone_concentration);
end
