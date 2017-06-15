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
MacroID=fe62c27d-2a5c-499b-9819-8ada7b405458
Description=ÎÒµÄ½Å±¾1
Enable=0
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
//Hwnd = Plugin.Window.MousePoint 
//Call Plugin.Bkgnd.KeyDown(Hwnd, 87)
//
//Delay 2000
//
//Call Plugin.Bkgnd.KeyUp(Hwnd, 87)
//

KeyDown 68,1
Delay 200
KeyUp 68,1
