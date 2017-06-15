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
MacroID=35c15495-87dc-4d19-8734-8980aae624a2
Description=我的脚本2
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

返回值 = Lib.CC.TP(0,0,0)


Call Lib.CC.GetCameraFocus()

MessageBox CamX
