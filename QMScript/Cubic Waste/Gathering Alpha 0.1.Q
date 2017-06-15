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
MacroID=3539f6d0-3e2a-4438-8383-0d97a6cef0c3
Description=Gathering Alpha 0.1
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
ReapArray  = Array(238,239,241,242,243,244,245,246,247,248 )



Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()

dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2A43F4]+83C", 0)
dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2A43F4]+840", 89)

Dim MyArray(1), Addresses
MyArray(0) = CStr(Hex(SubAddress + 14))
MyArray(1) = CStr(Hex(SubAddress + SizeX*SizeY*SizeZ*14))
MyRange = Join(MyArray, "-")

TargetAdsArr = dm.FindIntEx(handle, MyRange, BlockIDWant, BlockIDWant, 2, 14, 0, 0) 
Addresses = Split(TargetAdsArr, "|")


BlockCount = 0
//Call FindBlock(238) //
//Call FindBlock(239) //
//Call FindBlock(241) //
//Call FindBlock(242) //
//Call FindBlock(243)//
//Call FindBlock(244)
//Call FindBlock(245)
//Call FindBlock(246)
Call FindBlock(247)
Call FindBlock(248)


MessageBox BlockCount


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

Function FindBlock(BlockWant)
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
			BZ = AdrToPos(I, 4)
			add = SubAddress + (((BX * SizeY) + BY) * SizeZ) * 14
			·µ»ØÖµ = Lib.CC.TPT(BX,BY-0.4,BZ)
			dm.waitkey 70,0
		End If
	Next
End Function



Sub OnScriptExit
	dm_ret = dm.FoobarClose(foobar)
End Sub
