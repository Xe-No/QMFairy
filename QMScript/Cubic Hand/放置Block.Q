[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=37c04324-f263-40bd-b144-218fd05aa127
Description=∑≈÷√Block
Enable=0
AutoRun=0
[Repeat]
Type=1
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
handle = Plugin.Window.MousePoint()

ct = 350
For 85
Call Plugin.Bkgnd.LeftClick(handle, 560, 560)
Delay ct
Call Plugin.Bkgnd.LeftClick(handle, 640, 540)
Delay ct
Call Plugin.Bkgnd.LeftClick(handle, 720, 540)
Delay ct
Delay ct/3
Next
