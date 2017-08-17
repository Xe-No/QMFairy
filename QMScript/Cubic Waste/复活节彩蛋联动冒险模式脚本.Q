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
MacroID=8d0bb525-e997-4650-811a-17b823b2197f
Description=复活节彩蛋联动冒险模式脚本
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


//
//ReapEgg
//
//EndScript


Do

Call Lib.CC.TP(28, 8, 97)

Call MoveForeward

Call Restart

Call Lib.CM.WaitLoading()

//等待绿色字体
Delay 7000
//Do
//	If dm.GetColor(684, 348) = "7fff7f" Then 
//		Exit Do
//	End If
//
//	Delay 50
//Loop

Call ReapEgg

Delay 2000

Call Lib.CC.TP(22, 48, 92)

Call MoveForeward

//洞穴

Delay 1000

Call Lib.CM.WaitLoading()

Call ReapEgg

//Call Lib.CC.TP(19, 1, 95)
//
//Call MoveForeward
//

//村子

//Delay 1000
//
//Call Lib.CM.WaitLoading()
//
//Call ReapEgg


//结束

Call Lib.CC.BindClick(1260,20)

Call Quit

Delay 1000

Call Lib.CM.WaitLoading()

Loop

Sub Restart
	
Do
	If dm.GetColor(880, 550) = "ffc0cb" Then 
		Exit Do
	End If

	Delay 50
Loop 


//点击红色字体，重置冒险
Call Lib.CC.BindClick(640, 550)

TracePrint "Restart"
	
End Sub

Sub Quit

Do
	If dm.GetColor(880, 650) = "ffc0cb" Then 
		Exit Do
	End If

	Delay 50
Loop 


//点击红色字体，退出冒险
Call Lib.CC.BindClick(640, 650)

End Sub

Sub MoveForeward
	
dm.KeyDownChar "W"

Delay 500

dm.KeyUpChar "W"

TracePrint "Move"
End Sub

Function ReapEgg
Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()

reset_time = 2

For reset_time
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
If -1 < EntityX < SizeX And -1  < EntityY < SizeY And -1  < EntityZ < SizeZ And 94 <=  EntityID <=99 Then 
	Dim block
	block = Lib.CC.ReadBlock( round(EntityX) , round(EntityY) , round(EntityZ)  )
	
	If block <> 140 Then 
		Call Lib.CC.GetCharPos() 
		Call Lib.CC.GetEntityPos(Index)
		Call Lib.CC.TP(EntityX, EntityY, EntityZ)
		dm.KeyPressChar "W"
//		dm.WaitKey 115, 0
		Delay 200
	End If

End If

Next

Next

TracePrint "Reap"

Delay 1000

End Function
