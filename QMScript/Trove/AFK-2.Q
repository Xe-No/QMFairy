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
MacroID=d2e36c2e-012a-4aaa-95dd-f3b2f537a07a
Description=AFK-2
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




Do

Plugin.Bkgnd.KeyDown handle, 69


Plugin.Bkgnd.KeyDown handle, 32
Delay 1500
Plugin.Bkgnd.KeyUp handle, 32

Plugin.Bkgnd.KeyDown handle, 32
Delay 1500
Plugin.Bkgnd.KeyUp handle, 32




Delay 100
Plugin.Bkgnd.KeyUp handle, 69
Delay 1000




Loop
