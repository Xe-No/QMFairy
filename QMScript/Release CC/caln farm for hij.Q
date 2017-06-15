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
MacroID=7b1c6da3-3ad8-406c-a715-f0bb8ab0464e
Description=>.>
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


Call Lib.CC.Initailize()


dm_ret = dm.BindWindow(handle,"dx2","dx2","dx",0)
Delay 100
dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2A43F4]+83C", 0)
dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2A43F4]+840", 89)

PutAttachment "C:\Users\Administrator\Documents\DmRes", "DC.bmp"'ÊÍ·ÅÃüÁî
PutAttachment "C:\Users\Administrator\Documents\DmRes", "Play.bmp"
Dm.SetPath "C:\Users\Administrator\Documents\DmRes" '´óÄ®È«¾ÖÂ·¾¶ÉèÖÃ

ReapArray = Array(251, 247, 238, 241, 243, 245)
UnreapArray = Array(249, 248, 239, 242, 244, 246)

//Call Plugin.Window.Move(handle, 1240,920)

StaTime = Time
GrabCount = 0

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

Function WalkX(TarX)      //ÈÝ²î0.1
	Call Lib.CC.GetCharPos()

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
		Call Lib.CC.GetCharPos()
	Loop
	Select Case DownKey
		Case "A"
			dm.KeyUpChar "A"
		Case "D"
			dm.KeyUpChar "D"
	End Select
End Function

Function WalkY(TarY)      //ÈÝ²î0.6
	Call Lib.CC.GetCharPos()
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
		Call Lib.CC.GetCharPos()
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
	Call Lib.CC.GetCharPos()
	dm.MoveTo 400 + 50 * (GraX - CharX), 295 + 50 * (GraY - CharY)
	dm.LeftClick
End Function

Function CheckGrab(GraX, GraY, GraZ, DTime)
	If Reapable(GraX, GraY, GraZ) = 1 Then 
			Rem ReGrab
			Call Grab(GraX, GraY)
			Gcount = 0
			Do
				Delay 50
				Gcount = Gcount + 1
				If Gcount > 60 Then 
					Call CheckDC
				End If
				If Gcount Mod 80 = 0 Then 
					Goto ReGrab
				End If
			Loop Until Unreapable(GraX, GraY, GraZ) = 1
			Delay Dtime
			GrabCount = GrabCount + 1
		End If
End Function



Sub GrabSide
		Call CheckGrab(TarX, TarY - 1, 99, 50) 
		Call CheckGrab(TarX, TarY + 1, 99, 400) 	
End Sub


Sub CheckDC
	dm_ret = dm.FindPic(0,0,2000,2000,"DC.bmp","000000",1,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
		dm.leftClick 
		Delay 2000
 		Do
 	   		dm_ret = dm.FindPic(0, 0, 2000, 2000, "Play.bmp", "000000", 1, 0, intX, intY)
 	   		Delay 1000
 		Loop While intX < 0 And intY < 0
 	  	dm.MoveTo 640, 780
 	  	dm.leftClick 
 	  	Delay 10000
		Call Lib.CC.GetCharPos()
	End If
End Sub


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
	MessageBox "Start At:  "&StaTime &Chr(13)&"  End At:  "& Time &Chr(13)&"Total Harvest: "& GrabCount
End Sub
