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
MacroID=680e48c3-4ee8-43f5-a2c2-7f1469233a6a
Description=采集特定多种方块【设置】【旧版本】
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
UserVar up_string = "143" "地表"
UserVar down_string = "579" "地下"
//----------结束----------





t0 = Plugin.GetSysInfo.GetTime()

Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()

BlockCount = 0

TracePrint "Start"
up_array = Split(up_string, ",")
For Each ID In up_array
	Call Lib.CC.ReapBlock(CInt(ID),"up")
Next

down_array = Split(down_string, ",")
For Each ID In down_array 
	Call Lib.CC.ReapBlock(CInt(ID),"down")
Next

Sub OnScriptExit
t1 = Plugin.GetSysInfo.GetTime()
MessageBox BlockCount & Chr(13) & t1-t0
End Sub

