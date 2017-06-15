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
MacroID=d5b3a597-d498-475b-b99c-f5a3f3d04723
Description=寻找指定方块 v2.0 ---
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
//----------配置区域----------

//方块ID
BlockWant = 1

//----------结束----------

Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()
  
BlockIDWant = BlockWant Mod 256
BlockTypeWant = BlockWant \ 256

Dim MyArray(1), Addresses
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
Delay 100
foobar = dm.CreateFoobarRect(handle, fooX1, fooY1, fooWide, fooHght)
dm_ret = dm.FoobarDrawLine(foobar, fooWide/2, 0, fooWide/2, fooHght, "000000", 0, 1)
dm_ret = dm.FoobarDrawLine(foobar, 0, fooHght / 2, fooWide, fooHght / 2, "000000", 0, 1)



BlockCount = 0
For Each I In Addresses
	BlockID = AdrToPos(I,0)
	BlockType = AdrToPos(I, 1) Mod 16
	If BlockType = BlockTypeWant  Then 
		BlockCount = BlockCount + 1
		BX = AdrToPos(I, 2)
		BY = AdrToPos(I, 3)
		BZ = AdrToPos(I, 2)
		Call Lib.CC.WriteBlock(BX + 1, BY, BZ, 111)
		Call Lib.CC.WriteBlock(BX, BY + 1, BZ, 111)
		Call Lib.CC.WriteBlock(BX - 1, BY, BZ, 111)
		Call Lib.CC.WriteBlock(BX,BY-1,BZ,111)
		dm_ret = dm.FoobarFillRect(foobar, 4 * BX + 1, 4 * BY + 1, 4 * BX + 4, 4 * BY + 4, "FF9c3b")//标出坐标
		add = SubAddress + (((BX * SizeY) + BY) * SizeZ )*14
		Do While Plugin.Memory.Read8Bit(handle, add) - BlockIDWant <> 0
			
			dm_ret = dm.WriteInt(handle, CStr(Hex(add)), 2, 0)
			add = add + 14
		Loop
	End If
Next

MessageBox BlockCount

While 0=0
	Call DrawCharPos()

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




Sub DrawCharPos// old?
	dm_ret = dm.FoobarTextRect(foobar,5,5,100,200)
	dm_ret = dm.FoobarClearText(foobar)
	Call Lib.CC.GetCharPos()
	CharX = int(CharX)
	CharY = int(CharY)
	CharZ = int(CharZ)
	dm_ret = dm.FoobarPrintText(foobar,CharX&"|"&CharY&"|"&CharZ,"FF0000")
	dm_ret = dm.FoobarFillRect(foobar, 4*CharX+1 , 4*CharY + 1, 4*CharX+4 , 4*CharY + 4, "FF0000")
	
End Sub


Sub OnScriptExit
	dm_ret = dm.FoobarClose(foobar)
End Sub
