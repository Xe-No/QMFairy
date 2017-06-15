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
MacroID=1dfc535c-1041-48b9-9b78-0183533e891e
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

Call Lib.CC.Initailize()


dm_ret = dm.BindWindow(handle, "dx2", "dx2", "dx", 0)
fooX1 = 100
fooY1 = 400
fooX1 = 100
fooY1 = 400
foobar = dm.CreateFoobarCustom(handle, fooX1, fooY1, "UI2.bmp", "FFFF0F", 1.0)

Sub OnScriptExit
	
	dm_ret = dm.UnBindWindow()
	
End Sub

Do


Select Case GetLastKey
	Case 107  //+
		index = index + 1
		Call dm.FoobarPrintText(foobar, "Pass +, current pass :" & index, "000000")
	Case 109  //-	
		index = index - 1
		Call dm.FoobarPrintText(foobar, "Pass -, current pass :" & index, "000000")
	
	Case 116 //查看物品
		Call Lib.CC.GetEntityPos(Index)
		Call Lib.CC.GetEntityID(Index)

		info =  "物品ID: " & EntityID & " | 物品类型: " & EntityType &" | 物品数量: "& EntityNum
		Call dm.FoobarPrintText(foobar, info, "000000")	
	Case Else
	
	
	
End Select

//Call dm.FoobarPrintText(foobar, info, colorL(info_type))

Delay 100
Loop



