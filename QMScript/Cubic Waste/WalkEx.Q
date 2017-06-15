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
MacroID=910a7028-bcca-4d59-a9f0-5f94544d269b
Description=WalkEx
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
Set dm = createobject("dm.dmsoft")
handle = Plugin.Window.MousePoint
SubAddress = dm.ReadInt(handle, "[[<Cubic.exe>+29720c]+680]+75C", 0)

dm_ret = dm.BindWindow(handle,"dx","dx2","dx",0)
Delay 100

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

CharY = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0")
Call WalkXEx(Round(CharX)+10)

Function WalkXEx(TarX)    
	CharX = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC")
	CharY = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0")
	CharZ = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC4")
	DownKey = ""
	If TarX - CharX > 0 
		st = -1
		Else 
		st = 1
 	End If
	For i = Round(CharX) To TarX Step st
		Call WriteBlock(i, Round(CharY), Round(CharZ) + 1, 140)
		Call WriteBlock(i, Round(CharY), Round(CharZ), 0)
	Next
	
	Do While Abs(CharX - TarX) > 0.3
  		If DownKey = ""   Then 
			If TarX - CharX < 0 
				dm.KeyDownChar "A"
				DownKey = "A"
				Else 
				dm.KeyDownChar "D"
				DownKey = "D"
			End If
		End If
		Delay 50
		CharX = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC")
	Loop
	Select Case DownKey
		Case "A"
			dm.KeyUpChar "A"
		Case "D"
			dm.KeyUpChar "D"
	End Select
End Function
Function WalkYEx(TarY)    
	CharX = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC")
	CharY = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0")
	CharZ = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC4")
	DownKey = ""
	If TarY - CharY < 0 
		st = -1
		Else 
		st = 1
 	End If
	For i = Round(CharY) To TarY Step st
		Call WriteBlock(Round(CharX), i, Round(CharZ) + 1, 148)
		Call WriteBlock(Round(CharX), i, Round(CharZ), 0)
	Next
	
	Do While Abs(CharY - TarY) > 0.3
  		If DownKey = ""   Then 
			If TarY - CharY < 0 
				dm.KeyDownChar "W"
				DownKey = "W"
				Else 
				dm.KeyDownChar "S"
				DownKey = "S"
			End If
		End If
		Delay 50
		CharY = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0")
	Loop
	Select Case DownKey
		Case "W"
			dm.KeyUpChar "W"
		Case "S"
			dm.KeyUpChar "S"
	End Select
End Function
Function WriteBlock(BloX, BloY, BloZ, Block)
	If BloZ = SizeZ Then 
		Else	
		Adr = CStr(Hex(SubAddress + 14 * ((BloX * SizeY + BloY) * SizeZ + BloZ)))
		Adr2 = CStr(Hex(SubAddress + 14 * ((BloX * SizeY + BloY) * SizeZ + BloZ)+1))
		dm_ret = dm.WriteInt(handle, Adr, 2, Block)
		dm_ret = dm.WriteInt(handle, Adr2, 2, 0)
	End If
End Function
