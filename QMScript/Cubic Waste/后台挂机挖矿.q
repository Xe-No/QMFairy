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
MacroID=f0697208-426e-4b19-9648-b54e8478173d
Description=后台挂机挖矿
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
handle = Plugin.Window.MousePoint
Call Plugin.Window.Move(handle, 0, 0)
Randomize



sRect = Plugin.Window.GetClientRect(handle)
dim MyArray
MyArray = Split(sRect, "|")
//下面这句将字符串转换成数值
Wide = Clng(MyArray(2)) - Clng(MyArray(0))
Height = Clng(MyArray(3))-Clng(MyArray(1))
Msgbox Wide & "   "  & Height


While 0 = 0
	Call Plugin.Bkgnd.LeftClick(handle,int((Rnd()-0.5)*160+Wide/2),int((Rnd()-0.5)*160+Height/2))
	Delay 200
Wend

Sub OnScriptExit
	Call Plugin.Window.Restore(handle)
	MsgBox "空降成功 :3",1,"提示"
End Sub


