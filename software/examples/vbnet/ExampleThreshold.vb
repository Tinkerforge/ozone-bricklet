Imports System
Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback subroutine for ozone concentration reached callback (parameter has unit ppb)
    Sub OzoneConcentrationReachedCB(ByVal sender As BrickletOzone, ByVal ozoneConcentration As Integer)
        Console.WriteLine("Ozone Concentration: " + ozoneConcentration.ToString() + " ppb")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim o As New BrickletOzone(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        o.SetDebouncePeriod(10000)

        ' Register ozone concentration reached callback to subroutine OzoneConcentrationReachedCB
        AddHandler o.OzoneConcentrationReached, AddressOf OzoneConcentrationReachedCB

        ' Configure threshold for ozone_concentration "greater than 20 ppb" (unit is ppb)
        o.SetOzoneConcentrationCallbackThreshold(">"C, 20, 0)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
