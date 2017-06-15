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
MacroID=045db330-946e-4fbd-b57f-3eab60470f50
Description=寻找指定方块（小地图）
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

BlockWant = 111      //方块ID
BlockIDWant = BlockWant Mod 256
BlockTypeWant = BlockWant \ 256

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
fooY1 = 660
fooWide = 241
fooHght = 241
foobar = dm.CreateFoobarRect(handle, fooX1, fooY1, fooWide, fooHght)
dm_ret = dm.FoobarDrawLine(foobar, fooWide/2, 0, fooWide/2, fooHght, "808080", 0, 1)
dm_ret = dm.FoobarDrawLine(foobar, 0, fooHght / 2, fooWide, fooHght / 2, "808080", 0, 1)



BlockCount = 0
Pos = "Current target positions  "
For Each I In Addresses
	BlockID = AdrToPos(I,0)
	BlockType = AdrToPos(I, 1) Mod 16
	If BlockType = BlockTypeWant  Then 
		BlockCount = BlockCount + 1
		dm_ret = dm.FoobarFillRect(foobar, 4*AdrToPos(I, 2)+1 , 4*AdrToPos(I, 3) + 1, 4*AdrToPos(I, 2)+4 , 4*AdrToPos(I, 3) + 4, "FF9c3b") //标出坐标
		If BlockCount <20 Then
			Pos = Pos& "----" & CStr(AdrToPos(I, 2)) & "|" & CStr(AdrToPos(I, 3)) & "|" & CStr(AdrToPos(I, 4))
		End If
	End If
Next

text =  "WorldSize:  " & SizeX & "-" & SizeY & "-" & SizeZ &    Chr(13)    &Pos &      Chr(13)     &  "Totally Block:" & BlockCount
foobar2 = dm.CreateFoobarRect(handle, 300, 800, 900, 100)
dm_ret = dm.FoobarTextRect(foobar,5,5,100,200)
dm_ret = dm.FoobarPrintText(foobar2, "WorldSize:  " & SizeX & "-" & SizeY & "-" & SizeZ &    Chr(13)    &Pos   &  "Totally Block:" & BlockCount,"123456")
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
	dm_ret = dm.FoobarClose(foobar2)
End Sub
