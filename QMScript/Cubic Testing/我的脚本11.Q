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
MacroID=1d5096c9-1f40-414b-a2f5-77b30ef657e6
Description=账号状态/文本载入测试
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
//文件载入测试
Call Lib.CC.Initailize()
dm.SetPath "C:\Users\Administrator\Documents\DmRes"'大漠全局路径设置

str = dm.ReadFile("ban_list.txt")
str = Split(str, Chr(13))

If GetAccState("Entropy_") = 0 Then 
	MessageBox "Banned"
End If

Function GetAccState(name)
//判断名字是否在banlist中
Dim ban_list
ban_list = dm.ReadFile("ban_list.txt")
ban_list = Split(ban_list, Chr(13))
For Each name_b in ban_list
	If name_b = name Then 
		GetAccState = 0
		Exit Function
	End If
Next

GetAccState = 1	
	
End Function
