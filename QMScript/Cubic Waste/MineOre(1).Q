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
MacroID=96623292-664b-412a-b59d-f9f46765f7f8
Description=MineOre + boulder
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
Amp = 1
//ReapArray = Array(106,109,111,112,233,298)
vertical_bias = 80  //点击时的纵向偏移
ReapArray = Array(106,111,112,116,142,233,298,302,220,235)
//End
Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()
Call Lib.CC.SetCamera(-180,30)


BlockCount = 0

For TarY = 0 To SizeY - 2
	For TarX = 0  To SizeX - 1
		Call Mine_Up_Down(TarX,TarY)
	Next


//Need Standard
	For i = 0 To SizeX - 1
	For k = 50 To SizeZ - 1
		返回值 = Lib.CC.WriteBlock(i,TarY,k,0)
	Next
	Next
	
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

Function Mine_Up_Down(target_x, target_y)
Dim get_ore, sweep_z, land_z

get_ore = False
		For sweep_z = 50 To SizeZ - 1
			
			If InArray(Lib.CC.ReadBlock(target_x, target_y, sweep_z), ReapArray) = 1 Then 
				get_ore = True
				Delay 200*Amp
				BlockCount = BlockCount + 1
				Call Lib.CC.WriteBlock(target_x, target_y, sweep_z - 1, 0)
				
				Rem Grab	
				Call Lib.CC.TPT(target_x, target_y + 0.2, sweep_z - 1)
				Delay 400
				
				CCount = 0
				Call Plugin.Bkgnd.LeftClick(handle, 640, 480 + vertical_bias)
				While InArray(Lib.CC.ReadBlock(target_x, target_y, sweep_z), ReapArray) = 1
					CCount = CCount + 1
					Delay 100
					If CCount > 30 Then 
						Goto Grab
					End If
				Wend
				Delay 200*Amp
				
			End If
			
		Next
		If get_ore Then
			land_z = 40
			While Lib.CC.ReadBlock(target_x, target_y + 1, land_z) = 0 And land_z - SizeZ  < 0
				land_z = land_z + 1
			Wend
			返回值 = Lib.CC.TPT(target_x, target_y + 1, land_z-1)
		End If
End Function
