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
MacroID=04e64026-53b2-4816-9866-5e34e5a18f6d
Description=Farm Sp_自动备份
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





dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2AC330]+918", 0)
dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2AC330]+91C", 89)


BlockCount = 0

Rem FarmStart
TarY = 1
TarZ = 99

For SizeY - 1
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
				
				
				返回值 = Lib.CC.TP(TarX, TarY -1,TarZ)
				CCount = 0
				Call Plugin.Bkgnd.LeftClick(handle, 640, 560)
				While InArray(Lib.CC.ReadBlock(TarX,TarY,TarZ), ReapArray) = 1
					CCount = CCount + 1
					Delay 100
					If CCount > 10 Then 
						Delay 500
						Goto Skip1
					End If
				Wend
				Rem Skip1
				Delay GrabWait
			End If
			
			
		
		TarX = TarX + dx
		
	Next

	TarY = TarY + 1
Next

TarY = 1
TarZ = 69

For SizeY - 1
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
				
				
				返回值 = Lib.CC.TP(TarX, TarY -1,TarZ)
				CCount = 0
				Call Plugin.Bkgnd.LeftClick(handle, 640, 560)
				While InArray(Lib.CC.ReadBlock(TarX,TarY,TarZ), ReapArray) = 1
					CCount = CCount + 1
					Delay 100
					If CCount > 10 Then 
						Delay 500
						Goto Skip2
					End If
				Wend
				Rem Skip2
				Delay GrabWait
			End If
			
			
		
		TarX = TarX + dx
		
	Next

	TarY = TarY + 1
Next

Goto FarmStart

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
