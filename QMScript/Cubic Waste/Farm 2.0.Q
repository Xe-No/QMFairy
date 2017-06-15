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
MacroID=c65224af-c6e9-4bd1-a180-0bb1294a8e8d
Description=Farm 2.0
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
UserVar WorldCases=DropList{"Clanfarm":1|"Mars":2|"DD":3|"Moe":4}=0 "场地"

UserVar TeleWait = 50 "检测-传送间隔(ms) 建议:30-100"
UserVar TeleWait2 = 50 "传送-点击间隔(ms) 建议:30-100"
UserVar GrabWait = 150 "收获完成-再传送间隔(ms) 正常状态建议:400 5x建议:50-150"

//UserVar ReapCases=DropList{"Yumberries":1|"Cotton":2|"All":3}=2 "收获类型"
ReapArray = Array(238, 241, 243, 245, 247, 251) //All
//ReapArray = Array(238)  //Yumberry
//ReapArray = Array(247)  //Cotton
Select Case ReapCases
	Case 1
		ReapArray = Array(238)
	Case 2
		ReapArray = Array(247)
	Case 3
		ReapArray = Array(238, 241, 243, 245, 247, 251)
End Select

//Configuration End

//Script Start
Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()
Call Lib.CC.GetCharPosInt()

Select Case WorldCases
	Case 1
		Call Farm_Clanfarm
	Case 2
		Call Farm_Mars
	Case 3
		Call Farm_DD
	Case 4
		Call Farm_Moe
End Select

Sub Farm_Clanfarm

dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2AC330]+918", 0)
dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2AC330]+91C", 89)


BlockCount = 0

TarY = 1
TarZ = CharZ

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
				返回值 = Lib.CC.WriteBlock(TarX, TarY-1, TarZ, 0)
				返回值 = Lib.CC.TP(TarX, TarY -1,TarZ)
				Delay TeleWait2
				
				Rem Grab
				返回值 = Lib.CC.TP(TarX, TarY -1,TarZ)
				CCount = 0
				Call Plugin.Bkgnd.LeftClick(handle, 640, 560)
				While InArray(Lib.CC.ReadBlock(TarX,TarY,TarZ), ReapArray) = 1
					CCount = CCount + 1
					Delay 100
					If CCount > 30 Then 
						Goto Grab
					End If
				Wend
				Delay GrabWait
			End If
			
			
		
		TarX = TarX + dx
		
	Next

	TarY = TarY + 1
Next

End Sub

Sub Farm_Mars

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

End Sub

Sub Farm_DD

CameraCases=0
BlockCount = 0

TarY = 1
TarZ = CharZ - 1
Call Lib.CC.SetCamera(0,60)
Call Lib.CC.TPT(0,0,TarZ)
Delay 500

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
				Call Plugin.Bkgnd.LeftClick(handle, 640, 520-140*CameraCases)
				While InArray(Lib.CC.ReadBlock(TarX,TarY,TarZ), ReapArray) = 1
					CCount = CCount + 1
					Delay 50
					If CCount > 30 Then 
						Goto Grab1
					End If
				Wend
				Delay GrabWait
			End If
			
			If InArray(Lib.CC.ReadBlock(TarX, TarY, TarZ + 2), ReapArray) = 1 Then 
				
				Delay TeleWait
				BlockCount = BlockCount + 1
				返回值 = Lib.CC.WriteBlock(TarX, TarY-2, TarZ+1, 140)
				返回值 = Lib.CC.WriteBlock(TarX, TarY-1, TarZ+1, 0)
				返回值 = Lib.CC.TP(TarX, TarY -1,TarZ+1)
				Delay TeleWait2
				
				Rem Grab2
				CCount = 0
				Call Plugin.Bkgnd.LeftClick(handle, 640, 580-140*CameraCases)
				While InArray(Lib.CC.ReadBlock(TarX,TarY,TarZ + 2), ReapArray) = 1
					CCount = CCount + 1
					Delay 100
					If CCount > 10 Then 
						Goto Grab2
					End If
				Wend
				Delay GrabWait
			End If
		
		TarX = TarX + dx
		
	Next

	TarY = TarY + 1
	If TarY > 10 Then 
		Call Lib.CC.SetCamera(180, 60)
		CameraCases=1
	End If
Next

End Sub

Sub Farm_Moe
	
dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2AC330]+918", 0)
dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2AC330]+91C", 89)


BlockCount = 0

TarX = SizeX - 1
TarZ = CharZ

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
				返回值 = Lib.CC.WriteBlock(TarX - 1, TarY, TarZ, 0)
				返回值 = Lib.CC.TP(TarX - 1, TarY,TarZ)
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

End Sub


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
