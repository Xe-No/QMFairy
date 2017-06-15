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
MacroID=781e4fbf-8e11-44ed-b63e-0b240fdec3e8
Description=PianoMove
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
handle_1 = Plugin.Window.MousePoint()

Do
Delay 100
Loop While WaitKey() <> 115

handle_2 = Plugin.Window.MousePoint()

Do
Delay 100
Loop While WaitKey() <> 115

Call Plugin.Bkgnd.RightDown(handle_1, 640, 480)
//Call Plugin.Bkgnd.KeyDown(handle_1, 87)
Call Plugin.Bkgnd.RightDown(handle_2, 640, 480)


Do
Delay 100
Loop While WaitKey() <> 115

Sub OnScriptExit

Call Plugin.Bkgnd.RightUp(handle_1,640, 480)
Call Plugin.Bkgnd.RightUp(handle_2,640, 480)


End Sub
