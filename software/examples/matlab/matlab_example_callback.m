function matlab_example_callback()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletOzone;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change XYZ to the UID of your Ozone Bricklet

    ipcon = IPConnection(); % Create IP connection
    o = handle(BrickletOzone(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register ozone concentration callback to function cb_ozone_concentration
    set(o, 'OzoneConcentrationCallback', @(h, e) cb_ozone_concentration(e));

    % Set period for ozone concentration callback to 1s (1000ms)
    % Note: The ozone concentration callback is only called every second
    %       if the ozone concentration has changed since the last call!
    o.setOzoneConcentrationCallbackPeriod(1000);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for ozone concentration callback
function cb_ozone_concentration(e)
    fprintf('Ozone Concentration: %i ppb\n', e.ozoneConcentration);
end
