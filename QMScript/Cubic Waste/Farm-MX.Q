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
MacroID=c042b1ba-b8dc-4a0f-a891-0be4a90858ee
Description=Farm-MX
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
//Configuration
TeleWait = 50
TeleWait2 = 50
GrabWait = 400
ReapArray = Array(238, 241, 243, 245, 247, 251) //All
//ReapArray = Array(238)  //Yumberry
//ReapArray = Array(247)  //Cotton
//End
Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()
Call Lib.CC.GetCharPosInt()

dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2AC330]+918", 0)
dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2AC330]+91C", 89)


BlockCount = 0

TarX = SizeX - 1
TarZ = CharZ + 1

For SizeX - 2
	Call Lib.CC.GetCharPos()
	If CharY - SizeY / 2 < 0 Then 
		TarY = 0
		dx = 1
	Else
		TarY = SizeY - 1
		dx = -1
	End If
	
	
	For SizeY - 1
			If InArray(Lib.CC.ReadBlock(TarX, TarY, TarZ), ReapArray) = 1 Then 
				
				Delay TeleWait
				BlockCount = BlockCount + 1
				返回值 = Lib.CC.WriteBlock(TarX - 1, TarY, TarZ - 1, 0)
				返回值 = Lib.CC.TP(TarX - 1, TarY,TarZ - 1)
				Delay TeleWait2
				
				Rem Grab
				CCount = 0
				Call Plugin.Bkgnd.LeftClick(handle, 720, 480)
				While InArray(Lib.CC.ReadBlock(TarX,TarY,TarZ), ReapArray) = 1
					CCount = CCount + 1
					Delay 100
					If CCount > 30 Then 
						Goto Grab
					End If
				Wend
				Delay GrabWait
			End If
			
			
		
		TarY = TarY + dx
		
	Next

	TarX = TarX - 1
Next

Function InArray(ele, TarArray)
	For Each TarI In TarArray
		If TarI - ele = 0 Then 
			InArray = 1
			Goto hell
			Else 
			InArray = 0
		End If
	Next
	Rem hell
End Function

Sub OnScriptExit
	MessageBox BlockCount
End Sub
