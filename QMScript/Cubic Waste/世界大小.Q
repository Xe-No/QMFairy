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
MacroID=39b35b38-ff9d-45f9-ae98-b23fa870a1d9
Description=世界大小
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


MessageBox "WorldSize:  " & SizeX & "-" & SizeY & "-" & SizeZ

Function AdrToPos(adr, off)
	Dim Arr(1)
	Arr(0) = adr
	Arr(1) = CStr(off)
	PStr = Join(Arr,"+")
	AdrToPos = dm.ReadInt(handle,PStr,2)
End Function

