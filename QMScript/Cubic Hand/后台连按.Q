[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=120
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=c8354fba-a86c-4cd6-b4f9-37561b3f25b0
Description=后台连按
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
UserVar Delay_Time = 200 "dt"
UserVar Key_Code = DropList{"W":87|"R":82|"T":84} "连点按键"


handle = Plugin.Window.MousePoint


Do
	Call Plugin.Bkgnd.KeyPress(handle, key_code)
	Delay Delay_Time
Loop
