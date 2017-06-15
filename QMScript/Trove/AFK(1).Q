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
MacroID=ad076685-b000-4bf4-aa43-b791abab3bdb
Description=AFK
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


Plugin.Bkgnd.KeyDown handle, 87
Delay 1500
Plugin.Bkgnd.KeyUp handle, 87

Plugin.Bkgnd.KeyDown handle, 83
Delay 1500
Plugin.Bkgnd.KeyUp handle, 83

Plugin.Bkgnd.KeyDown handle, 87
Delay 1500
Plugin.Bkgnd.KeyUp handle, 87

Plugin.Bkgnd.KeyDown handle, 83
Delay 1500
Plugin.Bkgnd.KeyUp handle, 83



Delay 100
Plugin.Bkgnd.KeyUp handle, 69
Delay 1000

Plugin.Bkgnd.RightClick handle, 300, 300
Delay 1000


Loop
