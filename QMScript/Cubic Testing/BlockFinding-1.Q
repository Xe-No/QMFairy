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
MacroID=2ca21d6c-12e5-426b-a0b9-5975de7749ce
Description=*寻找指定多种方块【界面】【领域级】【内存】
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
Reap_Array = Array(229)
//Reap_Array = Array(371)
//Reap_Array = Array(233)

Set dm = createobject("dm.dmsoft")

Dim MyArray(1), Addresses
 
Call Lib.CC.Initailize()
Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()

//初始化窗口
fooX1 = 50
fooY1 = 660
fooWide = SizeX * 4 + 1
fooHght = SizeY * 4 + 1
//fooWide = 241
//fooHght = 241
foobar = dm.CreateFoobarRect(handle, fooX1, fooY1, fooWide, fooHght)
Delay 100
dm_ret = dm.FoobarDrawLine(foobar, fooWide/2, 0, fooWide/2, fooHght, "808080", 0, 1)
dm_ret = dm.FoobarDrawLine(foobar, 0, fooHght / 2, fooWide, fooHght / 2, "808080", 0, 1)



Block_Count = 0

For Each Block In Reap_Array
	target_ads_arr = Lib.CC.FindBlockEx(Block)
	addresses = Split(target_ads_arr, "|")


For Each I In addresses
	Dim block_ID, block_type, bx, by, bz
	block_ID = Lib.CC.AdrToPos(I,0)
	block_type = Lib.CC.AdrToPos(I, 1) Mod 8
	BlockCount = BlockCount + 1
	bx = Lib.CC.AdrToPos(I, 2)
	by = Lib.CC.AdrToPos(I, 4)
	bz = Lib.CC.AdrToPos(I, 6)
	dm_ret = dm.FoobarFillRect(foobar, 4 * BX + 1, 4 * BY + 1, 4 * BX + 4, 4 * BY + 4, "FF9c3b")//标出坐标
	Block_Count = Block_Count + 1
		
Next
Next

MessageBox BlockCount


While 0=0
	Call DrawCharPos
	dm_ret = dm.FoobarUpdate(foobar)
	Delay 500
Wend


Sub OnScriptExit
	dm_ret = dm.FoobarClose(foobar)
	
End Sub


Sub DrawCharPos
	dm_ret = dm.FoobarTextRect(foobar,5,5,100,200)
	dm_ret = dm.FoobarClearText(foobar)
	Call Lib.CC.GetCharPosInt()
	dm_ret = dm.FoobarPrintText(foobar,CharX&"|"&CharY&"|"&CharZ,"FF0000")
	dm_ret = dm.FoobarFillRect(foobar, 4*CharX+1 , 4*CharY + 1, 4*CharX+4 , 4*CharY + 4, "FF0000")
	
End Sub



