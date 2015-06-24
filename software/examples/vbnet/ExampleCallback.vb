Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback function for ozone concentration callback (parameter has unit ppb)
    Sub OzoneConcentrationCB(ByVal sender As BrickletOzone, ByVal ozoneConcentration As Integer)
        System.Console.WriteLine("Ozone Concentration: " + ozoneConcentration.ToString() + " ppb")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim oz As New BrickletOzone(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Set Period for ozone concentration callback to 1s (1000ms)
        ' Note: The ozone concentration callback is only called every second if the
        '       ozone concentration has changed since the last call!
        oz.SetOzoneConcentrationCallbackPeriod(1000)

        ' Register ozone concentration callback to function OzoneConcentrationCB
        AddHandler oz.OzoneConcentration, AddressOf OzoneConcentrationCB

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
