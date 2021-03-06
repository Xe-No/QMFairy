[General]
SyntaxVersion=2
MacroID=f6ae5bd1-b251-4b0c-b4c9-1d8cd6e27843
[Comment]

[Script]
Sub Initailize
	Set dm = createobject("dm.dmsoft")  //创建对象
	handle = Plugin.Window.MousePoint	//获取鼠标指向窗口的句柄
	SubAddress = dm.ReadInt(handle, "[<Cubic.exe>+002F2A5C]+874", 0)//获取地图区域基址
	dm.SetPath "C:\Users\Administrator\Documents\DmRes"'大漠全局路径设置
	Lib.CD.InitParas 
	Lib.CC.InitParas
End Sub

Sub InitParas

CC_QbeeType = 48
CD_BlockArraySize = 20
	
End Sub

Sub GetSubAddress

	SubAddress = dm.ReadInt(handle, "[<Cubic.exe>+002F2A5C]+874", 0)
	
End Sub

Function GetAccState(name)

//判断账号状态
//0 正常
//1 无效
Dim ban_list
ban_list = dm.ReadFile("ban_list.txt")
ban_list = Split(ban_list, vbcrLf)
//MessageBox ban_list(1)
For Each name_b in ban_list
	If name_b = name Then 
		//MessageBox name_b
		GetAccState = 1
		Exit Function
	End If
Next

GetAccState = 0	
	
End Function


Sub GetWorldSize  //需要: handle, SubAddress   返回: SizeX, SizeY, SizeZ
	SizeZ = 1
	SizeY = 1
	SizeX = 1
	Do While Plugin.Memory.Read8Bit(handle, SubAddress + 20*SizeZ + 6) - SizeZ =0
		SizeZ = SizeZ + 1
	Loop
	Do While Plugin.Memory.Read8Bit(handle, SubAddress + 20*SizeZ*SizeY + 4) - SizeY = 0
		SizeY = SizeY + 1
	Loop
	Do While Plugin.Memory.Read8Bit(handle, SubAddress + 20*SizeZ*SizeY*SizeX + 2) - SizeX = 0 
		SizeX = SizeX + 1
	Loop
End Sub


Sub GetCharPos    //??
	CharX = dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+24")
	CharY = dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+28")
	CharZ = dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+2C")
End Sub


Function SetCharPos(TPX, TPY, TPZ)
	dm_ret = dm.WriteFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+24", TPX)
	dm_ret = dm.WriteFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+28", TPY)
	dm_ret = dm.WriteFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+2C", TPZ)
End Function

Sub GetCharPosInt    //??
	CharX = round(dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+24"))
	CharY = round(dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+28"))
	CharZ = round(dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+2C"))
End Sub

Function GetEntityPos(Index)
	EntityX = dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+9C0]+" & Hex(4 * index) & "]+24")
	EntityY = dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+9C0]+" & Hex(4 * index) & "]+28")
	EntityZ = dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+9C0]+" & Hex(4 * index) & "]+2C")
	EntityX2 = dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+9C0]+" & Hex(4 * index) & "]+30")
	EntityY2 = dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+9C0]+" & Hex(4 * index) & "]+34")
	EntityZ2 = dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+9C0]+" & Hex(4 * index) & "]+38")
	//TracePrint EntityX & "," & EntityY & "," & EntityZ
	//TracePrint EntityX2 & "," & EntityY2 & "," & EntityZ2
	GetEntityPos = Array(EntityX,EntityY,EntityZ,EntityX2,EntityY2,EntityZ2)
End Function

Function GetEntityID(index)
	EntityID   = dm.ReadInt(handle, "[[[<Cubic.exe>+002F2A5C]+9C0]+" & Hex(4 * index) & "]+F2", 1)
	EntityType = dm.ReadInt(handle, "[[[<Cubic.exe>+002F2A5C]+9C0]+" & Hex(4 * index) & "]+F0", 2)
	EntityNum  = dm.ReadInt(handle, "[[[<Cubic.exe>+002F2A5C]+9C0]+" & Hex(4 * index) & "]+F4", 1)
End Function

Function SetEntityPos(Index, Target_X, Target_Y, Target_Z)
	dm_ret = dm.WriteFloat(handle,  "[[[<Cubic.exe>+002F2A5C]+9C0]+" & Hex(4 * index) & "]+24", Target_X)
	dm_ret = dm.WriteFloat(handle,  "[[[<Cubic.exe>+002F2A5C]+9C0]+" & Hex(4 * index) & "]+28", Target_Y)
	dm_ret = dm.WriteFloat(handle,  "[[[<Cubic.exe>+002F2A5C]+9C0]+" & Hex(4 * index) & "]+2C", Target_Z)
End Function

Sub GetFocuPos   //??
	FocuX = dm.ReadFloat(handle, "[<Cubic.exe>+002F2A5C]+984")
	FocuY = dm.ReadFloat(handle, "[<Cubic.exe>+002F2A5C]+988")
	FocuZ = dm.ReadFloat(handle, "[<Cubic.exe>+002F2A5C]+98C")
End Sub

Sub GetCamPos
	CamX = dm.ReadFloat(handle, "[<Cubic.exe>+002F2A5C]+990")
	CamY = dm.ReadFloat(handle, "[<Cubic.exe>+002F2A5C]+994")
	CamZ = dm.ReadFloat(handle, "[<Cubic.exe>+002F2A5C]+998")
End Sub

Sub GetCamera    //??
	Azimu = round(dm.ReadFloat(handle, "[<Cubic.exe>+002F2A5C]+97C"))
	Polar = round(dm.ReadFloat(handle, "[<Cubic.exe>+002F2A5C]+980"))
End Sub

Sub DrawCharPos   //??
	CharX = Round(dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+24"))
	CharY = Round(dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+28"))
	CharZ = Round(dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+2C"))
	dm_ret = dm.FoobarFillRect(foobar, 4*CharX , 4*CharY, 4*CharX+4 , 4*CharY + 4, "FF0000")
	
End Sub

Function BindClick(ClickX, ClickY)
		dm.MoveTo ClickX, ClickY
		dm.LeftClick 
End Function

Function SetCamera(Azimu, Polar)
	dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+002F2A5C]+97C", Azimu)
	dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+002F2A5C]+980", Polar)
End Function

Function TPT(TPX, TPY, TPZ)

	Dim bx, by, bz
	Call Lib.CC.GetCharPos()
	Call Lib.CC.GetFocuPos()
	bx = CharX - FocuX
	by = CharY - FocuY
	bz = CharZ - FocuZ
	
	If TPX = 0 And TPY = 0 And TPZ = 0 Then 
		Exit Function
	End If
	dm_ret = dm.WriteFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+24", TPX)
	dm_ret = dm.WriteFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+28", TPY)
	dm_ret = dm.WriteFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+2C", TPZ)

	Do
		Call Lib.CC.GetCharPos()
		Call Lib.CC.GetFocuPos()
		Delay 50
		TracePrint Abs(CharX - FocuX - bx) + Abs(CharY - FocuY - by) + Abs(CharZ - FocuZ - bz)
	Loop While Abs(CharX - FocuX - bx) + Abs(CharY - FocuY - by) + Abs(CharZ - FocuZ - bz) > 0.1 
End Function

Function TPEx(TPX, TPY, TPZ)//This function based on TP, but require Z equals, too.
	If TPX = 0 And TPY = 0 And TPZ = 0 Then 
		Exit Function
	End If
	Dim cam_x, cam_y, cam_z, count
	dm_ret = dm.WriteFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+24", TPX)
	dm_ret = dm.WriteFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+28", TPY)
	dm_ret = dm.WriteFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+2C", TPZ)
	count = 0
	Do
		cam_x = dm.ReadFloat(handle, "[<Cubic.exe>+002F2A5C]+984")
		cam_y = dm.ReadFloat(handle, "[<Cubic.exe>+002F2A5C]+988")
		cam_z = dm.ReadFloat(handle, "[<Cubic.exe>+002F2A5C]+98C")
		count = count + 1
		Delay 20
	Loop While Abs(cam_x - TPX) + Abs(cam_y - TPY) + Abs(cam_z - TPZ) > 0.1 And count < 30
End Function

Function TP(TPX, TPY, TPZ)
	
	If TPX = 0 And TPY = 0 And TPZ = 0 Then 
		Exit Function
	End If

	dm_ret = dm.WriteFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+24", TPX)
	dm_ret = dm.WriteFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+28", TPY)
	dm_ret = dm.WriteFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+2C", TPZ)

	Delay 100
End Function

Function TPP(TPX, TPY, TPZ)

	
	If TPX = 0 And TPY = 0 And TPZ = 0 Then 
		Exit Function
	End If

	dm_ret = dm.WriteFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+24", TPX)
	dm_ret = dm.WriteFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+28", TPY)
	dm_ret = dm.WriteFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+2C", TPZ)
	dm_ret = WriteBlock( round(TPX) , round(TPY), round(TPZ + 1 ), 350  )

	Delay 100
End Function


//函数

Function ReadBlock(BloX, BloY, BloZ)//需要： handle, SubAddres
	Dim add
	add = SubAddress + (((BloX * SizeY) + BloY) * SizeZ +BloZ)*20
	ReadBlock = Plugin.Memory.Read8Bit(handle, add) +  (Plugin.Memory.Read8Bit(handle, add + 1) Mod 8)*256 //Sorry to Mod 8  TvT
End Function

Function ReadBlockData(BloX, BloY, BloZ)//需要： handle, SubAddres
	Dim add
	add = CStr(Hex(SubAddress + (((BloX * SizeY) + BloY) * SizeZ +BloZ)*20))
	ReadBlockData = dm.ReadData(handle, add, 20)
End Function

Function WriteBlock(BloX, BloY, BloZ, Block)//
	If - 1  < BloX < SizeX And - 1  < BloY < SizeY And - 1  < BloZ < SizeZ Then 
		Else 
			WriteBlock = "Out Of Range"
	End If
	add = CStr(Hex(SubAddress + (((BloX * SizeY) + BloY) * SizeZ +BloZ)*20))
	WriteBlock = dm.WriteInt(handle, add, 1, Block)
End Function


Function InMinePortal()
	Call Lib.CC.GetCharPos()
	If CharX = 30 Then 
		InMinePortal = True
	Else 
		InMinePortal = False
	End If
End Function

Function GetGameState()
Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()
Call Lib.CC.GetCamera()
Call Lib.CC.GetCharPos()

If Azimu = 0 Then 
	If Abs(Round(CharX) - CharX) < 0.01 And Abs(Round(CharZ) - CharZ) < 0.01 Then 
		GetGameState = "Realm"
	Else 
		GetGameState = "Main_World"
	End If
Else 
	GetGameState = "Others"
End If

End Function


Function FindBlock(Block_Want)
//2017-6-10 11:27:36
Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()



Dim block_ID_want, block_type_want, find_method, find_bias
block_ID_want   = Block_Want Mod 256
block_type_want = Block_Want \ 256
If block_ID_want = 100 Or block_ID_want = 109 Or block_ID_want = 119 Or block_ID_want = 120 Or block_ID_want = 146 Then 
	//方法一：先搜索匹配的类型，以避免搜索大量相同ID的方块
	find_method = 1
	TracePrint "Conflicted block_ID"
Else 
	//方法零：先搜索匹配的ID
	find_method = 0
End If


If find_method = 1 Then 
	find_bias = 1
Else 
	find_bias = 0
End If

Dim my_array(2), my_range
my_array(0) = CStr(Hex(SubAddress + 20 + find_bias ))
my_array(1) = CStr(Hex(SubAddress + SizeX*SizeY*SizeZ*20 + find_bias ))
my_range = Join(my_array, "-")


Dim target_ads_arr, index
If find_method = 1 Then 
		
	target_ads_arr = ""
	For index = 0 To 7
		target_ads_arr = target_ads_arr &"|"& dm.FindIntEx(handle, my_range, block_type_want + 16 * index, block_type_want + 16 * index, 2, 20, 0, 0) 
	Next
	target_ads_arr = Right(target_ads_arr, Len(target_ads_arr) - 1)

Else 
		
	target_ads_arr = dm.FindIntEx(handle, my_range, block_ID_want, block_ID_want, 2, 20, 0, 0)

End If

TracePrint block_want & ":" & target_ads_arr
target_ads_arr = Split(target_ads_arr, "|")

Dim address, Final
Final = ""

Dim block_ID_read, block_type_read, block_read
For Each address In target_ads_arr
	If find_method = 1 Then
		address = Hex(Lib.算法.十六进制转十进制(address) - 1)
	End If
	block_ID_read   = Lib.CC.AdrToPos(address, 0)
	block_type_read = Lib.CC.AdrToPos(address, 1) Mod 8
	block_read = block_type_read * 256 + block_ID_read
	If block_read - block_want = 0 Then 
		Final = Final &"|"& address	
	End If
Next

If Final <> "" Then
	Final = Right(Final, Len(Final) - 1)
End If

TracePrint Final
FindBlock = Final

End Function

Function FindBlockEx(Block_Want)

Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()

Dim block_ID_want, block_type_want
block_ID_want   = Block_Want Mod 256
block_type_want = Block_Want \ 256

Dim my_array(2), my_range
my_array(0) = CStr(Hex(SubAddress + 20 + 1))
my_array(1) = CStr(Hex(SubAddress + SizeX*SizeY*SizeZ*20 + 1))
my_range = Join(my_array, "-")

Dim target_ads_arr, address, Final
target_ads_arr = ""
For index = 0 To 7
target_ads_arr = target_ads_arr &"|"& dm.FindIntEx(handle, my_range, block_type_want + 16 * index, block_type_want + 16 * index, 2, 20, 0, 0) 
Next
target_ads_arr = Right(target_ads_arr, Len(target_ads_arr)-1)
addresses = Split(target_ads_arr, "|")
Final = ""
For Each address In addresses
	address = Hex(Lib.算法.十六进制转十进制(address) - 1)
	Final = Final &"|"& address 
Next
Final = Right(Final, Len(Final)-1)


FindBlockEx = dm.FindIntEx(handle, Final, block_ID_want, block_ID_want, 2, 20, 0, 0) 


End Function



Function MinePrecise(Target_x, Target_y, Target_z, Block_Want)
//2017-8-10 01:23:40
Dim block_read
block_read = Lib.CC.ReadBlock(Target_x, Target_y, Target_z)
If block_read  <> block_want  Then 
	Exit Function
End If

Call Lib.CC.SetCamera(0, 89)

//改空人物上方方块
For sub_z = Target_z -1 To 50 Step -1
Call Lib.CC.WriteBlock(Target_x, Target_y, sub_z, 0)
Next

//掘取目标方块
Rem Grab	
Call Lib.CC.TPEx(Target_x, Target_y + 0.01 , Target_z - 2)
Delay 100
CCount = 0
Call Lib.CC.BiasClick(handle, 0, 0)
//temp_size = Lib.CC.GetEntitySize()
While Lib.CC.ReadBlock(Target_x, Target_y, Target_z) = Block_Want
	CCount = CCount + 1
	Delay 1000
	If CCount > 3 Then 
		Goto Grab
	End If
Wend
//While (temp_size = Lib.CC.GetEntitySize())
//Delay 20
//Wend
counter = 0

MinePrecise = 0


Do
	Delay 100
	counter = counter + 1
Loop Until Lib.CC.CollectItemNear() = 0 Or counter>3
End Function

Function CollectItemNear()

//采集人物附近的掉落物


CollectItemNear = 1
Call Lib.CC.GetEntitySize()
TracePrint EntitySize
For index = EntitySize + 10 To 0 Step -1
	Call Lib.CC.GetCharPos()
	pos = Lib.CC.GetEntityPos(index)
	Call Lib.CC.GetEntityID(index)
	
	
	If Abs(CharX - EntityX) < 1.5 And Abs(CharY - EntityY) < 1.5 And EntityType <> CC_QbeeType And Lib.CC.IsEntityData(index) Then 
		Call Lib.CC.TP(EntityX, EntityY, EntityZ)
		TracePrint "hahahahahahahah"
//		dm.KeyPressChar "W"
//		dm.KeyPressChar "S"
//		Do
//			pos2 = Lib.CC.GetEntityPos(index)
//			sum = Abs(pos(0)-pos2(0)) + Abs(pos(1)-pos2(1))
//			Delay 100
//		Loop Until sum > 0
		Delay 200
		CollectItemNear = 0
	End If


Next


End Function



Function MinePreciseCare(Target_x, Target_y, Target_z, Block_Want)

Dim block_read
block_read = Lib.CC.ReadBlock(Target_x, Target_y, Target_z)
If block_read  <> block_want  Then 
	Exit Function
End If

Call Lib.CC.SetCamera(0, 89)

For sub_z = Target_z -1 To 50 Step -1
Call Lib.CC.WriteBlock(Target_x, Target_y, sub_z, 0)
Next

Rem Grab	
Call Lib.CC.TPEx(Target_x, Target_y +0.1 , Target_z - 2)
Delay 100
CCount = 0
Call Lib.CC.BiasClick(handle,0,0)
While Lib.CC.ReadBlock(Target_x, Target_y, Target_z) = Block_Want
	CCount = CCount + 1
	Delay 50
	If CCount > 30 Then 
		Goto Grab
	End If
Wend


Dim index, scan_count
scan_count = 0
For index = 0 To e_size + 10
	Call Lib.CC.GetCharPos()
	Call Lib.CC.GetEntityPos(index)
	If Abs(CharX - EntityX) <1.5 And Abs(CharY - EntityY) <1.5 Then
		Call Lib.CC.TP(EntityX, EntityY, EntityZ)
	End If
Next



If Lib.CC.ScanPpl() > 1 Then
	scan_count = scan_count + 1
End If

If scan_count > 2 Then 
	Delay 500
	Call Lib.CC.CubicClick(handle, 1256, 22)
	Delay 500
	Call Lib.CC.CubicClick(handle, 560, 536)
	EndScript
End If


End Function




Function MinePreciseEx(Target_x, Target_y, Target_z, Block_Want)

If Lib.CC.ReadBlock(Target_x, Target_y, Target_z) <> Block_Want Then 
	Exit Function
End If

Call Lib.CC.SetCamera(0, 89)
e_size = Lib.CC.GetEntitySize() 

//Call Lib.CC.WriteBlock(Target_x - 1, Target_y, Target_z , 351)

For sub_z = Target_z -1 To 50 Step -1
Call Lib.CC.WriteBlock(Target_x, Target_y, sub_z, 0)
Next


Rem Grab	
Call Lib.CC.TPEx(Target_x, Target_y + 0.01, Target_z - 1 )
Delay 100
				
CCount = 0
Call Lib.CC.BiasClick(handle,0,0)
While Lib.CC.ReadBlock(Target_x, Target_y, Target_z) = Block_Want
	CCount = CCount + 1
	Delay 50
	If CCount > 30 Then 
		Goto Grab
	End If
Wend

Delay 400

For index = 1 To e_size + 10
	Call Lib.CC.GetCharPos()
	Call Lib.CC.GetEntityPos(index)
	If Abs(CharX - EntityX) <1.5 And Abs(CharY - EntityY) <1.5 Then
		Call Lib.CC.TP(EntityX, EntityY, EntityZ)
	End If
Next
/*
land_z = 40
While Lib.CC.ReadBlock(Target_x, Target_y + 1, land_z) = 0 And land_z - SizeZ  < 0
	land_z = land_z + 1
Wend
Call Lib.CC.TP(Target_x, Target_y + 1, land_z-1)
*/	

End Function



Function AdrToPos(Address, Bias)
	Dim arr(1), biased_address
	arr(0) = Address
	arr(1) = CStr(Bias)
	biased_address = Join(arr,"+")
	AdrToPos = dm.ReadInt(handle,biased_address,2)
End Function


Function InArray(Element, Array)

Dim index
For Each index In Array
	If TypeName(index) = "String" Then
		If index = Element Then 
			InArray = True
			Exit For
		Else 
			InArray = False
		End If
	Else 
		If index - Element = 0 Then 
			InArray = True
			Exit For
		Else 
			InArray = False
		End If
	End If
Next

End Function

Function ArrayReverse(Array)
Dim array_count, index, temp
array_count = UBound(Array)
For index = 0 To Round(array_count / 2 - 0.1)
	temp = Array()
Next

End Function

Function GetMapRange()
//2017-8-8 04:01:07
Dim my_array(2), my_range
my_array(0) = CStr(Hex(SubAddress + 20))
my_array(1) = CStr(Hex(SubAddress + SizeX*SizeY*SizeZ*20))
my_range = Join(my_array, "-")
GetMapRange = my_range 
End Function

Function ReapBlock(Block_Want, Direction)
//2017-4-20 13:49:45
Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()
Call Lib.CC.GetEntitySize()

TracePrint "EntitySize:" & EntitySize

Dim block_ID_want, block_type_want
block_ID_want   = Block_Want Mod 256
block_type_want = Block_Want \ 256


//my_range = GetMapRange()
//
//
//Dim target_ads_arr, addresses
//target_ads_arr = dm.FindIntEx(handle, my_range, block_ID_want, block_ID_want, 2, 20, 0, 0) 
target_ads_arr = FindBlock(block_want)


addresses = Split(target_ads_arr, "|")

Dim array_count, index, temp
array_count = UBound(addresses)


If Direction = "up" Then
For index = 0 To Round(array_count / 2 - 0.1)
	temp = addresses(index)
	addresses(index) = addresses(array_count - index)
	addresses(array_count - index) = temp
Next
End If





For Each I In addresses

	If Lib.CC.ScanPpl() > 1 Then
		ReapBlock = 1
		Exit Function
	End If

	Dim block_ID, block_type, block
	block_ID = Lib.CC.AdrToPos(I, 0)
	block_type = Lib.CC.AdrToPos(I, 1) Mod 8
	block = block_type * 256 + block_ID
	If block = block_want Then 
		BlockCount = BlockCount + 1
		bx = Lib.CC.AdrToPos(I, 2)
		by = Lib.CC.AdrToPos(I, 4)
		bz = Lib.CC.AdrToPos(I, 6)

		Call Lib.CC.MinePrecise(bx, by, bz, block_want)
		


	End If
		

Next

ReapBlock = 0





End Function


Function ReapBlockEx(Block_Want, Direction)
Dim target_ads_arr, addresses
target_ads_arr = Lib.CC.FindBlockEx(Block_Want)
addresses = Split(target_ads_arr, "|")
Dim array_count, index, temp
array_count = UBound(addresses)

If Direction = "up" Then 
For index = 0 To Round(array_count / 2 - 0.1)
	temp = addresses(index)
	addresses(index) = addresses(array_count - index)
	addresses(array_count - index) = temp
	
Next
End If

For Each I In addresses
	Dim block_ID, block_type, bx, by, bz
	block_ID = Lib.CC.AdrToPos(I,0)
	block_type = Lib.CC.AdrToPos(I, 1) Mod 8
	
	BlockCount = BlockCount + 1
	bx = Lib.CC.AdrToPos(I, 2)
	by = Lib.CC.AdrToPos(I, 4)
	bz = Lib.CC.AdrToPos(I, 6)
	Select Case Direction
		Case "up"
			Call Lib.CC.MinePrecise(bx, by, bz, Block_Want)
		Case "down"
			Call Lib.CC.MinePreciseEx(bx, by, bz, Block_Want)
	End Select
Next
End Function


Function ReapBlockExRange(Block_Sub, Block_Sup, Direction)
Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()

Dim my_array(2), my_range
my_array(0) = CStr(Hex(SubAddress + 20))
my_array(1) = CStr(Hex(SubAddress + SizeX*SizeY*SizeZ*20))
my_range = Join(my_array, "-")

Dim target_ads_arr, addresses
target_ads_arr = dm.FindIntEx(handle, my_range, Block_Sub, Block_Sup, 1, 20, 0, 0) 
addresses = Split(target_ads_arr, "|")

Dim array_count, index, temp
array_count = UBound(addresses)

If Direction = "up" Then 
For index = 0 To Round(array_count / 2 - 0.1)
	
	temp = addresses(index)
	addresses(index) = addresses(array_count - index)
	addresses(array_count - index) = temp
	
Next
End If



For Each I In addresses

	Dim bx, by, bz
	BlockCount = BlockCount + 1
	bx = Lib.CC.AdrToPos(I, 2)
	by = Lib.CC.AdrToPos(I, 4)
	bz = Lib.CC.AdrToPos(I, 6)
	Select Case Direction
		Case "up"
		Call Lib.CC.MinePrecise(bx, by, bz, Block_Want)
		Case "down"
		Call Lib.CC.MinePreciseEx(bx, by, bz, Block_Want)
	End Select
		
Next

End Function

Function CubicClick(handle, click_x, click_y)
	If dm.isBind(handle) = 1 Then 
		dm.MoveTo click_x, click_y
		dm.LeftClick 
	Else 
		Plugin.Bkgnd.LeftClick handle, click_x, click_y
	End If
	
End Function

Function FindMax(list)
//找到数组中最大元素的位置
Dim i, max_i, max
For i = 0 To UBound(list)	'假设数组元素个数为100个
  If max < list(i) Then 
     max = list(i)'如果x大于数组中的元素，则让x等于数组中的这个元素，这样x最终就成了数组中最小的数
     max_i = i'y获得x为最小值时，i的值，也就是x为数组中的第几个数字
  End If
Next

FindMax = max_i
End Function


Function FindMin(list)
//找到数组中最小元素的位置
Dim i, min_i, min
min = 10000000
For i = 0 To UBound(list)	'假设数组元素个数为100个
  If min > list(i) Then 
     min = list(i)'如果x大于数组中的元素，则让x等于数组中的这个元素，这样x最终就成了数组中最小的数
     min_i = i'y获得x为最小值时，i的值，也就是x为数组中的第几个数字
  End If
Next

FindMin = min_i
End Function


Function ReplaceBlockAll(block_ini, block_fin)
//2017-4-20 13:33:43

addr_list = Lib.CC.FindBlock(block_ini)
addr_list = Split(addr_list, "|")
For Each addr In addr_list	
	bx = Lib.CC.AdrToPos(addr, 2)
	by = Lib.CC.AdrToPos(addr, 4)
	bz = Lib.CC.AdrToPos(addr, 6)
	///////TracePrint bx & by & bz
	Call Lib.CC.WriteBlock(bx, by, bz, block_fin)	
Next


	
	
End Function

Function GetCharPix()
	CharPiX = dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+4C")
	CharPiY = dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+50")	
End Function

Function BiasClick(handle, bx, by)

Call Lib.CC.GetCharPix()
Call Lib.CC.CubicClick(handle, CharPiX + bx, CharPiY + by)

End Function

Function DMBind(handle)
	
Call  dm.BindWindow(handle, "dx2", "dx2", "dx", 0)

End Function

Function IsEntityData(index)
//2017-8-9 19:45:38
Call Lib.CC.GetEntityPos(index)
Call Lib.CC.GetEntityID(index)
//TracePrint EntityNum
If EntityX = EntityX2 And EntityY = EntityY2 And EntityZ > 0 Then 
	IsEntityData = True
Else 
	IsEntityData = False
End If
//TracePrint "Entity:" & IsEntityData
End Function

Function GetEntitySize()

Dim index
index = 0

While IsEntityData(index)
//TracePrint IsEntityData(index)
index = index + 1	
Wend

//TracePrint index
GetEntitySize = index
EntitySize = index
End Function

Function DetectEntity(x1,x2,y1,y2,z1,z2)
	


Dim index, e_size
e_size = Lib.CC.GetEntitySize()
For index = 0 To e_size + 10
Call Lib.CC.GetEntityPos(index)
Call Lib.CC.GetEntityID(index)

DetectEntity = 0
If x1 < EntityX < x2 And y1 < EntityY < y2 And z1 < EntityZ < z2 Then 
	TracePrint EntityID
	DetectEntity = 1
	Exit Function
End If
	
Next

	
End Function

Function DetectPpl(x1,x2,y1,y2,z1,z2)
	


Dim index, e_size
e_size = Lib.CC.GetEntitySize()
For index = 0 To e_size + 10
Call Lib.CC.GetEntityPos(index)
Call Lib.CC.GetEntityID(index)

DetectPpl = 0
If x1 < EntityX < x2 And y1  < EntityY < y2 And z1 < EntityZ < z2 And EntityType = CC_QbeeType Then
	DetectPpl = 1
	TracePrint "Detected"
	Exit Function
End If
	
Next

	
End Function

Function DetectPplFull()
	


Dim index, e_size
e_size = Lib.CC.GetEntitySize()
TracePrint e_size
For index = 0 To e_size + 10
Call Lib.CC.GetWorldSize()
Call Lib.CC.GetEntityPos(index)
Call Lib.CC.GetEntityID(index)

DetectPplFull = 0
TracePrint EntityType
If 0 < EntityX < SizeX And 0  < EntityY < SizeY And 0 < EntityZ < SizeZ And EntityType = CC_QbeeType Then
	DetectPplFull = 1
	TracePrint "Detected"
	Exit Function
End If
	
Next

	
End Function

Function ScanPpl
Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()
Call Lib.CC.GetEntitySize()

TracePrint EntitySize

ScanPpl = 0
For index = EntitySize + 10 To 0 Step -1

Call Lib.CC.GetEntityPos(Index)
Call Lib.CC.GetEntityID(Index)

//Collect

If -1 < EntityX < SizeX And -1  < EntityY < SizeY And -1  < EntityZ < SizeZ And EntityType = CC_QbeeType Then 
	ScanPpl = ScanPpl + 1
	TracePrint "Scanned: " & ScanPpl
End If

Next




End Function


