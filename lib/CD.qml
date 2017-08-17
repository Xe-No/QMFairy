[General]
SyntaxVersion=2
MacroID=a6872960-0791-48e1-ab5c-6b696cef90a6
[Comment]

[Script]
Sub CreatDM
	Set dm = createobject("dm.dmsoft")//创建对象
End Sub

Sub InitParas

CD_BlockArraySize = 20
	
End Sub

Function GetHandle
	GetHandle = Plugin.Window.MousePoint()	//获取鼠标指向窗口的句柄
End Function

Function GetMapAddr(handle)
	GetMapAddr = dm.ReadInt(handle, "[<Cubic.exe>+002F2A5C]+874", 0)	
End Function


Function GetMapSize(handle)
	
	Dim size_x, size_y, size_z,  map_addr
	size_z = 1
	size_y = 1
	size_x = 1
	map_addr = GetMapAddr(handle)
	
	Do While Plugin.Memory.Read8Bit(handle, map_addr + CD_BlockArraySize * size_z + 6) - size_z = 0
		size_z = size_z + 1
	Loop
	Do While Plugin.Memory.Read8Bit(handle, map_addr + CD_BlockArraySize * size_z * size_y + 4) - size_y = 0
		size_y = size_y + 1
	Loop
	Do While Plugin.Memory.Read8Bit(handle, map_addr + CD_BlockArraySize * size_z * size_y * size_x + 2) - size_x = 0
		size_x = size_x + 1
	Loop
	GetMapSize = Array(size_x, size_y, size_z)
End Function


Function GetCharPos(handle)
//2017-8-8 03:36:48
	Dim char_x, char_y, char_z
	char_x = dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+24")
	char_y = dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+28")
	char_z = dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+2C")
	GetCharPos = Array(char_x, char_y, char_z)
End Function

Function GetCharPosInt(handle)
//2017-8-8 03:36:39
	Dim char_x, char_y, char_z
	char_x = round(dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+24"))
	char_y = round(dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+28"))
	char_z = round(dm.ReadFloat(handle, "[[[<Cubic.exe>+002F2A5C]+954]+1C0]+2C"))
	GetCharPosInt = Array(char_x, char_y, char_z)
End Function

Function GetFocusPos(handle)
	Dim focus_x, focus_y, focus_z
	focus_x = dm.ReadFloat(handle, "[<Cubic.exe>+002F2A5C]+980")
	focus_y = dm.ReadFloat(handle, "[<Cubic.exe>+002F2A5C]+984")
	focus_z = dm.ReadFloat(handle, "[<Cubic.exe>+002F2A5C]+988")
	GetFocusPos = Array(focus_x, focus_y, focus_z)
End Function

Function GetDistance(pos_1, pos_2)
	GetDistance = (   (pos_1(0)^2-pos_2(0)^2)+ (pos_1(1)^2-pos_2(1)^2)+ (pos_1(2)^2-pos_2(2)^2)   )^0.5
End Function

Function GetDistancePlane(pos_1, pos_2)
	GetDistancePlane = (   (pos_1(0)^2-pos_2(0)^2)+ (pos_1(1)^2-pos_2(1)^2)   )^0.5   //z coordinate doesn't count.
 End Function

Function SetCharPos(handle, char_pos)
	dm_ret = dm.WriteFloat(handle, "[[<Cubic.exe>+002F2A5C]+A0C]+24", char_pos(0))
	dm_ret = dm.WriteFloat(handle, "[[<Cubic.exe>+002F2A5C]+A0C]+28", char_pos(1))
	dm_ret = dm.WriteFloat(handle, "[[<Cubic.exe>+002F2A5C]+A0C]+2C", char_pos(2))
	Dim count
	count = 0
	Do
		count = count + 1
		Delay 50
	Loop Until Lib.CD.GetDistance(char_pos, GetFocusPos(handle)) < 0.1 And count > 30 //Wait focus for 30 counts. 
End Function

Function SetCharPosPlane(handle, char_pos)
	dm_ret = dm.WriteFloat(handle, "[[<Cubic.exe>+002F2A5C]+A0C]+24", char_pos(0))
	dm_ret = dm.WriteFloat(handle, "[[<Cubic.exe>+002F2A5C]+A0C]+28", char_pos(1))
	dm_ret = dm.WriteFloat(handle, "[[<Cubic.exe>+002F2A5C]+A0C]+2C", char_pos(2))
	Dim count
	count = 0
	Do
		count = count + 1
		Delay 50
	Loop Until Lib.CD.GetDistancePlane(char_pos, GetFocusPos(handle)) < 0.1 And count > 30 
End Function

Sub GetCameraAngle(handle)
	azimu = round(dm.ReadFloat(handle, "[<Cubic.exe>+002F2A5C]+978"))
	polar = round(dm.ReadFloat(handle, "[<Cubic.exe>+002F2A5C]+97C"))
	GetCameraAngle = Array(azimu, polar)
End Sub

Function SetCameraAngle(handle, camera_angle)
	dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+002F2A5C]+978", camera_angle(0))
	dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+002F2A5C]+97C", camera_angle(1))
End Function

Function CubicClick(handle, click_x, click_y)
	If dm.isBind(handle) = 1 Then 
		dm.MoveTo click_x, click_y
		dm.LeftClick 
	Else 
		Plugin.Bkgnd.LeftClick handle, click_x, click_y
	End If
	
End Function















Function ReadBlock(BloX, BloY, BloZ)//需要： handle, SubAddres
	Dim add
	add = map_addr + (((BloX * SizeY) + BloY) * SizeZ +BloZ)*18
	ReadBlock = Plugin.Memory.Read8Bit(handle, add) +  (Plugin.Memory.Read8Bit(handle, add + 1) Mod 8)*256 //Sorry to Mod 8  TvT
End Function

Function WriteBlock(BloX, BloY, BloZ, Block)//
	If - 1  < BloX < SizeX And - 1  < BloY < SizeY And - 1  < BloZ < SizeZ Then 
		Else 
			WriteBlock = "Out Of Range"
	End If
	add = CStr(Hex(map_addr + (((BloX * SizeY) + BloY) * SizeZ +BloZ)*18))
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

If Azimu = 0 And Polar = 60 Then 
	If Abs(Round(CharX) - CharX) < 0.01 And Abs(Round(CharZ) - CharZ) < 0.01 Then 
		GetGameState = "Realm"
	Else 
		GetGameState = "Main_World"
	End If
Else 
	GetGameState = "Others"
End If

End Function


Function MinePrecise(Target_x, Target_y, Target_z, Block_Want)

If Lib.CC.ReadBlock(Target_x, Target_y, Target_z) <> Block_Want Then 
	Exit Function
End If

Call Lib.CC.SetCamera(0, 89)

Call Lib.CC.WriteBlock(Target_x, Target_y, Target_z + 1, 0)
Call Lib.CC.WriteBlock(Target_x, Target_y, Target_z + 2, 351)
For sub_z = Target_z -1 To 50 Step -1
Call Lib.CC.WriteBlock(Target_x, Target_y, sub_z, 0)
Next

Rem Grab	
Call Lib.CC.TP(Target_x, Target_y + 0.01, Target_z + 1)
Delay 100
				
CCount = 0
Call Plugin.Bkgnd.LeftClick(handle, 640, 480)
While Lib.CC.ReadBlock(Target_x, Target_y, Target_z) = Block_Want
	CCount = CCount + 1
	Delay 50
	If CCount > 30 Then 
		Goto Grab
	End If
Wend

Delay 400

land_z = 40
While Lib.CC.ReadBlock(Target_x, Target_y + 1, land_z) = 0 And land_z - SizeZ  < 0
	land_z = land_z + 1
Wend
Call Lib.CC.TP(Target_x, Target_y + 1, land_z-1)
	

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
	If index - Element = 0 Then 
		InArray = True
		Exit For
	Else 
		InArray = False
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


Function ReapBlock(Block_Want, Direction)
	

Dim block_ID_want, block_type_want
block_ID_want   = Block_Want Mod 256
block_type_want = Block_Want \ 256

Dim my_array(2), my_range
my_array(0) = CStr(Hex(SubAddress + 18))
my_array(1) = CStr(Hex(SubAddress + SizeX*SizeY*SizeZ*18))
my_range = Join(my_array, "-")

Dim target_ads_arr, addresses
target_ads_arr = dm.FindIntEx(handle, my_range, block_ID_want, block_ID_want, 2, 18, 0, 0) 
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
	If block_type = block_type_want  Then 
		BlockCount = BlockCount + 1
		bx = Lib.CC.AdrToPos(I, 2)
		by = Lib.CC.AdrToPos(I, 4)
		bz = Lib.CC.AdrToPos(I, 6)
		Call Lib.CC.MinePrecise(bx, by, bz, Block_Want)
		
	End If
Next






End Function


Function GetWindowWH(handle)

//下面这句是得到窗口句柄的客户区大小
Dim sRect, MyArray, L, T, W, H
sRect = Plugin.Window.GetClientRect(handle)
MyArray = Split(sRect, "|")
//下面这句将字符串转换成数值
L = Clng(MyArray(0)): T = Clng(MyArray(1))
W = Clng(MyArray(2)): H = Clng(MyArray(3))
GetWindowWH = Array(W, H)

End Function