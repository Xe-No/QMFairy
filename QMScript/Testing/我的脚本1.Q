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
MacroID=e93e03a3-25f0-473a-8e39-2df51eec7101
Description=Á¬Ðøº°»°
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

For 1000
	Call Plugin.Bkgnd.KeyPress(handle, 13)
	Delay 50
	Call Plugin.Bkgnd.SendString(handle, "xD")
	Delay 50
	Call Plugin.Bkgnd.KeyPress(handle, 13)
	Delay 1000
Next
