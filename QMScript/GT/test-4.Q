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
MacroID=3b4c77af-1b82-46ed-9ee0-312c61839a8e
Description=test-4
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
GetCursorPos mx,my   

sRect = Plugin.Window.GetClientRect(handle)
dim MyArray
MyArray = Split(sRect, "|")   
//下面这句将字符串转换成数值   
L = Clng(MyArray(0)): T = Clng(MyArray(1))   
R = Clng(MyArray(2)) : B = Clng(MyArray(3))

CX = mx - L
CY = my - T

If CX < 512 Then 
	Call Plugin.Bkgnd.KeyDown(handle, 65)
	Else 
	Call Plugin.Bkgnd.KeyDown(handle, 68)
End If
Delay 100

While 0 = 0
	Call Plugin.Bkgnd.LeftClick(handle, CX, CY)
	Delay 50
Wend


Sub CancelPress

If CX < 512 Then 
	Call Plugin.Bkgnd.KeyUp(handle, 65)
	Else 
	Call Plugin.Bkgnd.KeyUp(handle, 68)
End If

End Sub

Sub OnScriptExit
	Call CancelPress
End Sub
