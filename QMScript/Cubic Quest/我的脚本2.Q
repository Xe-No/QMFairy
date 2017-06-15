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
MacroID=e5362a55-ea0f-4d35-b716-1a80626ace7f
Description=烟花
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

	Set dm = createobject("dm.dmsoft")//创建对象
	dm.waitkey 116,0
	handle1 = Plugin.Window.MousePoint
	Delay 1000
	dm.waitkey 116,0
	handle2 = Plugin.Window.MousePoint
	Delay 1000
	dm.waitkey 116,0
	handle3 = Plugin.Window.MousePoint
	Delay 1000
	dm.waitkey 116,0
	handle4 = Plugin.Window.MousePoint
	Delay 1000

MessageBox "Locked"
Do
	
dm.waitkey 115,0
Call Plugin.Bkgnd.LeftClick(handle1, 560, 480)
Call Plugin.Bkgnd.LeftClick(handle2, 560, 480)
Call Plugin.Bkgnd.LeftClick(handle3, 560, 480)
Call Plugin.Bkgnd.LeftClick(handle4, 560, 480)
Loop
