program Project2;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit2 in 'Unit2.pas' {Form2},
  uMRX_GamepadCore in 'uMRX_GamepadCore.pas',
  uMRX_GamepadSettings in 'uMRX_GamepadSettings.pas' {frmGamepadSettings};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TfrmGamepadSettings, frmGamepadSettings);
  Application.Run;
end.
