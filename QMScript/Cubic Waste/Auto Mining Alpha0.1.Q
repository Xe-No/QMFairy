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
MacroID=c5453968-9277-4ceb-b1aa-aa5e7d1fa794
Description=Auto Mining Alpha0.1
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

BlockID = 106

//End
Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()
Call Lib.CC.Pre_Tele()

dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2A43F4]+83C", 90)
dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+2A43F4]+840", 30)



BlockCount = 0
For i = 0 To SizeX - 1
For j = 0 To SizeY - 1
For k = 50 To SizeZ - 1
	If Lib.CC.ReadBlock(i, j, k) = BlockID Then 
		Delay 200
		BlockCount = BlockCount + 1
		//返回值 = Lib.CC.WriteBlock(i,j,k-3,140)
		//返回值 = Lib.CC.WriteBlock(i,j,k-2,140)
		返回值 = Lib.CC.WriteBlock(i,j,k-1,0)
		返回值 = Lib.CC.Tele(i,j,k-1)
		Delay 800
		Rem Grab
		CCount = 0
		Call Plugin.Bkgnd.LeftClick(handle, 640, 520)
		While Lib.CC.ReadBlock(i, j, k) = BlockID
			CCount = CCount + 1
			Delay 100
			If CCount > 30 Then 
				Goto Grab
			End If
		Wend
		Delay 400
		Else 
			返回值 = Lib.CC.WriteBlock(i,j,k-1,140)
	End If
Next
Next
For j = 0 To SizeY - 1
For k = 50 To SizeZ - 1
	返回值 = Lib.CC.WriteBlock(i,j,k,0)
Next
Next
Next


Function AdrToPos(adr, off)
	Dim Arr(1)
	Arr(0) = adr
	Arr(1) = CStr(off)
	PStr = Join(Arr,"+")
	AdrToPos = dm.ReadInt(handle,PStr,2)
End Function

Sub OnScriptExit
	MessageBox BlockCount
End Sub
