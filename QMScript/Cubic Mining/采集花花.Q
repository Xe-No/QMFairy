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
MacroID=0d5bdc1e-e97e-4f95-aee4-8a7c3ea84f39
Description=采集花花【旧版本】
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
//----------配置区域----------

//方块ID
UserVar bias_z = -1 "竖直方向偏移"
//----------结束----------





t0 = Plugin.GetSysInfo.GetTime()

Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()

BlockCount = 0

//Call Lib.CC.ReapBlock(116,"up")
//Call Lib.CC.ReapBlock(117,"up")
//Call Lib.CC.ReapBlock(141,"up")
//Call Lib.CC.ReapBlock(142,"up")
Call Lib.CC.ReapBlock(143,"up")
//Call Lib.CC.ReapBlock(144,"up")



Sub OnScriptExit
t1 = Plugin.GetSysInfo.GetTime()
MessageBox BlockCount & Chr(13) & t1-t0
End Sub

