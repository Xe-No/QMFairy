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
MacroID=d7a10d99-1325-412c-a3dc-3bde1f6afabe
Description=ClanFarm v1.1
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
v1.2
v1.1
解决后台运行问题
v1.0
实现基本的Clan Farm采集功能

[Script]
Set dm = createobject("dm.dmsoft")
handle = Plugin.Window.MousePoint
SubAddress = dm.ReadInt(handle, "[[<Cubic.exe>+29720c]+680]+75C", 0)

dm_ret = dm.BindWindow(handle,"dx","dx2","dx",0)
Delay 100
dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+29720c]+2DBB4", 0)
dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+29720c]+2DBB8", 89)

ReapArray = Array(251, 247, 238, 241, 243, 245)
UnreapArray = Array(249, 248, 239, 242, 244, 246)

 Call Plugin.Window.Move(handle, -1240,-920)

StaTime = Time

Rem Reap
dx = - 1 

TarX = 83
TarY = 4
Call WalkX(TarX)
Call WalkY(TarY)
For 2
	For 81
		TarX =TarX + dx
		Call WalkX(TarX)
		Call GrabSide
	Next
	TarY = TarY + 4
	Call WalkY(TarY)
	dx = -dx
Next


TarY = 14
Call WalkY(TarY)
For 10
	For 81
		TarX =TarX + dx
		Call WalkX(TarX)
		Call GrabSide
	Next
	TarY = TarY + 4
	Call WalkY(TarY)
	dx = -dx
Next

TarY = 59
Call WalkY(TarY)
For 3
	For 81
		TarX =TarX + dx
		Call WalkX(TarX)
		Call GrabSide
	Next
	TarY = TarY + 4
	Call WalkY(TarY)
	dx = -dx
Next

Goto Reap

Function WalkX(TarX)      //容差0.1
	CharX = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC")
	DownKey = ""
	
	
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

Function WalkY(TarY)      //容差0.6
	CharY = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0")
	DownKey = ""
	
	
	Do While Abs(CharY - TarY) > 0.6
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

Function Reapable(BloX, BloY, BloZ)
	If InArray(ReadBlock(BloX, BloY, BloZ), ReapArray) = 1 Then 
		Reapable = 1
		Else 
		Reapable = 0
	End If	
End Function

Function Unreapable(BloX, BloY, BloZ)
	If InArray(ReadBlock(BloX, BloY, BloZ), UnreapArray) = 1 Then 
		Unreapable = 1
		Else 
		Unreapable = 0
	End If	
End Function

Function ReadBlock(BloX, BloY, BloZ)
	SizeX = 100
	SizeY = 100
	SizeZ = 100
	ReadBlock = Plugin.Memory.Read8Bit(handle, SubAddress + 14*((BloX*SizeY+BloY)*SizeZ+BloZ))
End Function

Function Grab(GraX, GraY)
	CharX = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC")
	CharY = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0")
	dm.MoveTo 640 + 80 * (GraX - CharX), 475 + 80 * (GraY - CharY)
	dm.LeftClick
End Function

Sub GrabSide
		If Reapable(TarX, TarY - 1, 99) = 1 Then 
			Call Grab(TarX, TarY - 1)
			Do
				Delay 50
			Loop Until Unreapable(TarX, TarY - 1,99) = 1
		End If
		If Reapable(TarX, TarY + 1,99) = 1 Then 
			Call Grab(TarX, TarY + 1)
			Do
				Delay 50
			Loop Until Unreapable(TarX, TarY + 1,99) = 1
			Delay 400
		End If
End Sub


Function CheckDC
	
End Function


Sub OnScriptExit

	Select Case DownKey
		Case "W"
			dm.KeyUpChar "W"
		Case "S"
			dm.KeyUpChar "S"
		Case "A"
			dm.KeyUpChar "A"
		Case "D"
			dm.KeyUpChar "D"
	End Select
	dm_ret = dm.UnBindWindow()
	Call Plugin.Window.Move(handle, 0, 0)
	MessageBox "Start At:  "&StaTime &Chr(13)&"  End At:  "& Time
End Sub

