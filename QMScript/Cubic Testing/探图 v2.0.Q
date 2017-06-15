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
MacroID=0928a462-54b7-4a14-a3db-8868ab4ad10d
Description=探图 v2.0
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
v2.0 并入函数库，追加更新
v1.0

[Script]
Call Lib.CC.Initailize()

Call Lib.CC.GetWorldSize()
Call Lib.CC.GetCharPos()

//初始化窗口
fooX1 = 210 - 2 * SizeX
fooY1 = 740 - 2 * SizeY
fooWide = 4 * SizeX 
fooHght = 4 * SizeY
foobar = dm.CreateFoobarRect(handle, fooX1, fooY1, fooWide, fooHght)
Delay 100


For i = 0 To SizeX - 1
	For j = 0 To SizeY - 1
		If Lib.CC.ReadBlock(i, j, Round(CharZ) ) <> 0 Then 
			dm_ret = dm.FoobarFillRect(foobar, 4 * i , 4 * j , 4 * i + 4, 4 * j + 4, "000000")
		End If
	Next
Next
While 0=0
	Call Lib.CC.DrawCharPos()
	dm_ret = dm.FoobarUpdate(foobar)
	Delay 250
Wend



