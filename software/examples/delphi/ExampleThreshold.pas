program ExampleThreshold;

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
    procedure OzoneConcentrationReachedCB(sender: TBrickletOzone; const ozoneConcentration: word);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'XYZ'; { Change to your UID }

var
  e: TExample;

{ Callback procedure for ozone concentration reached callback (parameter has unit ppb) }
procedure TExample.OzoneConcentrationReachedCB(sender: TBrickletOzone;
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

  { Get threshold callbacks with a debounce time of 10 seconds (10000ms) }
  o.SetDebouncePeriod(10000);

  { Register ozone concentration reached callback to procedure OzoneConcentrationReachedCB }
  o.OnOzoneConcentrationReached := {$ifdef FPC}@{$endif}OzoneConcentrationReachedCB;

  { Configure threshold for ozone concentration "greater than 20 ppb" (unit is ppb) }
  o.SetOzoneConcentrationCallbackThreshold('>', 20, 0);

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
