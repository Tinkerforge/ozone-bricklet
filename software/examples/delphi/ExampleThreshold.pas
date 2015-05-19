program ExampleThreshold;

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
    procedure ReachedCB(sender: TBrickletOzone; const ozoneConcentration: word);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'XYZ'; { Change to your UID }

var
  e: TExample;

{ Callback for ozone concentration greater than 20 ppb }
procedure TExample.ReachedCB(sender: TBrickletOzone; const ozoneConcentration: word);
begin
  WriteLn(Format('Ozone Concentration: %d ppb.', [ozoneConcentration]));
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

  { Get threshold callbacks with a debounce time of 10 seconds (10000ms) }
  oz.SetDebouncePeriod(10000);

  { Register threshold reached callback to procedure ReachedCB }
  oz.OnOzoneConcentrationReached := {$ifdef FPC}@{$endif}ReachedCB;

  { Configure threshold for "greater than 20 ppb" }
  oz.SetOzoneConcentrationCallbackThreshold('>', 20, 0);

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
