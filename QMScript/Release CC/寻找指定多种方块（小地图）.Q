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
MacroID=a895fd56-33c6-43f4-9eec-37a4a5c24560
Description=寻找指定多种方块（小地图）
Enable=0
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=1
QUI=Form1
[Relative]
SetupOCXFile=
[Comment]

[Script]
Set dm = createobject("dm.dmsoft")

Dim MyArray(1), Addresses
 
handle = Plugin.Window.MousePoint
SubAddress = dm.ReadInt(handle, "[[<Cubic.exe>+29720c]+680]+75C", 0)


handle = Plugin.Window.MousePoint
SubAddress = dm.ReadInt(handle, "[[<Cubic.exe>+29720c]+680]+75C", 0)

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


MyArray(0) = CStr(Hex(SubAddress + 14))
MyArray(1) = CStr(Hex(SubAddress + SizeX*SizeY*SizeZ*14))
MyRange = Join(MyArray, "-")

TargetAdsArr = dm.FindIntEx(handle, MyRange, BlockIDWant, BlockIDWant, 2, 14, 0, 0) 
Addresses = Split(TargetAdsArr, "|")


//初始化窗口
fooX1 = 50
fooY1 = 330
fooWide = 241
fooHght = 241
foobar = dm.CreateFoobarRect(handle, fooX1, fooY1, fooWide, fooHght)
Delay 100
dm_ret = dm.FoobarDrawLine(foobar, fooWide/2, 0, fooWide/2, fooHght, "808080", 0, 1)
dm_ret = dm.FoobarDrawLine(foobar, 0, fooHght / 2, fooWide, fooHght / 2, "808080", 0, 1)



BlockCount = 0
Call FindBlock (106, "66ccff")
Call FindBlock (111, "00FF00")
Call FindBlock (116, "0000ff")
Call FindBlock (112, "ffff00")
Call FindBlock (123, "ff00ff")
Call FindBlock (233, "00ffff")
MessageBox BlockCount

While 0=0
	Call DrawCharPos
	dm_ret = dm.FoobarUpdate(foobar)
	Delay 500
Wend




Function AdrToPos(adr, off)
	Dim Arr(1)
	Arr(0) = adr
	Arr(1) = CStr(off)
	PStr = Join(Arr,"+")
	AdrToPos = dm.ReadInt(handle,PStr,2)
End Function

Function InArray(ele, TarArray)
	For Each i In TarArray
		If i - ele = 0 Then 
			InArray = 1
			Goto hell
			Else 
			InArray = 0
		End If
	Next
	Rem hell
End Function

Function FindBlock(BlockWant ,BlockColor)
	BlockIDWant = BlockWant Mod 256
	BlockTypeWant = BlockWant \ 256
	MyArray(0) = CStr(Hex(SubAddress + 14))
	MyArray(1) = CStr(Hex(SubAddress + SizeX*SizeY*SizeZ*14))
	MyRange = Join(MyArray, "-")

	TargetAdsArr = dm.FindIntEx(handle, MyRange, BlockIDWant, BlockIDWant, 2, 14, 0, 0) 
	Addresses = Split(TargetAdsArr, "|")
	For Each I In Addresses
		BlockID = AdrToPos(I,0)
		BlockType = AdrToPos(I, 1) Mod 16
		If BlockType = BlockTypeWant  Then 
			BlockCount = BlockCount + 1
			BX = AdrToPos(I, 2)
			BY = AdrToPos(I, 3)
			BZ = AdrToPos(I, 2)
			dm_ret = dm.FoobarFillRect(foobar, 4 * BX + 1, 4 * BY + 1, 4 * BX + 4, 4 * BY + 4, BlockColor)//标出坐标
			add = SubAddress + (((BX * SizeY) + BY) * SizeZ )*14
			Do While Plugin.Memory.Read8Bit(handle, add) - BlockIDWant <> 0
				dm_ret = dm.WriteInt(handle, CStr(Hex(add)), 2, 0)
				add = add + 14
			Loop
		End If
	Next
End Function

Sub DrawCharPos
	dm_ret = dm.FoobarTextRect(foobar,5,5,100,200)
	dm_ret = dm.FoobarClearText(foobar)
	CharX = int(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC"))
	CharY = int(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0"))
	CharZ = int(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC4"))
	dm_ret = dm.FoobarPrintText(foobar,CharX&"|"&CharY&"|"&CharZ,"FF0000")
	dm_ret = dm.FoobarFillRect(foobar, 4*CharX+1 , 4*CharY + 1, 4*CharX+4 , 4*CharY + 4, "FF0000")
	
End Sub


Sub OnScriptExit
	dm_ret = dm.FoobarClose(foobar)
End Sub
