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
MacroID=5f92a3c2-fe12-4490-9947-1b0c2f311726
Description=InMinePortal
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
Call Lib.CC.Initailize()
MessageBox Lib.CC.InMinePortal()


Function InMinePortal()
	Call Lib.CC.GetCharPos()
	If CharX = 30 Then 
		InMinePortal = True
	Else 
		InMinePortal = False
	End If
End Function
