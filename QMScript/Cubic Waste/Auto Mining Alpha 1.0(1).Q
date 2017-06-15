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
MacroID=2529dd91-d3dc-412d-b0e9-2e249ef7e807
Description=Auto Mining Alpha 1.0
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
ReapArray = Array(106,109,111,112,116,142,233,298,302)
//End
Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()
Call Lib.CC.SetCamera(90,30)





BlockCount = 0
TarX = 0
TarY = 0
dx = 1
For 58
	For 59
		GetOre = False
		For k = 50 To SizeZ - 1
			//MessageBox Lib.CC.ReadBlock(TarX, TarY, k)
			If InArray(Lib.CC.ReadBlock(TarX, TarY, k), ReapArray) = 1 Then 
				GetOre = True
				Delay 200*Amp
				BlockCount = BlockCount + 1
				返回值 = Lib.CC.WriteBlock(TarX, TarY, k - 1, 0)
				Rem Grab
				
				返回值 = Lib.CC.TPT(TarX + 0.2, TarY, k - 1)
				Delay 400
				
				CCount = 0
				Call Plugin.Bkgnd.LeftClick(handle, 640, 480+vertical_bias)
				While InArray(Lib.CC.ReadBlock(TarX,TarY,k), ReapArray) = 1
					CCount = CCount + 1
					Delay 100
					If CCount > 30 Then 
						Goto Grab
					End If
				Wend
				Delay 200*Amp
				
			End If
			
		Next
		If GetOre Then
			Dk = 40
			While Lib.CC.ReadBlock(TarX + 1, TarY , Dk) = 0 And Dk - SizeZ  < 0
				Dk = Dk + 1
			Wend
			返回值 = Lib.CC.TPT(TarX+1,TarY,Dk-1)
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

Sub FixCamera
	CharX = dm.ReadFloat(handle, "[[<Cubic.exe>+2A43F4]+8D0]+24")
	CharY = dm.ReadFloat(handle, "[[<Cubic.exe>+2A43F4]+8D0]+28")
	CharZ = dm.ReadFloat(handle, "[[<Cubic.exe>+2A43F4]+8D0]+2C")
	dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2A43F4]+844", CharX)
	dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2A43F4]+848", CharY)
	dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2A43F4]+84C", CharZ)
End Sub

Sub OnScriptExit
	MessageBox BlockCount
End Sub
