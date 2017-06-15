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
MacroID=fdaa9bcf-c991-4346-bfce-b9c75957ec7e
Description=EntityTeleporter
Enable=1
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
UserVar dt = 500 "DelayTime"

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


If 1 < EntityX < SizeX And 1  < EntityY < SizeY And 1  < EntityZ < SizeZ Then 
	
	Zero_Counter = 0
	
	Call Lib.CC.GetEntityID(Index)
	
	Dim block
	block = Lib.CC.ReadBlock( round(EntityX) , round(EntityY) , round(EntityZ)  )
	
	If block <> 140 Then 
		Call Lib.CC.GetCharPos() 
		Call Lib.CC.GetEntityPos(Index)
		Call Lib.CC.TP(EntityX, EntityY, EntityZ)
		dm.KeyPressChar "W"
//		dm.WaitKey 115, 0
		Delay dt
	End If

Else 
	Zero_Counter = Zero_Counter + 1

End If


Index = Index + 1

If Zero_Counter > 40 Then 
	Exit Do
End If

Loop

Scan = 1
End Function

//Function GetEntityID(index)
//	EntityID = dm.ReadInt(handle, "[[[<Cubic.exe>+002F29BC]+9C0]+" & Hex(4 * index) & "]+F2", 1)
//	EntityType = dm.ReadInt(handle, "[[[<Cubic.exe>+002F29BC]+9C0]+" & Hex(4 * index) & "]+F4", 1)
//End Function
