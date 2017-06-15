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
MacroID=5b69020d-68c4-4373-8fa5-f016de966ee8
Description=Place-AltsRoomRefill
Enable=1
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
返回值 = Lib.CC.DMBind(handle)

Delay 1000
Call Lib.CC.GetWorldSize()
Call Lib.CC.GetCharPosInt()



Call Refill()
Call RefillEx()
Call RunApp("D:\GameData\CC\TextRecognition\CCTR.wls")
//Call ReapItem()
Sub OnScriptExit
	dm_ret = dm.UnBindWindow()
	
End Sub



Function Refill()

plat_z = 99
Position_Array = Array(440,500,560,720,780,840,900)
Start_X = 15 
For Index = 0 To 6

Call Lib.CC.BindClick( Position_Array(Index), 929)

Call PlaceBlock_Row(Start_X + 4 * Index) 

Next

End Function

Function RefillEx()

plat_z = 99
Position_Array = Array(440,500,560,720,780,840,900)
Start_X = 43

//点击下拉框
Call Lib.CC.CubicClick(handle,640,945)
Delay 500

For j = 0 To 4
	
	pix0 = 412
	piy0 = 732

	//背包栏间隔
	inter = 64
	//初始坐标

	x = j mod 8
	y = j \ 8
	pix = pix0 + inter * x
	piy = piy0 + inter * y
	
	Call Lib.CC.CubicClick(handle, pix, piy)
	
	Call PlaceBlock_Row(Start_X + 4 * j) 
Next

End Function



Function PlaceBlock_Row(central_x)   //外部变量 plat_z
Dim tarX, tarY, tarZ
Call Lib.CC.SetCamera(180, 45)

For tarY = 38 To 5 Step - 1 

For tarX = central_x - 1 To central_x + 1
trigger = 0


For tarZ = 99 To 97  Step -1

	If Lib.CC.ReadBlock(tarX, tarY, tarZ) = 0 Then 
		Call Lib.CC.TPT(tarX, tarY - 1, plat_z)
		Call PlaceBlock(tarX, tarY, tarZ)
		trigger = 1
		Delay 50
	End If


Next
If trigger = 1 Then
	dm.KeyPressChar "W"
	Delay 200
End If
Next
Next

End Function

Function ReapItem
Dim Index, Zero_Counter, TargetType, TargetID, Reset_Counter
Index = 1
Zero_Counter = 0
TargetType = 3
TargetID = 0
Reset_Counter = 0
Do
	
Call Lib.CC.GetEntityPos(Index)
Call Lib.CC.GetEntityID(Index)

//If 1 < EntityX < SizeX And 1  < EntityY < SizeY And 1  < EntityZ < SizeZ And 94 <= EntityID <= 99 Then 

If 1 < EntityX < SizeX And 1 < EntityY < SizeY And 1 < EntityZ < SizeZ Then 

	Zero_Counter = 0
	
	Dim block
	block = Lib.CC.ReadBlock( round(EntityX) , round(EntityY) , round(EntityZ)  )
	
	If block <> 140 Then 
		Call Lib.CC.GetCharPos() 
		Call Lib.CC.GetEntityPos(Index)
		Call Lib.CC.TP(EntityX, EntityY, EntityZ)
		dm.KeyPressChar "W"
//		dm.WaitKey 115, 0
		Delay dt
	End If

Else 
	Zero_Counter = Zero_Counter + 1

End If


Index = Index + 1

If Zero_Counter > 256 Then 
	Index = 1
	Reset_Counter = Reset_Counter + 1
End If

If Reset_Counter > 10 Then 
	Exit Do
End If

Loop

Scan = 1
End Function


Function PlaceBlock(target_x, target_y, target_z)
Dim dx, dy, tblo

Call Lib.CC.SetCamera(180, 45)
Call Lib.CC.GetCamPos()
dx = - (target_x - CamX) * 80
dy = - (target_y - CamY) * 60 + (target_z - CamZ) *60  - 60 


CCount = 0
tblo = Lib.CC.ReadBlock(target_x, target_y + 1, target_z)
Call Lib.CC.WriteBlock(target_x, target_y + 1, target_z, 324)
Call Lib.CC.CubicClick(handle, 640 + dx , 480 + dy)
While Lib.CC.ReadBlock(target_x, target_y, target_z) = 0
	CCount = CCount + 1
	Delay 20

Wend
Call Lib.CC.WriteBlock(target_x, target_y + 1, target_z, tblo)

End Function
