function octave_example_simple()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Ozone Bricklet

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    o = javaObject("com.tinkerforge.BrickletOzone", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current ozone concentration
    ozoneConcentration = o.getOzoneConcentration();
    fprintf("Ozone Concentration: %d ppb\n", ozoneConcentration);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end
