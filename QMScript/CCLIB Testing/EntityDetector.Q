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
MacroID=78ae2c24-cc56-4dcd-bbe1-0d00c64844de
Description=EntityDetector
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
Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()

MessageBox scan

Function Scan
Dim Index, Zero_Counter, TargetType, TargetID
Index = 1
Zero_Counter = 0
TargetType = 3
TargetID = 0


Do
	
Call Lib.CC.GetEntityPos(Index)


If EntityX = 0 And EntityY = 0 And EntityZ = 0 Then 
	Zero_Counter = Zero_Counter + 1
Else 
	Zero_Counter = 0
	
	Call Lib.CC.GetEntityID(Index)
	
	If ( EntityType - TargetType ) = 0 Then 
		Call Lib.CC.GetCharPos() 
		Call Lib.CC.GetEntityPos(Index)
		Dim distance
		distance = (CharX - EntityX) ^ 2 + (CharY - EntityY) ^ 2 + (CharY - EntityY) ^ 2
		If distance > 0.3 Then 
			Scan = 0
			Exit Function
		End If
	End If
End If


Index = Index + 1

If Zero_Counter > 4 Then 
	Exit Do
End If

Loop

Scan = 1
End Function

//Function GetEntityID(index)
//	EntityID = dm.ReadInt(handle, "[[[<Cubic.exe>+002F29BC]+9C0]+" & Hex(4 * index) & "]+F2", 1)
//	EntityType = dm.ReadInt(handle, "[[[<Cubic.exe>+002F29BC]+9C0]+" & Hex(4 * index) & "]+F4", 1)
//End Function
