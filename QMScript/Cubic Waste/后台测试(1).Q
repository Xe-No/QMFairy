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
MacroID=4681d990-794a-4490-8254-25c35c2d4d63
Description=后台测试
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
Call lib.网游.方形渐开线(400,300,20,20)
Randomize

While 0 = 0
	Call Plugin.Bkgnd.LeftClick(handle,int(Rnd()*160+560),int(Rnd()*160+400))
	Delay 200
Wend

Sub OnScriptExit
	Call Plugin.Window.Restore(handle)
	MsgBox "空降成功 :3",1,"提示"
End Sub



