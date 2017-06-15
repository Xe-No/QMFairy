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
MacroID=d8987b7b-0a6b-4ab5-ab54-ededd5fea21f
Description=Auto Mining Alpha For Flower
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
allow_sub=60
allow_sup=73
vertical_bias=0

ReapArray = Array(116,141,142,143,144)
//End
Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()
Call Lib.CC.SetCamera(90,89)






BlockCount = 0
TarX = 0
TarY = 0
dx = 1
For 58
	For 59
		GetOre = False
		For k = allow_sub To allow_sup
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
