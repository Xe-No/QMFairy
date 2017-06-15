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
MacroID=169badcc-ebd7-4024-8965-1844970ad9be
Description=Random Mine
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

handle = Plugin.Window.MousePoint
Randomize

Delay_Time = 200
Center_X = 640
Center_Y = 480
Bias_X = 240
Bias_Y = 240
 
While True
	Call Plugin.Bkgnd.LeftClick(handle, Center_X + Bias_X * (0.5 - Rnd()) ,Center_Y + Bias_Y * (0.5 - Rnd()) )
	Delay Delay_Time
Wend
