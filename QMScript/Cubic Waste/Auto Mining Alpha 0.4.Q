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
MacroID=16ce34b0-a686-4eaa-90b4-06c1d03ff2c9
Description=Auto Mining Alpha 0.4
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
Amp = 1
ReapArray = Array(106,111,112,233,298)
//End
Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()

dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2A43F4]+83C", 90)
dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2A43F4]+840", 30)



BlockCount = 0
TarX = 0
TarY = 0
dx = 1
For 58
	For 59
		GetOre = False
		For k = 50 To SizeZ - 1
			If InArray(Lib.CC.ReadBlock(TarX, TarY, k), ReapArray) = 1 Then 
				GetOre = True
				Delay 200*Amp
				BlockCount = BlockCount + 1
				返回值 = Lib.CC.WriteBlock(TarX, TarY, k-1, 0)
				返回值 = Lib.CC.TP(TarX+0.2,TarY,k-1)
				Delay 400
				
				Rem Grab
				CCount = 0
				Call Plugin.Bkgnd.LeftClick(handle, 640, 520)
				While InArray(Lib.CC.ReadBlock(TarX,TarY,k), ReapArray) = 1
					CCount = CCount + 1
					Delay 100
					If CCount > 30 Then 
						Goto Grab
					End If
				Wend
				Delay 400*Amp
				
			End If
			
		Next
		If GetOre Then
			Dk = 40
			While Lib.CC.ReadBlock(TarX + 1, TarY , Dk) = 0 And Dk - SizeZ  < 0
				Dk = Dk + 1
			Wend
			返回值 = Lib.CC.TP(TarX+1,TarY,Dk-1)
		End If
		
		TarY = TarY + dx
		
	Next



	For j = 0 To SizeX - 1
	For k = 50 To SizeZ - 1
		返回值 = Lib.CC.WriteBlock(TarX,j,k,0)
	Next
	Next
	TarX = TarX + 1
	dx = - dx
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
