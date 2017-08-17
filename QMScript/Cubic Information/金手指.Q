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
MacroID=09511b38-724e-4af6-bd4e-65e91c50809a
Description=金手指
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
【功能说明】
方块鉴别系统，传送系统
【使用说明】
启动脚本之后
-F1 获取鼠标所指方块坐标及方块ID，并保存此坐标
-F2 获取脚下位置对应的方块坐标及方块ID，并保存此坐标
-F3 传送到鼠标所指的地点
-F4 传送到保存点
-F5 查看鼠标所指玻璃中的物品
-F6 查看鼠标所指方块的具体数据

[Script]
//金手指

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
		pass_num = pass_num + 1
		Call dm.FoobarPrintText(foobar, "Pass +, current pass :" & pass_num, "000000")
	Case 109  //-	
		pass_num = pass_num - 1
		Call dm.FoobarPrintText(foobar, "Pass -, current pass :" & pass_num, "000000")
	Case 117  //F1  获取鼠标所指方块坐标及方块ID，并保存此坐标
		Call Lib.CM.GetCursorBlockPos(pass_num)
		SX = GoldX
		SY = GoldY
		SZ = GoldZ	
		info = "方块ID: " & Lib.CC.ReadBlock(SX, SY, SZ) & vbCrLf & "方块坐标: " & GoldX & "|" & GoldY & "|" & GoldZ
		Call dm.FoobarPrintText(foobar, info, "000000")
		
	Case 113  //F2  获取脚下位置对应的方块坐标及方块ID，并保存此坐标
		Call Lib.CC.GetCharPos()
		SX = CharX
		SY = CharY
		SZ = CharZ
		info = "方块ID: " & Lib.CC.ReadBlock(SX, SY, SZ) & vbCrLf & "方块坐标: " & SX & "|" & SY & "|" & SZ
		Call dm.FoobarPrintText(foobar, info , "000000")
	Case 114  //F3 传送到鼠标所指的地点
		Call Lib.CM.GetCursorBlockPos(pass_num)
		Call Lib.CC.TP(GoldX, GoldY, GoldZ - 1)
		Call dm.FoobarPrintText(foobar, "传送到"&GoldX&","& GoldY&","& GoldZ - 1, "000000")
	Case 115//F4 传送到保存点
		Call Lib.CC.TP(SX,SY, SZ - 1)
		Call dm.FoobarPrintText(foobar, "传送到"&SX&","& SY&","& SZ - 1, "000000")
	Case 116 //F5 查看鼠标所指玻璃中的物品
		Call Lib.CM.GetCursorBlockPos(pass_num)
		Call GetItem(SX,SY,SZ)
	Case 117 //F6 查看鼠标所指方块的具体数据
		Call Lib.CM.GetCursorBlockPos(pass_num)
		info = "方块ID: " & Lib.CC.ReadBlock(GoldX, GoldY, GoldZ) & vbCrLf & "方块坐标: " & GoldX & "|" & GoldY & "|" & GoldZ & vbCrLf & "方块数据：" &Lib.CC.ReadBlockData(GoldX, GoldY, GoldZ)
		Call dm.FoobarPrintText(foobar, info, "000000")
		
		
		
	Case Else
	
	
	
End Select

//Call dm.FoobarPrintText(foobar, info, colorL(info_type))

Delay 100
Loop


Function GetItem(bx,by,bz)
Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()


Dim Index, Zero_Counter, Reset_Counter
Index = 0
Zero_Counter = 0
index_bound = 0

Do
	
Call Lib.CC.GetEntityPos(Index)
Call Lib.CC.GetEntityID(Index)


//获取实体上界
If -1 < EntityX < SizeX And -1  < EntityY < SizeY And -1  < EntityZ < SizeZ  Then 
	index_bound = index 
	
Else 
	Zero_Counter = Zero_Counter + 1
	
End If


Index = Index + 1

If Zero_Counter > 1 Then 
	
	Delay 200
	Exit Do
End If


Loop

TracePrint index_bound

For index = index_bound To 0 Step -1

Call Lib.CC.GetEntityPos(Index)
Call Lib.CC.GetEntityID(Index)

//Collect
If  round(EntityX) = bx And  round(EntityY) = by And round(EntityZ) = bz  Then 
	info =  "物品ID: " & EntityID & " | 物品类型: " & EntityType &" | 物品数量: "& EntityNum
	Call dm.FoobarPrintText(foobar, info, "000000")
End If

Next


TracePrint "Reap"

Delay 1000

End Function
