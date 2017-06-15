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
MacroID=65bbaacc-9272-4b97-a1c1-c6cf2d21b183
Description=ChangeToAir
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
Set dm = createobject("dm.dmsoft")  //创建对象
handle = Plugin.Window.MousePoint	//获取鼠标指向窗口的句柄
SubAddress = dm.ReadInt(handle, "[[<Cubic.exe>+29720c]+680]+75C", 0)	//获取地图区域基址

Call GetWorldSize

BlockIDWant = 107

Dim MyArray(2)
MyArray(0) = CStr(Hex(SubAddress + 14))
MyArray(1) = CStr(Hex(SubAddress + SizeX*SizeY*SizeZ*14))
MyRange = Join(MyArray, "-")

TargetAdsArr = dm.FindIntEx(handle, MyRange, BlockIDWant, BlockIDWant, 2, 14, 0, 0) 
Addresses = Split(TargetAdsArr, "|")



For Each I In Addresses
	BlockID = AdrToPos(I,0)
	BlockType = AdrToPos(I, 1) Mod 16
	If BlockType = 1  Then 
		BX = AdrToPos(I, 2)
		BY = AdrToPos(I, 3)
		BZ = AdrToPos(I, 4)
		add = SubAddress + (((BX * SizeY) + BY) * SizeZ + BZ) * 14
		dm_ret = dm.WriteInt(handle, CStr(Hex(add)), 1, 0)
		MessageBox dm_ret
	End If
Next




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

Function AdrToPos(adr, off)
	Dim Arr(1)
	Arr(0) = adr
	Arr(1) = CStr(off)
	PStr = Join(Arr,"+")
	AdrToPos = dm.ReadInt(handle,PStr,2)
End Function
