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
MacroID=5ebfa202-024d-40a3-a351-d0599cbad83f
Description=Hunting--
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
BlockCount = 0


WorldName = "WorldP"
BreakPoint = False

CaveSub = 121
CaveSup = 132
FossilSub = 149
FossilSup = 160


Call Lib.CC.Initailize()

dm_ret = dm.BindWindow(handle, "dx2", "dx2", "dx", 0)
Delay 100
Dm.SetPath "C:\Users\Administrator\Documents\DmRes"'大漠全局路径设置


Call Hunt



Sub Hunt
	
SubAddress = dm.ReadInt(handle, "[[<Cubic.exe>+2AC330]+704]+14C", 0)
Call Lib.CC.GetWorldSize()
Call Lib.CC.SetCamera(0,89)

Dim MyArray(1), Addresses
MyArray(0) = CStr(Hex(SubAddress + 18))
MyArray(1) = CStr(Hex(SubAddress + SizeX*SizeY*SizeZ*18))
MyRange = Join(MyArray, "-")

TargetAdsArr = dm.FindIntEx(handle, MyRange, CaveSub, CaveSup, 2, 18, 0, 0) & "|" & dm.FindIntEx(handle, MyRange, FossilSub, FossilSup, 2, 18, 0, 0)

Addresses = Split(TargetAdsArr, "|")

Lock = 0

For Each I In Addresses
	BlockID = AdrToPos(I,0)
	BlockType = AdrToPos(I, 1) Mod 8
	If BlockType = 1 And BlockID <> 134 Then 
		X = AdrToPos(I, 2)
		Y = AdrToPos(I, 4)
		Z = AdrToPos(I, 6)
		Lock = 1
		BlockCount = BlockCount + 1
		If BlockID > 120 And BlockID < 133 Then 
			Block = "CaveArt!!!"
			Else 
			Block = "Fossil!!!"
		End If
		Goto TP
	End If
Next

MessageBox Block


Rem TP
For i = Y To SizeY - 1
For j = 40 To Z - 1
	Call Lib.CC.WriteBlock(X, i ,j, 0)
Next
Next

Call Lib.CC.TP(X, Y -.2, Z - 1)
Delay 500
//Call Plugin.Bkgnd.LeftClick(handle, 640, 480)
dm.MoveTo 640, 480
dm.LeftClick
Delay 50

Dk = 50
	While Lib.CC.ReadBlock(X , Y -1 , Dk) = 0 And Dk - SizeZ  < 0
		Dk = Dk + 1
		Delay 100
	Wend
Delay 200
Call Lib.CC.TP(X, Y - 1, Dk - 1)


End Sub


Function AdrToPos(adr, off)
	Dim Arr(1)
	Arr(0) = adr
	Arr(1) = CStr(off)
	PStr = Join(Arr,"+")
	AdrToPos = dm.ReadInt(handle,PStr,2)
End Function
