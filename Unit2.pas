{*******************************************************************************
  MRX Gamepad Sample
********************************************************************************
  A demo application showcasing the capabilities of the MRX Gamepad Core and
  the Settings UI.
  Author:  Lara Miriam Tamy Reschke
  License: MIT
  Key Features:
  - Live Logging: Displays real-time input events (buttons pressed/released,
    analog axis values) in a TMemo.
  - Rumble Testing: Buttons to trigger haptic feedback on Player 0 and 1.
  - Settings Integration: Button to open the TfrmGamepadSettings modally.
*******************************************************************************}
{ MRX-Gamepad-Core v0.1                                                        }
{ by Lara Miriam Tamy Reschke                                                  }
{                                                                              }
{------------------------------------------------------------------------------}
{
 ----Latest Changes
   v 0.1 (Alpha):
     - Initial Release.
     - Linked TMRXGamepadCore events to the UI TMemo.
     - Added Rumble test buttons for 500ms bursts.
     - Clean, minimal layout to demonstrate core functionality.
}
unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, uMRX_GamepadCore,
  uMRX_GamepadSettings;

type
  /// <summary>
  /// Demo form showing how to use the TMRXGamepadCore and Settings.
  /// </summary>
  TForm2 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FGamepadCore: TMRXGamepadCore;
    FMemo: TMemo;
    FBtnSettings: TButton;
    FBtnRumble: TButton;
    FBtnRumble2: TButton;
    procedure OnGamepadInput(Sender: TObject; PadID: Integer; Element: TGamepadElement; Pressed: Boolean; Value: Single);
    procedure BtnSettingsClick(Sender: TObject);
    procedure BtnRumbleClick(Sender: TObject);
    procedure BtnRumble2Click(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
{$R *.fmx}

procedure TForm2.FormCreate(Sender: TObject);
begin
  Caption := 'MRX Gamepad Sample';
  Width := 600;
  Height := 400;
  // Rumble Test Buttons
  FBtnRumble := TButton.Create(Self);
  FBtnRumble.Parent := Self;
  FBtnRumble.Text := 'Rumble Test (Player 0)';
  FBtnRumble.Align := TAlignLayout.Top;
  FBtnRumble.Height := 40;
  FBtnRumble.OnClick := BtnRumbleClick;
  FBtnRumble2 := TButton.Create(Self);
  FBtnRumble2.Parent := Self;
  FBtnRumble2.Text := 'Rumble Test (Player 1)';
  FBtnRumble2.Align := TAlignLayout.Top;
  FBtnRumble2.Height := 40;
  FBtnRumble2.OnClick := BtnRumble2Click;
  // Settings Button
  FBtnSettings := TButton.Create(Self);
  FBtnSettings.Parent := Self;
  FBtnSettings.Text := 'Open Settings';
  FBtnSettings.Align := TAlignLayout.Bottom;
  FBtnSettings.Height := 40;
  FBtnSettings.OnClick := BtnSettingsClick;
  // Log Memo
  FMemo := TMemo.Create(Self);
  FMemo.Parent := Self;
  FMemo.Align := TAlignLayout.Client;
  FMemo.Lines.Clear;
  FMemo.Lines.Add('MRX Gamepad Sample');
  FMemo.Lines.Add('Waiting for SDL3...');
  // Initialize Core
  FGamepadCore := TMRXGamepadCore.Create;
  FGamepadCore.OnInputEvent := OnGamepadInput;
  try
    FGamepadCore.Initialize;
    FMemo.Lines.Add('SDL3 loaded successfully! Press buttons on your gamepad.');
  except
    on E: Exception do
      FMemo.Lines.Add('ERROR: ' + E.Message);
  end;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FGamepadCore.Free;
end;

procedure TForm2.OnGamepadInput(Sender: TObject; PadID: Integer; Element: TGamepadElement; Pressed: Boolean; Value: Single);
var
  BtnName, StateStr: string;
begin
  BtnName := 'Unknown';
  case Element of
    geBtnA:
      BtnName := 'A';
    geBtnB:
      BtnName := 'B';
    geBtnX:
      BtnName := 'X';
    geBtnY:
      BtnName := 'Y';
    geLB:
      BtnName := 'LB';
    geRB:
      BtnName := 'RB';
    geStart:
      BtnName := 'Start';
    geBack:
      BtnName := 'Back';
    geGuide:
      BtnName := 'Guide (Xbox)';
    geLeftStickClick:
      BtnName := 'L3 (Stick Click)';
    geRightStickClick:
      BtnName := 'R3 (Stick Click)';
    gePadUp:
      BtnName := 'D-Pad Up';
    gePadDown:
      BtnName := 'D-Pad Down';
    gePadLeft:
      BtnName := 'D-Pad Left';
    gePadRight:
      BtnName := 'D-Pad Right';
    geExtra1:
      BtnName := 'Extra1 (Share/Paddle)';
    geExtra2:
      BtnName := 'Extra2 (Paddle)';
    geExtra3:
      BtnName := 'Extra3 (Paddle)';
    geExtra4:
      BtnName := 'Extra4 (Paddle)';
    geLeftStickX:
      BtnName := 'Left Stick X';
    geLeftStickY:
      BtnName := 'Left Stick Y';
    geRightStickX:
      BtnName := 'Right Stick X';
    geRightStickY:
      BtnName := 'Right Stick Y';
    geLT:
      BtnName := 'Trigger Left (LT)';
    geRT:
      BtnName := 'Trigger Right (RT)';
  end;
  // Log analog axes only if value exceeds threshold to prevent spam
  if Element in [geLeftStickX, geLeftStickY, geRightStickX, geRightStickY, geLT, geRT] then
  begin
    if Abs(Value) > 0.1 then
      FMemo.Lines.Add(Format('[Pad %d] %s: %.2f', [PadID, BtnName, Value]));
  end
  else
  begin
    // Standard buttons
    if Pressed then
      StateStr := 'pressed'
    else
      StateStr := 'released';
    FMemo.Lines.Add(Format('[Pad %d] %s %s', [PadID, BtnName, StateStr]));
  end;
end;

procedure TForm2.BtnSettingsClick(Sender: TObject);
var
  FrmSettings: TfrmGamepadSettings;
begin
  // Open settings form modally
  FrmSettings := TfrmGamepadSettings.Create(Self, FGamepadCore);
  try
    FrmSettings.ShowModal;
  finally
    FrmSettings.Free;
  end;
end;

procedure TForm2.BtnRumbleClick(Sender: TObject);
begin
  FGamepadCore.Rumble(0, 65535, 65535, 500);
end;

procedure TForm2.BtnRumble2Click(Sender: TObject);
begin
  FGamepadCore.Rumble(1, 65535, 65535, 500);
end;

end.

