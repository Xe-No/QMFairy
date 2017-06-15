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
MacroID=2da91737-03ee-41de-8f2e-4940450785ff
Description=FindAndClick
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
//暂未加入lib

Call Lib.CC.Initailize()
dm_ret = dm.BindWindow(handle, "dx2", "dx2", "dx", 0)

Delay 100
Dm.SetPath "C:\Users\Administrator\Documents\DmRes"'大漠全局路径设置

Do
Delay 200
Loop While FindAndClick(handle, "Smith") <> 0
MessageBox IntX &" "& intY

Function FindAndClick(handle, pic_name)
	If dm.FindPic(0, 0, 1280, 960, pic_name & ".bmp", "000000", 0.8, 2, intX, intY) = 0 Then 
		Call Lib.CC.BindClick(intX, intY)
		FindAndClick = 0
	Else 
		FindAndClick = -1
	End If
End Function
