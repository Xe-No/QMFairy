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
MacroID=1f9436a8-ec0e-46e3-911a-2fb1476cf0df
Description=BlockTesting
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
v2.1 支持撤销
v2.0 追加更新

[Script]
Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()
Call Lib.CC.GetCharPos()

If CharZ - SizeZ < -1 Then
For i = 0 To 15
	For j = 0 To 29
		If ReadBlock(i, j, CharZ+1) = 0 Then
			Call WriteBlock(i, j, Round(CharZ + 1), i + 16 * j)
		End If
	Next
Next
End If

dm.WaitKey 115,0 

Function ReadBlock(BloX, BloY, BloZ)	//需要： handle, SubAddress
	add = SubAddress + (((BloX * SizeY) + BloY) * SizeZ +BloZ)*14
	ReadBlock = Plugin.Memory.Read8Bit(handle, add) + Plugin.Memory.Read8Bit(handle, add + 1) Mod 16
End Function

Function WriteBlock(BloX, BloY, BloZ, Block)
	add = CStr(Hex(SubAddress + (((BloX * SizeY) + BloY) * SizeZ +BloZ)*14))
	dm_ret = dm.WriteInt(handle, add, 1, Block)
End Function



Sub OnScriptExit
If CharZ - SizeZ < -1 Then
For i = 0 To SizeX - 1
	For j = 0 To SizeY - 1
		If ReadBlock(i, j, CharZ+1) = 157 Then
			Call WriteBlock(i, j, Round(CharZ + 1), 0)
		End If
	Next
Next
End If

End Sub
