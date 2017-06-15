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
MacroID=7ccc109a-eae5-4057-8be4-13e5f3406137
Description=WalkTo3
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



TarX = 83
TarY = 14
dx = - 1 

Call WalkTo(TarX, TarY)
For 10
	For 81
		TarX =TarX + dx
		Call WalkTo(TarX, TarY)
		Call GrabSide

		
	Next
	TarY = TarY + 4
	dx = -dx
Next

Function WalkTo(TarX,TarY)
	CharX = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC")
	CharY = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0")
	CharZ = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC4")
	DownKey = ""

	Do While Sqr((CharX - TarX) ^ 2 + (CharY - TarY) ^ 2) > 0.25
		Azi = PosToAzi(CharX, CharY, TarX, TarY)
		dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+29720c]+2DBB4", Azi)
		
		If DownKey = "" Then 
			dm.KeyDownChar "W"
			DownKey = "W"
		End If
		Delay 50
		CharX = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC")
		CharY = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0")
		CharZ = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC4")
	Loop
	Select Case DownKey
		Case "W"
			dm.KeyUpChar "W"
	End Select
End Function

Function Grab(GraX, GraY)
	dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+29720c]+2DBB4", 0)
	dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+29720c]+2DBB8", 89)
	CharX = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC")
	CharY = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0")
	dm.MoveTo 640 + 80 * (GraX - CharX), 475 + 80 * (GraY - CharY)
	dm.LeftClick
End Function

Function PosToAzi(CharX, CharY, TarX, TarY)
	If CharX - TarX = 0 Then 
		If CharY - TarY < 0 Then 
			PosToAzi = 180
			Else 
			PosToAzi = 0
		End If
		Else 
		PosToAzi = lib.Ëã·¨.½Ç¶È¼ÆËã(CharX,CharY,TarX,TarY)
	End If
End Function

Function ReadBlock(BloX, BloY, BloZ)
	SizeX = 100
	SizeY = 100
	SizeZ = 100
	ReadBlock = Plugin.Memory.Read8Bit(handle, SubAddress + 14*((BloX*SizeY+BloY)*SizeZ+BloZ))
End Function

Sub GrabSide
		If ReadBlock(TarX, TarY - 1, 99) = 251 Then 
			Call Grab(TarX, TarY - 1)
			Do
				Delay 50
				CutBlo = ReadBlock(TarX, TarY - 1, 99)
			Loop Until CutBlo = 249
		End If
		If ReadBlock(TarX, TarY + 1, 99) = 251 Then 
			Call Grab(TarX, TarY + 1)
			Do
				Delay 50
				CutBlo = ReadBlock(TarX, TarY - 1, 99)
			Loop Until CutBlo = 249
			Delay 100
		End If
End Sub



EndScript



Sub OnScriptExit

	Select Case DownKey
		Case "W"
			dm.KeyUpChar "W"
	End Select
	dm_ret = dm.UnBindWindow() 
End Sub
