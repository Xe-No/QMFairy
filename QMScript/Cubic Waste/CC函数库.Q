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
MacroID=9225c4e3-9308-4d8d-8ee4-4e6eaf372f3f
Description=CC函数库
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
//Head
Set dm = createobject("dm.dmsoft")  //创建对象
handle = Plugin.Window.MousePoint	//获取鼠标指向窗口的句柄
SubAddress = dm.ReadInt(handle, "[[<Cubic.exe>+29720c]+680]+75C", 0)	//获取地图区域基址
//dm_ret = dm.BindWindow(handle,"dx2","dx2","dx",0)		//绑定窗口




//Sub


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

Sub GetCharPos
	CharX = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC")
	CharY = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0")
	CharZ = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC4")
End Sub

//函数

Function ReadBlock(BloX, BloY, BloZ)	//需要： handle, SubAddress
	add = SubAddress + (((BloX * SizeY) + BloY) * SizeZ +BloZ)*14
	ReadBlock = Plugin.Memory.Read8Bit(handle, add) + Plugin.Memory.Read8Bit(handle, add + 1) Mod 16
End Function

Function WriteBlock(BloX, BloY, BloZ, Block)
	add = CStr(Hex(SubAddress + (((BloX * SizeY) + BloY) * SizeZ +BloZ)*14))
	dm_ret = dm.WriteInt(handle, add, 1, Block)
End Function

