program Project1;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {Form2},
  uMRX_GamepadSettings in 'uMRX_GamepadSettings.pas' {frmGamepadSettings};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TfrmGamepadSettings, frmGamepadSettings);
  Application.Run;
end.
