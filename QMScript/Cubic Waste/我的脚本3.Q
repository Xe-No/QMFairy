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
MacroID=e2626ca6-e3b4-4879-9ebb-584f6c40defd
Description=ÎÒµÄ½Å±¾3
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


	CharX = round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC"))
	CharY = round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0"))
	CharZ = round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC4"))
	DownKey = ""
	TarX = 30
	Do While Abs(CharX - TarX) > .1
		If DownKey = "" Then 
			If CharX - TarX > 0 Then
				dm.KeyDown 65
				DownKey = "A"
				Else 
				dm.KeyDown 68
				DownKey = "D"
			End If
		End If
		Delay 100
		CharX = round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC"))
		CharY = round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0"))
		CharZ = round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC4"))
	Loop
	Select Case DownKey
		Case "A"
			dm.KeyUp 65
		Case "D"
			dm.KeyUp 68
	End Select

EndScript



Call WalkTo(30)

Function WalkTo(TarX)

	CharX = round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC"))
	CharY = round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0"))
	CharZ = round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC4"))
	ADown = 0
	DDown = 0
	Do While Abs(CharX - TarX) < 0.2
		If CharX - TarX > 0 And ADown = 0 And DDown = 0 Then 
			Call Plugin.Bkgnd.KeyDown(handle, 65)
			DownKey = "A"
			Else 
			Call Plugin.Bkgnd.KeyDown(handle, 68)
			DownKey = "D" 
		End If
		Delay 100
	Loop
	Select Case DownKey
		Case "A"
			Call Plugin.Bkgnd.KeyUp(handle, 65)
		Case "D"
			Call Plugin.Bkgnd.KeyUp(handle, 68)
	End Select
End Function


EndScript

CharX = round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC"))
CharY = round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0"))
CharZ = round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC4"))
