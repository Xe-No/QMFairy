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
MacroID=0f414bbc-ec08-44ac-bece-2a3efcb85b62
Description=Item-Teleporter-9【领域级】【小地图】
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
Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()

Block_Count = 0

//初始化窗口
fooX1 = 50
fooY1 = 660
fooWide = SizeX * 4 + 1
fooHght = SizeY * 4 + 1
//fooWide = 241
//fooHght = 241
foobar = dm.CreateFoobarRect(handle, fooX1, fooY1, fooWide, fooHght)
Delay 200
dm_ret = dm.FoobarDrawLine(foobar, fooWide/2, 0, fooWide/2, fooHght, "808080", 0, 1)
dm_ret = dm.FoobarDrawLine(foobar, 0, fooHght / 2, fooWide, fooHght / 2, "808080", 0, 1)


Scan 




Sub Scan
Dim Index, Zero_Counter
Index = 1
Zero_Counter = 0

Do
	
Call Lib.CC.GetEntityPos(Index)


If EntityX = 0 And EntityY = 0 And EntityZ = 0 Then 
	Zero_Counter = Zero_Counter + 1
Else 
	Zero_Counter = 0
	
	//If Int(EntityX) - EntityX = 0 And Int(EntityY) - EntityY = 0 And Int(EntityY) - EntityY = 0 Then 
	//	Call Lib.CC.TP(EntityX, EntityY, EntityZ)
	//	dm.WaitKey 115,0
	//End If

	GetEntityID Index
	//If EntityType = 5 And EntityID <= 99 And EntityID >= 94 Then 
	If EntityID <= 99 And EntityID >= 94  Then 
		dm_ret = dm.FoobarFillRect(foobar, 4 * EntityX + 1, 4 * EntityY + 1, 4 * EntityX + 4, 4 * EntityY + 4, "FF9c3b")//标出坐标
		Block_Count = Block_Count + 1
	End If
	
End If


Index = Index + 1

If Zero_Counter > 4 Then 
	Exit Do
End If

Loop
End Sub

MessageBox Block_Count


While 0=0
	Call DrawCharPos
	dm_ret = dm.FoobarUpdate(foobar)
	Delay 500
Wend



Sub Attract

Dim Index
Do
	
Call Lib.CC.GetEntityPos(Index)
If EntityX = 0 And EntityY = 0 And EntityZ = 0 Then 
	Exit Do
End If

GetEntityID Index

If EntityID = 540 Then 
	Call Lib.CC.GetCharPos()
	Call Lib.CC.SetEntityPos(Index, CharX, CharY, CharZ)
End If






Index = Index + 1
Loop

End Sub






Function GetEntityID(index)
	EntityID = dm.ReadInt(handle, "[[[<Cubic.exe>+002F29BC]+9C0]+" & Hex(4 * index) & "]+F2", 1)
	EntityType = dm.ReadInt(handle, "[[[<Cubic.exe>+002F29BC]+9C0]+" & Hex(4 * index) & "]+F4", 1)
End Function


Sub DrawCharPos
	dm_ret = dm.FoobarTextRect(foobar,5,5,100,200)
	dm_ret = dm.FoobarClearText(foobar)
	Call Lib.CC.GetCharPosInt()
	dm_ret = dm.FoobarPrintText(foobar,CharX&"|"&CharY&"|"&CharZ,"FF0000")
	dm_ret = dm.FoobarFillRect(foobar, 4*CharX+1 , 4*CharY + 1, 4*CharX+4 , 4*CharY + 4, "FF0000")
	
End Sub
