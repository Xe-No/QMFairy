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
MacroID=1c8cf0fe-d627-41bb-a4fe-c4bb478ccf76
Description=MinePos
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
Call Lib.CC.GetCharPos()
dm.WriteFile "C:\Users\Administrator\Documents\MinePos.txt",CharX&","&CharY&","&CharZ&vbcrlf
