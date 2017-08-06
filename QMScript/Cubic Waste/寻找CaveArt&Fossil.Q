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
MacroID=62254006-ea18-42f9-9078-ebd29549835b
Description=—∞’“CaveArt&Fossil
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

[UIPackage]
UEsDBBQAAgAIAI6a0EbMOrgWwwMAAAgmAAAJABEAVUlQYWNrYWdlVVQNAAcHd4BVB3eAVQd3gFXtWE1PE0EYfrdFaAuUFqF8CuVb8aJevBiNJRJJAA2tHjyYVEQhLoVsi5abf4WbiRc9GE+Gq9GD8A808WK8efAm9ZntrJ02EHZmtqxNeJqXaUtnn5l33s8JUhl7X+Jfd972f6MaXKcgHZTC1Cx8Z3CxESMK8M8HpVLJ+bp0iobCH0gTP0N21mcgLZAwJASJQNohrZA2SLR89NQBifN5B6dqbFgs0QZeBUrSLcphtGibZJCAxTjPMo757cvFG9uTr/aMIHHDAu7RHF0idYTIMBz+wDG8zij+b4YyNK+xggjnT3DfkeXPQN+btEKLlKV1jLLopIDNH+ex1+28Jj46/vu/yinqi9kNa13D/YjNv6wx3yA96M7Xxef9/TfvP+z+UJ0v4bJ1ma8adyrxL1BV87k9MydWsqyTpUdkKq4hivjXytOJW/6AEP/u0xrlIaoriCnsPyjwL4E1S4/pDvRgSuZeJ/638We65W8S+DPgLyLva5y/Ibt/dvYh/n4G1YcJsRRX0qXA3yzsv8Kfwjks0zN5frte7pDQf0vN+S9r6r+d69Mtf4jKNbyIVThlkRoPLT7z/z5c53ZaWkgn09lcPplesdae1Il/4vVDrfkPEHksxJ8V/FUBi7/d3Kfc2l9YsP95+J6811Xbf4w/zy1/5FD/T2Mdq9CDXDbshf+fJRaH3fO3Cvw3Uf1v2jnAguSwBrkslMD+w1Tuy93ytwn8s9h7Ti/+SOc/Fq+u/du/iez7FGtges+pxH9p/mjV+Weh/wLWwPSQss/ByQQV2zga5xXyT4fAn7KfX/Y/N3yH2J/RRZV7NzdzYgK/bvzQrT91MZfb3CqkNoq681V7mEbvXzKw/IJd+6pYnx1/pP0vLtjfXfAXwW6iCldBVIG/s8r/2f2PegcbwQk63H1H/OYk7n8myH38Z/nKqb/96P9YvArz9170f8MYhyT2302e9n9GEuOkBH+CvO3/+jH2SPD3kL/9Xy9V6nYP+j9p++sjb/u/AYxjEvrvJ2/7vxGMgxL8A1Tp/z59//hz95fODZ4edOuHK5BxyFWD1bLy8Dv/Bn3m96D/k/a/QfK2/xvnMcUt/znytv+7QKwPcM8/RN72f1MYRyX4h8nf/i9J/vZ/IyTWn1nk/zy94H2YLDoV+EcF/gXaggZY/zkPyUnXIOz+k9nzRYnzHxP4/b6/8hu6/e/0u1Wt+QM7GV/3v2jb/Tq8wFS+f5C1/3HB/m6D77ny7Uc5/k2T3P3HRE38W4YP5k+w/50U+FnWsWxmk98+1T/+TQn8fwFQSwECFwsUAAIACACOmtBGzDq4FsMDAAAIJgAACQAJAAAAAAAAAAAAAIAAAAAAVUlQYWNrYWdlVVQFAAcHd4BVUEsFBgAAAAABAAEAQAAAAPsDAAAAAA==


[Script]
Set dm = createobject("dm.dmsoft")

Dim MyArray(1), Addresses

CaveSub = 121
CaveSup = 132
FossilSub = 149
FossilSup = 160

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

MyArray(0) = CStr(Hex(SubAddress + 14))
MyArray(1) = CStr(Hex(SubAddress + SizeX*SizeY*SizeZ*14))
MyRange = Join(MyArray, "-")

TargetAdsArr = dm.FindIntEx(handle, MyRange, CaveSub, CaveSup, 2, 14, 0, 0) & "|" & dm.FindIntEx(handle, MyRange, FossilSub, FossilSup, 2, 14, 0, 0)

Addresses = Split(TargetAdsArr, "|")


Lock = 0
BlockCount = 0
For Each I In Addresses
	BlockID = AdrToPos(I,0)
	BlockType = AdrToPos(I, 1) Mod 16
	If BlockType = 1 And BlockID <> 134 Then 
		X = CStr(AdrToPos(I, 2))
		Y = CStr(AdrToPos(I, 3))
		Z = CStr(AdrToPos(I, 4))
		Lock = 1
		BlockCount = BlockCount + 1
		If BlockID > 120 And BlockID < 133 Then 
			Block = "CaveArt!!!"
			Else 
			Block = "Fossil!!!"
		End If
	End If
Next

MessageBox X & "|" & Y & "|" &Z &"---"& BlockCount&"~~~"&Block


Function AdrToPos(adr, off)
	Dim Arr(1)
	Arr(0) = adr
	Arr(1) = CStr(off)
	PStr = Join(Arr,"+")
	AdrToPos = dm.ReadInt(handle,PStr,2)
End Function
