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
MacroID=3ad5ecbc-82dd-43f5-9689-c2b2b2ad64c8
Description=我的脚本111
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
Amp = 3
ReapArray = Array(106,111,112,233,298)
//End
Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()
Dim MyArray(1), Addresses
MyArray(0) = CStr(Hex(PosAddress + 44 ))
MyArray(1) = CStr(Hex(PosAddress + 44 + 100*904))
MyRange = Join(MyArray, "-")

Call Lib.CC.GetCharPos()
Call Find_TP_Adr
Sub Find_TP_Adr
	Call Lib.CC.GetCharPos()
	For PosI = - 10  To 10
		If Abs(Plugin.Memory.ReadSingle(handle, PosAddress + 44 + 904 * PosI) - CharZ) < 0.1 Then 
			Goto Reached
		End If
	Next
	Rem Reached
	posAdr = PosAddress + 44 + 904 * PosI
End Sub


BlockCount = 0
For i = 0 To SizeX - 1
For j = 1 To SizeY - 1
For k = 50 To SizeZ - 2
	If InArray(Lib.CC.ReadBlock(i,j,k), ReapArray) = 1 Then 
		Delay 200*Amp
		BlockCount = BlockCount + 1
		返回值 = Lib.CC.Tele(i, j - 1, k - 1)
		返回值 = Lib.CC.WriteBlock(i, j, k-1, 0)
		返回值 = Lib.CC.WriteBlock(i, j - 1, k-1, 0)
		返回值 = Lib.CC.WriteBlock(i,j-1,k,125)
		Delay 800
		Rem Grab
		CCount = 0
		Call Plugin.Bkgnd.LeftClick(handle, 720, 560)
		While InArray(Lib.CC.ReadBlock(i,j,k), ReapArray) = 1
			CCount = CCount + 1
			Delay 100
			If CCount > 30 Then 
				Goto Grab
			End If
		Wend
		Delay 400*Amp
		Else 
			//返回值 = Lib.CC.WriteBlock(i,j,k-1,140)
	End If
Next
Next
For j = 0 To SizeY - 1
For k = 50 To SizeZ - 1
	返回值 = Lib.CC.WriteBlock(i,j,k,0)
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
