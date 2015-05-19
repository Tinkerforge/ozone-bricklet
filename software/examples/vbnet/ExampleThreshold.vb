Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback for ozone concentration greater than 20 ppb
    Sub ReachedCB(ByVal sender As BrickletOzone, ByVal ozoneConcentration As Integer)
        System.Console.WriteLine("Ozone Concentration " + (ozoneConcentration).ToString() + " ppb.")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim oz As New BrickletOzone(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        oz.SetDebouncePeriod(10000)

        ' Register threshold reached callback to function ReachedCB
        AddHandler oz.OzoneConcentrationReached, AddressOf ReachedCB

        ' Configure threshold for "greater than 20 ppb"
        oz.SetOzoneConcentrationCallbackThreshold(">"C, 20, 0)

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
