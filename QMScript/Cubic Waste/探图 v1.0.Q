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
MacroID=2ed113f3-70ef-4295-ac83-846ee61157bf
Description=探图 v1.0
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
SubAddress = dm.ReadInt(handle, "[[<Cubic.exe>+29720c]+680]+75C", 0)//获取地图区域基址

Call GetWorldSize
Call GetCharPos


//初始化窗口
fooX1 = 210 - 2 * SizeX
fooY1 = 740 - 2 * SizeY
fooWide = 4 * SizeX 
fooHght = 4 * SizeY
foobar = dm.CreateFoobarRect(handle, fooX1, fooY1, fooWide, fooHght)
Delay 100


For i = 0 To SizeX - 1
	For j = 0 To SizeY - 1
		If ReadBlock(i, j, Round(CharZ) ) <> 0 Then 
			dm_ret = dm.FoobarFillRect(foobar, 4 * i , 4 * j , 4 * i + 4, 4 * j + 4, "000000")
		End If
	Next
Next
While 0=0
	Call DrawCharPos
	dm_ret = dm.FoobarUpdate(foobar)
	Delay 250
Wend



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

Sub DrawCharPos
	CharX = Round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC"))
	CharY = Round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0"))
	CharZ = Round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC4"))
	dm_ret = dm.FoobarFillRect(foobar, 4*CharX , 4*CharY, 4*CharX+4 , 4*CharY + 4, "FF0000")
	
End Sub

Function ReadBlock(BloX, BloY, BloZ)	//需要： handle, SubAddress
	add = SubAddress + (((BloX * SizeY) + BloY) * SizeZ +BloZ)*14
	ReadBlock = Plugin.Memory.Read8Bit(handle, add) + Plugin.Memory.Read8Bit(handle, add + 1) Mod 16
End Function

Sub OnScriptExit
	dm_ret = dm.FoobarClose(foobar)
End Sub
