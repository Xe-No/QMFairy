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
MacroID=28d4cc51-943a-4eca-88d8-2bcc88eae9af
Description=Maze_Rev
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





Call WriteRect(19,18,24,24)


Function WriteRect(X,Y,dX,dY)
	For i = X To X+dX
		For j = Y To Y + dY
			For k = 70 To 91
				im = i Mod 6
				jm = j Mod 6
				If im <> 1 And jm <> 0 Then 
					Call WriteBlock(i, j, k, 0)
				End If
			Next
			Call WriteBlock(i,j,92,167)
			Call WriteBlock(i,j,93,148)
		Next
	Next
End Function





Function WriteBlock(BloX, BloY, BloZ, Block)
	add = SubAddress + (((BloX * SizeY) + BloY) * SizeZ +BloZ)*14
	If Plugin.Memory.Read8Bit(handle, add) - BlockIDWant <> 0
		Adr = CStr(Hex(SubAddress + 14 * ((BloX * SizeY + BloY) * SizeZ + BloZ)))
		dm_ret = dm.WriteInt(handle, Adr, 1, Block)
	End If
End Function
