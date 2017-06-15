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
MacroID=1cb1d960-7cfc-43ea-856a-2daee4eedf20
Description=采集橡胶树【旧版本】
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
//----------配置区域----------

//方块ID
UserVar bias_z = -1 "竖直方向偏移"
//----------结束----------





t0 = Plugin.GetSysInfo.GetTime()

Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()

BlockCount = 0
ReapBlock(217)
ReapBlock(251)
ReapBlock (249)

t1 = Plugin.GetSysInfo.GetTime()
MessageBox BlockCount & Chr(13) & t1-t0

Function ReapBlock(Block_Want)
	

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

For index = 0 To Round(array_count / 2 - 0.1)
	temp = addresses(index)
	addresses(index) = addresses(array_count - index)
	addresses(array_count - index) = temp
	
Next



For Each I In addresses

	Dim block_ID, block_type, bx, by, bz
	block_ID = AdrToPos(I,0)
	block_type = AdrToPos(I, 1) Mod 8
	If block_type = block_type_want  Then 
		BlockCount = BlockCount + 1
		bx = AdrToPos(I, 2)
		by = AdrToPos(I, 4)
		bz = AdrToPos(I, 6)
		
		Call Mine_Precise(bx, by, bz, Block_Want)
		
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

Function Mine_Precise(Target_x, Target_y, Target_z, Block_Want)

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
Call Lib.CC.TPEx(Target_x, Target_y + 0.01, Target_z + 1)
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





