program ExampleSimple;

{$ifdef MSWINDOWS}{$apptype CONSOLE}{$endif}
{$ifdef FPC}{$mode OBJFPC}{$H+}{$endif}

uses
  SysUtils, IPConnection, BrickletOzone;

type
  TExample = class
  private
    ipcon: TIPConnection;
    o: TBrickletOzone;
  public
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'XYZ'; { Change XYZ to the UID of your Ozone Bricklet }

var
  e: TExample;

procedure TExample.Execute;
var ozoneConcentration: word;
begin
  { Create IP connection }
  ipcon := TIPConnection.Create;

  { Create device object }
  o := TBrickletOzone.Create(UID, ipcon);

  { Connect to brickd }
  ipcon.Connect(HOST, PORT);
  { Don't use device before ipcon is connected }

  { Get current ozone concentration (unit is ppb) }
  ozoneConcentration := o.GetOzoneConcentration;
  WriteLn(Format('Ozone Concentration: %d ppb', [ozoneConcentration]));

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
