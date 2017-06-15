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
MacroID=f04ce2d9-1fe8-4261-bdf2-3425e8481266
Description=ÎÒµÄ½Å±¾2
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
handle = Plugin.Window.MousePoint()


Call Plugin.Bkgnd.LeftDown(handle, 593, 438)
Delay 200
Call Plugin.Bkgnd.LeftUp(handle, 593, 438)
