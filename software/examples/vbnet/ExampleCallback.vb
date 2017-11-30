Imports System
Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change XYZ to the UID of your Ozone Bricklet

    ' Callback subroutine for ozone concentration callback (parameter has unit ppb)
    Sub OzoneConcentrationCB(ByVal sender As BrickletOzone, _
                             ByVal ozoneConcentration As Integer)
        Console.WriteLine("Ozone Concentration: " + ozoneConcentration.ToString() + " ppb")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim o As New BrickletOzone(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Register ozone concentration callback to subroutine OzoneConcentrationCB
        AddHandler o.OzoneConcentrationCallback, AddressOf OzoneConcentrationCB

        ' Set period for ozone concentration callback to 1s (1000ms)
        ' Note: The ozone concentration callback is only called every second
        '       if the ozone concentration has changed since the last call!
        o.SetOzoneConcentrationCallbackPeriod(1000)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
