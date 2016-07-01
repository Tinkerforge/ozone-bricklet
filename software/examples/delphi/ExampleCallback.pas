program ExampleCallback;

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
    procedure OzoneConcentrationCB(sender: TBrickletOzone;
                                   const ozoneConcentration: word);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'XYZ'; { Change XYZ to the UID of your Ozone Bricklet }

var
  e: TExample;

{ Callback procedure for ozone concentration callback (parameter has unit ppb) }
procedure TExample.OzoneConcentrationCB(sender: TBrickletOzone;
                                        const ozoneConcentration: word);
begin
  WriteLn(Format('Ozone Concentration: %d ppb', [ozoneConcentration]));
end;

procedure TExample.Execute;
begin
  { Create IP connection }
  ipcon := TIPConnection.Create;

  { Create device object }
  o := TBrickletOzone.Create(UID, ipcon);

  { Connect to brickd }
  ipcon.Connect(HOST, PORT);
  { Don't use device before ipcon is connected }

  { Register ozone concentration callback to procedure OzoneConcentrationCB }
  o.OnOzoneConcentration := {$ifdef FPC}@{$endif}OzoneConcentrationCB;

  { Set period for ozone concentration callback to 1s (1000ms)
    Note: The ozone concentration callback is only called every second
          if the ozone concentration has changed since the last call! }
  o.SetOzoneConcentrationCallbackPeriod(1000);

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
