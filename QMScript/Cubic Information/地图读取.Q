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
MacroID=7db19c91-3f85-414c-a051-4ed227885865
Description=地图读取
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
//地图读取
UserVar path = "D:\test.ccm" "输出路径"


Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()
Call Lib.CC.GetSubAddress()

Call Plugin.File.DeleteFile(path)
Call Plugin.File.WriteFileEx(path, SizeX & " " & SizeY & " " & SizeZ)


For X = 0 To SizeX - 1
For Y = 0 To SizeY - 1
	add = SubAddress + (((X * SizeY) + Y) * SizeZ ) * 20
	str = Plugin.Memory.ReadBinary(handle, add, SizeZ * 20)
	Call Plugin.File.WriteFileEx(path, str)   
Next
Next

