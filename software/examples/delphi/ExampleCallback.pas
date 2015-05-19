program ExampleCallback;

{$ifdef MSWINDOWS}{$apptype CONSOLE}{$endif}
{$ifdef FPC}{$mode OBJFPC}{$H+}{$endif}

uses
  SysUtils, IPConnection, BrickletOzone;

type
  TExample = class
  private
    ipcon: TIPConnection;
    oz: TBrickletOzone;
  public
    procedure OzoneConcentrationCB(sender: TBrickletOzone; const ozoneConcentration: word);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'XYZ'; { Change to your UID }

var
  e: TExample;

{ Callback function for ozone concentration callback (parameter has unit ppb) }
procedure TExample.OzoneConcentrationCB(sender: TBrickletOzone; const ozoneConcentration: word);
begin
  WriteLn(Format('Ozone Concentration: %d ppb', [ozoneConcentration]));
end;

procedure TExample.Execute;
begin
  { Create IP connection }
  ipcon := TIPConnection.Create;

  { Create device object }
  oz := TBrickletOzone.Create(UID, ipcon);

  { Connect to brickd }
  ipcon.Connect(HOST, PORT);
  { Don't use device before ipcon is connected }

  { Set Period for ozone concentration callback to 1s (1000ms)
    Note: The ozone concentration callback is only called every second if the
          ozone concentration has changed since the last call! }
  oz.SetOzoneConcentrationCallbackPeriod(1000);

  { Register ozone concentration callback to procedure OzoneConcentrationCB }
  oz.OnOzoneConcentration := {$ifdef FPC}@{$endif}OzoneConcentrationCB;

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
