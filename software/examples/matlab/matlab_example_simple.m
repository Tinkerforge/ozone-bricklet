function matlab_example_simple()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletOzone;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'hhw'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    oz = BrickletOzone(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current ozone concentration (unit is ppb)
    ozone_concentration = oz.getOzoneConcentration();
    fprintf('Ozone Concentration: %g ppb\n', ozone_concentration);

    input('Press any key to exit...\n', 's');
    ipcon.disconnect();
end
