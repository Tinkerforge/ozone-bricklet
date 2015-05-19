function octave_example_simple()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "amb"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    oz = java_new("com.tinkerforge.BrickletOzone", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current ozone concentration (unit is ppb)
    ozone_concentration = oz.getOzoneConcentration();
    fprintf("Ozone Concentration: %g ppb\n", ozone_concentration);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end
