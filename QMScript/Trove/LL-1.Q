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
MacroID=9ed38e22-c899-4f51-95f5-3c1562254ce4
Description=LL:Q11111
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
Hwnd = Plugin.Window.MousePoint()

Plugin.Bkgnd.KeyPress Hwnd, 81
Delay 700

For 5
Plugin.Bkgnd.KeyPress Hwnd, 49 
Delay 1400
Next
