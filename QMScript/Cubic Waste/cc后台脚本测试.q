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
MacroID=42f4f709-17bd-4607-bab1-8de947e37992
Description=∫ÛÃ®≤‚ ‘
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
Call Plugin.Window.Move(handle, 0, 0)
Randomize

Call Plugin.Bkgnd.KeyPress(handle, 32)

While 0 = 0
	Call Plugin.Bkgnd.LeftClick(handle,int(Rnd()*160+560),int(Rnd()*160+400))
	Delay 200
Wend

Sub OnScriptExit
	MessageBox "_(:ßŸ°π°œ)"
End Sub


