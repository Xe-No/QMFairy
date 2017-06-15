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
MacroID=3ea90671-5a1d-4890-a2bb-61a6bd9047dd
Description=WalkTo2
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

dm_ret = dm.BindWindow(handle,"dx","dx","dx",0)
Delay 100

For 100
Call WalkTo(87, 26)
Call WalkTo(90, 29)
Call WalkTo(87, 32)
Next

Function WalkTo(TarX,TarY)
	CharX = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC")
	CharY = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0")
	CharZ = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC4")
	DownKey = ""

	Do While Sqr((CharX - TarX) ^ 2 + (CharY - TarY) ^ 2) > 0.2
		Azi = PosToAzi(CharX, CharY, TarX, TarY)
		dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+29720c]+2DBB4", Azi)
		
		If DownKey = "" Then 
			dm.KeyDownChar "W"
			DownKey = "W"
		End If
		Delay 100
		CharX = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC")
		CharY = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0")
		CharZ = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC4")
	Loop
	Select Case DownKey
		Case "W"
			dm.KeyUpChar "W"
	End Select
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



EndScript



Sub OnScriptExit

	Select Case DownKey
		Case "W"
			dm.KeyUpChar "W"
	End Select
	dm_ret = dm.UnBindWindow() 
End Sub
