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
MacroID=5c75e8e4-590b-4efe-adc8-c7be8c9f9cfd
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
//任务检查测试

//path = "D:\GameData\CC\TextRecognition\CCTR.wls"
//RunApp path

UserVar Kernel_Number = 1 "核心编号"
UserVar Kernel_Max = 4 "核心总数"


Call Lib.CC.Initailize()
IsBind = dm.BindWindow(handle, "dx2", "dx2", "dx", 0)
Delay 500
Dm.SetPath "C:\Users\Administrator\Documents\DmRes"'大漠全局路径设置

Call Lib.CM.CheckQuestXX(1)
