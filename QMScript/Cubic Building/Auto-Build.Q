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
MacroID=30ca7339-2b68-48e6-9b49-5708ae90f166
Description=Auto-Build
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
Call Lib.CC.GetWorldSize()
Call Lib.CC.GetCharPosInt()



Dim path, str, arr, ele
path = "D:\GameData\CC\VOX transfer\track2.ccb"    
str = dm.ReadFile(path)
arr = Split(str, Chr(13))



For Each ele In arr
	Dim arr_e, bx, by, bz, block
	arr_e = Split(ele, "	")
	bx = arr_e(0)
	by = arr_e(1)
	bz = arr_e(2)
	block = arr_e(3)
	Call PlaceBlock(bx, by, bz, block)

Next


EndScript



Function PlaceBlock(bx, by, bz, block)
//b为自然坐标系，p为cc坐标系
Dim px, py, pz

px = bx
py = sizeY -1 - by
pz = sizeZ -1 - bz


If Lib.CC.ReadBlock(px, py, pz) <> 0 Then 
	Exit Function
End If


Call Lib.CC.SetCamera(0, 89)
Call Lib.CC.WriteBlock(px, py    , pz + 1, 324)
Call Lib.CC.WriteBlock(px, py + 1, pz + 1, 324)
Call Lib.CC.WriteBlock(px, py + 1, pz , 0)
Call Lib.CC.TPEx(px, py + 1, pz - 0.01)
Delay 50
Call Plugin.Bkgnd.LeftClick(handle, 640, 420)

While Lib.CC.ReadBlock(px, py, pz) = 0
	CCount = CCount + 1
	Delay 50
Wend

Delay 100

End Function

