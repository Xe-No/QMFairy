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
MacroID=d404e441-dc0d-4081-98aa-b8fc5d4efcf3
Description=复活节彩蛋
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
//
UserVar WorldName = DropList{"Eden":"WorldE"|"Tinker":"WorldT"|"Pelago":"WorldP"|"Spyre":"WorldS"|"Aspen":"WorldA"} "世界名称"

Call Lib.CC.Initailize()
dm_ret = dm.BindWindow(handle, "dx2", "dx2", "dx", 0)

//
//ReapEgg
//
//EndScript

Delay 100
Dm.SetPath "C:\Users\Administrator\Documents\DmRes"'大漠全局路径设置


Rem Start
For World_Index = 1 To 50

Call TPMine(WorldName, World_Index)
Call JumpForward
If WaitLoadingNew = 1 Then 
	Goto Skip
End If
Call Hunt//

Call Lib.CM.WaitLoading
Delay 1500

Rem Skip
Next

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

reset_time = 1

For reset_time
Dim Index, Zero_Counter, Reset_Counter
Index = 0
Zero_Counter = 0
index_bound = 0

Do
	
Call Lib.CC.GetEntityPos(Index)
Call Lib.CC.GetEntityID(Index)


//获取实体上界
If -1 < EntityX < SizeX And -1  < EntityY < SizeY And -1  < EntityZ < SizeZ Or EntityType = 236 Then
	index_bound = index
	If index_bound > 1000 Then 
		Exit Do
	End If
	
Else 
	Zero_Counter = Zero_Counter + 1
	
End If


Index = Index + 1

If Zero_Counter > 1 Then 
	
	Delay 200
	Exit Do
End If


Loop

Delay 50

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
		dm.KeyPressChar "S"
//		dm.WaitKey 115, 0
		Delay 100
	End If

End If

Next

Next

TracePrint "Reap"

Delay 1000

End Function

Function ScanPpl
Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()

reset_time = 1

For reset_time
Dim Index, Zero_Counter, Reset_Counter
Index = 0
Zero_Counter = 0
index_bound = 0

Do
	
Call Lib.CC.GetEntityPos(Index)
Call Lib.CC.GetEntityID(Index)


//获取实体上界
If -1 < EntityX < SizeX And -1  < EntityY < SizeY And -1  < EntityZ < SizeZ Or EntityType = 236 Then 
	index_bound = index 
	
Else 
	Zero_Counter = Zero_Counter + 1
	
End If

ScanPpl = 0

Index = Index + 1

If Zero_Counter > 1 Then 
	
	Delay 200
	Exit Do
End If


Loop

Delay 100

TracePrint index_bound

For index = index_bound To 0 Step -1

Call Lib.CC.GetEntityPos(Index)
Call Lib.CC.GetEntityID(Index)

//Collect
If -1 < EntityX < SizeX And -1  < EntityY < SizeY And -1  < EntityZ < SizeZ And EntityType = 236 Then 
	ScanPpl = ScanPpl + 1

End If

Next

Next

TracePrint "Scanned"


End Function

Sub TPMine(WorldName, MineIndex)
Dim MyString, MyArray
MinePos = Lib.文件.读取指定行文本内容("C:\Users\Administrator\Documents\DmRes\" & WorldName & ".txt",MineIndex)
If MinePos = "" Then 
//EndScript
Goto Start
Else 
	MyString = Split(MinePos, ",", - 1 , 1)
	MineX = CSng(MyString(0))
	MineY = CSng(MyString(1))
	MineZ = CSng(MyString(2))
	
	返回值 = Lib.CC.TP(MineX, MineY, MineZ)
	Delay 1000
End If
	
	
End Sub


Sub JumpForward

Delay 200
dm.KeyDownChar "W"
Delay 16
dm.KeyDownChar "Space"
Delay 219
dm.KeyUpChar "Space"
Delay 31
dm.KeyUpChar "W"
Delay 200

End Sub


Sub Hunt
Dim index

Delay 1000
Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()


ppl = ScanPpl
If ppl = 1 Then 
	Call ReapEgg
End If


Rem SkipHunting
Delay 1000
Call Lib.CC.CubicClick(handle, 1256, 22)
Delay 1000
Call Lib.CC.CubicClick(handle, 560, 536)

Delay 100
End Sub


Sub WaitInnerWorld

Do
Delay 1000
Loop Until Lib.CC.GetGameState() = "Realm"

End Sub


Sub WaitOverWorld

Do
Delay 1000
Loop Until Lib.CC.GetGameState() = "Main_World"

End Sub


Function AdrToPos(adr, off)
	Dim Arr(1)
	Arr(0) = adr
	Arr(1) = CStr(off)
	PStr = Join(Arr,"+")
	AdrToPos = dm.ReadInt(handle,PStr,2)
End Function

Sub OnScriptExit
	MessageBox BlockCount
End Sub


Function WaitLoadingNew()
Dim count_wln

count_wln = 0

Do
	Delay 200
	count_wln = count_wln + 1
	If count_wln > 50 Then 
		WaitLoadingNew = 1
		Exit Function
	End If
	
Loop Until Plugin.Bkgnd.GetPixelColor(handle, 10, 10) = "000000"

count_wln = 0

Do
	Delay 50
	count_wln = count_wln + 1
	If count_wln > 50 Then 
		WaitLoadingNew = 2
		Exit Function
	End If
Loop While Plugin.Bkgnd.GetPixelColor(handle, 741, 502) = "FFFFFF"
WaitLoadingNew = 0


End Function

