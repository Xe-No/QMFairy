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
MacroID=ab4cc651-6b26-4ab3-98a0-891d4e5a972a
Description=数组相加测试
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
//数组相加测试


a = Array(1, 2, 3)
B = Array(2, 3, 4)

c = a + b 

MessageBox c(0)
