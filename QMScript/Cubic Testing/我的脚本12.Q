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
MacroID=7cea24b5-5310-4b01-bb98-4df1d638c132
Description=我的脚本1
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
//文件写入测试
Call Lib.CC.Initailize()


dm.WriteFile "AltsQuest.log",   "[" & Date & " " & Time & "]" & "Start Log" & vbCrLf
