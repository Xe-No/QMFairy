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
MacroID=23694065-1189-4f18-8c65-c89ef14f0e6b
Description=寻找矿物 v2.0 ---
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
Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()


Dim MyArray(1), Addresses
MyArray(0) = CStr(Hex(SubAddress + 18))
MyArray(1) = CStr(Hex(SubAddress + SizeX*SizeY*SizeZ*18))
MyRange = Join(MyArray, "-")

TargetAdsArr = dm.FindIntEx(handle, MyRange, BlockIDWant, BlockIDWant, 2, 18, 0, 0) 
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
//Call FindBlock (106, "FF7777") //铁矿石
//Call FindBlock (111, "999999") //生石 
//Call FindBlock (112, "333333") //煤矿
//Call FindBlock (298, "EEEEEE") //银矿石
//Call FindBlock (233, "FFDD77") //金矿石
Call FindBlock (238, "FF0000")
Call FindBlock (241, "0000FF")
Call FindBlock (243, "FFFF00")
Call FindBlock (245, "00FF00")
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
	MyArray(0) = CStr(Hex(SubAddress + 18))
	MyArray(1) = CStr(Hex(SubAddress + SizeX*SizeY*SizeZ*18))
	MyRange = Join(MyArray, "-")

	TargetAdsArr = dm.FindIntEx(handle, MyRange, BlockIDWant, BlockIDWant, 2, 18, 0, 0) 
	Addresses = Split(TargetAdsArr, "|")
	For Each I In Addresses
		BlockID = AdrToPos(I,0)
		BlockType = AdrToPos(I, 1) Mod 8
		If BlockType = BlockTypeWant  Then 
			BlockCount = BlockCount + 1
			BX = AdrToPos(I, 2)
			BY = AdrToPos(I, 4)
			BZ = AdrToPos(I, 6)
			dm_ret = dm.FoobarFillRect(foobar, 4 * BX + 1, 4 * BY + 1, 4 * BX + 4, 4 * BY + 4, BlockColor)//标出坐标
			add = SubAddress + (((BX * SizeY) + BY) * SizeZ )*18
			Do While Plugin.Memory.Read8Bit(handle, add) - BlockIDWant <> 0
				dm_ret = dm.WriteInt(handle, CStr(Hex(add)), 2, 0)
				add = add + 18
			Loop
		End If
	Next
End Function

Sub DrawCharPos
	dm_ret = dm.FoobarTextRect(foobar,5,5,100,200)
	dm_ret = dm.FoobarClearText(foobar)
	Call Lib.CC.GetCharPosInt()
	dm_ret = dm.FoobarPrintText(foobar,CharX&"|"&CharY&"|"&CharZ,"66ccff")
	dm_ret = dm.FoobarFillRect(foobar, 4*CharX+1 , 4*CharY + 1, 4*CharX+4 , 4*CharY + 4, "66ccff")
	
End Sub


Sub OnScriptExit
	dm_ret = dm.FoobarClose(foobar)
End Sub
