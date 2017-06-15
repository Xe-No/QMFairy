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
MacroID=9f40b0ab-6059-4239-9cbb-77bdb0e0f961
Description=±ä¿ÕÆø
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
Set dm = createobject("dm.dmsoft")


handle = Plugin.Window.MousePoint
SubAddress = dm.ReadInt(handle, "[[<Cubic.exe>+29720c]+680]+75C", 0)
SizeZ = 1
SizeY = 1
SizeX = 1
Do While Plugin.Memory.Read8Bit(handle, SubAddress + 14*SizeZ + 4) - SizeZ =0
	SizeZ = SizeZ + 1
Loop
Do While Plugin.Memory.Read8Bit(handle, SubAddress + 14*SizeZ*SizeY + 3) - SizeY = 0
	SizeY = SizeY + 1
Loop
Do While Plugin.Memory.Read8Bit(handle, SubAddress + 14*SizeZ*SizeY*SizeX + 2) - SizeX = 0 
	SizeX = SizeX + 1
Loop

For x = 2 To SizeX-3
	For y = 2 To SizeY-3
		For z = 60 To 79
			add = SubAddress + (((x * SizeY) + y) * SizeZ + z)*14
			If Plugin.Memory.Read8Bit(handle, add) <> 111 Then 
				dm_ret = dm.WriteInt(handle, CStr(Hex(add)), 2, 0)
			End If
		Next
	Next
Next

MessageBox "Finished"
