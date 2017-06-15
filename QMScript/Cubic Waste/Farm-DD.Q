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
MacroID=423906fe-9fe0-4150-940a-054abb2a5336
Description=Farm-DD
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
dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2AC330]+91C", 60)


BlockCount = 0

TarY = 1
TarZ = CharZ - 1

For SizeY - 2
	Call Lib.CC.GetCharPos()
	If CharX - SizeX / 2 < 0 Then 
		TarX = 0
		dx = 1
	Else
		TarX = SizeX - 1
		dx = -1
	End If
	
	
	For SizeX - 1
			If InArray(Lib.CC.ReadBlock(TarX, TarY, TarZ), ReapArray) = 1 Then 
				
				Delay TeleWait
				BlockCount = BlockCount + 1
				返回值 = Lib.CC.WriteBlock(TarX, TarY-1, TarZ+1, 0)
				返回值 = Lib.CC.TP(TarX, TarY -1,TarZ+1)
				Delay TeleWait2
				
				Rem Grab1
				CCount = 0
				Call Plugin.Bkgnd.LeftClick(handle, 640, 540)
				While InArray(Lib.CC.ReadBlock(TarX,TarY,TarZ), ReapArray) = 1
					CCount = CCount + 1
					Delay 100
					If CCount > 30 Then 
						Goto Grab1
					End If
				Wend
				Delay GrabWait/4
			End If
			
			If InArray(Lib.CC.ReadBlock(TarX, TarY, TarZ + 2), ReapArray) = 1 Then 
				
				Delay TeleWait
				BlockCount = BlockCount + 1
				返回值 = Lib.CC.WriteBlock(TarX, TarY-1, TarZ+1, 0)
				返回值 = Lib.CC.TP(TarX, TarY -1,TarZ+1)
				Delay TeleWait2
				
				Rem Grab2
				CCount = 0
				Call Plugin.Bkgnd.LeftClick(handle, 640, 580)
				While InArray(Lib.CC.ReadBlock(TarX,TarY,TarZ + 2), ReapArray) = 1
					CCount = CCount + 1
					Delay 100
					If CCount > 30 Then 
						Goto Grab2
					End If
				Wend
				Delay GrabWait
			End If
		
		TarX = TarX + dx
		
	Next

	TarY = TarY + 1
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
