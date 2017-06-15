[General]
SyntaxVersion=2
MacroID=f6ae5bd1-b251-4b0c-b4c9-1d8cd6e27843
[Comment]

[Script]
Sub Initailize
	Set dm = createobject("dm.dmsoft")  //创建对象
	handle = Plugin.Window.MousePoint	//获取鼠标指向窗口的句柄
	SubAddress = dm.ReadInt(handle, "[[<Cubic.exe>+23F6C]+5354]+760", 0)//获取地图区域基址
	PosAddress = dm.ReadInt(handle, "[[<Cubic.exe>+2A43F4]+880]+0", 0)//获取位置基址
End Sub


Sub GetWorldSize  //需要: handle, SubAddress   返回: SizeX, SizeY, SizeZ
	SizeZ = 1
	SizeY = 1
	SizeX = 1
	Do While Plugin.Memory.Read8Bit(handle, SubAddress + 14*SizeZ + 4) - SizeZ =0
		SizeZ = SizeZ + 1
	Loop
	Do While Plugin.Memory.Read8Bit(handle, SubAddress + 14*SizeZ*SizeY + 3) - SizeY = 0
		SizeY = SizeY + 1
	Loop
	Do While Plugin.Memory.Read8Bit(handle, SubAddress + 14*SizeZ*SizeY*SizeX + 2) - SizeX = 0 
		SizeX = SizeX + 1
	Loop
End Sub

Sub GetCharPos    //??
	CharX = dm.ReadFloat(handle, "[<Cubic.exe>+2A43F4]+844")
	CharY = dm.ReadFloat(handle, "[<Cubic.exe>+2A43F4]+848")
	CharZ = dm.ReadFloat(handle, "[<Cubic.exe>+2A43F4]+84C")
End Sub

Sub GetCharPosInt    //??
	CharX = int(dm.ReadFloat(handle, "[<Cubic.exe>+2A43F4]+844"))
	CharY = int(dm.ReadFloat(handle, "[<Cubic.exe>+2A43F4]+848"))
	CharZ = int(dm.ReadFloat(handle, "[<Cubic.exe>+2A43F4]+84C"))
End Sub

Sub DrawCharPos   //??
	CharX = Round(dm.ReadFloat(handle, "[<Cubic.exe>+2A43F4]+844"))
	CharY = Round(dm.ReadFloat(handle, "[<Cubic.exe>+2A43F4]+848"))
	CharZ = Round(dm.ReadFloat(handle, "[<Cubic.exe>+2A43F4]+84C"))
	dm_ret = dm.FoobarFillRect(foobar, 4*CharX , 4*CharY, 4*CharX+4 , 4*CharY + 4, "FF0000")
	
End Sub

Function TP(TPX, TPY, TPZ)
	dm_ret = dm.WriteInt(handle, "[[<Cubic.exe>+2A43F4]+8D0]+24", TPX)
	dm_ret = dm.WriteInt(handle, "[[<Cubic.exe>+2A43F4]+8D0]+28", TPY)
	dm_ret = dm.WriteInt(handle, "[[<Cubic.exe>+2A43F4]+8D0]+2C", TPZ)
	
End Function


//函数

Function ReadBlock(BloX, BloY, BloZ)	//需要： handle, SubAddress
	add = SubAddress + (((BloX * SizeY) + BloY) * SizeZ +BloZ)*14
	ReadBlock = Plugin.Memory.Read8Bit(handle, add) +  (Plugin.Memory.Read8Bit(handle, add + 1) Mod 16)*256
End Function

Function WriteBlock(BloX, BloY, BloZ, Block)//
	If - 1  < BloX < SizeX And - 1  < BloY < SizeY And - 1  < BloZ < SizeZ Then 
		Else 
			MessageBox "Out Of Range"
	End If
	add = CStr(Hex(SubAddress + (((BloX * SizeY) + BloY) * SizeZ +BloZ)*14))
	dm_ret = dm.WriteInt(handle, add, 1, Block)
End Function



