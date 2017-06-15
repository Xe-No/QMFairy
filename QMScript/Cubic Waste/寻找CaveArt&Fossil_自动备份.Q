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
MacroID=1e798326-8a97-4be8-be69-244ea163e315
Description=寻找CaveArt&Fossil_自动备份
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
UEsDBBQAAgAIAKoC5UaLkYYHwgMAAAgmAAAJABEAVUlQYWNrYWdlVVQNAAeheJhVoXiYVaF4mFXtWE1PE0EYfrdF6AeUFqF8CuVb8aJevBgTSySSABpaPXgwVkQhLgtpi9af4M/g7EUP6slwNXoQ/oEmXow3TbxJfWY7a6cEws7MlrUJT/MybensM/PO+zlBqmDnc+LL1uu+r7QPVylIe+UwNQvfGVxsxIkC/PNeuVx2vi6foKHwB9LEz5Cd9SlICyQMCUEikDZIFNIKiVWOntohCT5v70SNDYtFWserSCm6ThbGPD0nGSRhMc6zjCN+ez/668Xm2x0jSNywgNs0SxdIHSEyDIc/cASvM4r/m6YszWmsIML5k9x3ZPmz0PcGLdMC5WgNoyw6KGDzJ3jsdTuviY+O//6vcoL6YmY9v6bhfsTmX9SYb5AedOfr4tPu7qt377e/q86XcNm6zFeNO9X4F6ip+dyemRMrWdbJ0QMyFdcQQ/yL8nTilj8gxL87tEoFiOoK4gr7Dwr8i2DN0UO6CT2YkrnXif+t/Jlu+ZsE/iz4S8j7GudvyO6fnX2Iv59G9WFC8oor6VTgbxb2X+VP4xyW6Ik8v10vt0vov2Xf+S9p6r+N69Mtf4gqNbyIFThliRoPLT7z/z5Y53Zams+kMjmrkMos51cf1Yl//OU9rfl3EXnyiD/L+KsCFn+7uE+5tb+wYP9z8D15r6u1/zh/nlv+yIH+n8E6VqAHuWzYA/8/TSwOu+ePCvzXUP1v2DkgD7GwBrkslMT+w1Tpy93ytwr8M9i7pRd/pPMfi1dX/u3fRPZ9jDUwvVsq8V+aP1Zz/jnov4g1MD2k7XNwMkHVNg7HWYX80y7wp+3nV/zPDd8B9md0UvXezc2cuMCvGz90609dzFobm8X0ekl3vmoP0+j9SxaWX7RrXxXrs+OPtP8lBPu7Bf4S2E1U4SqIKfB31Pg/u/9R72AjOEGHu/eQ3xzH/c84uY//LF859bcf/R+LV2H+3ov+bwjjoMT+u8jT/s9IYZyQ4E+St/1fH8ZuCf5u8rf/66Fq3e5B/ydtf73kbf/Xj3FUQv995G3/N4xxQIK/n6r938dvH35s/9S5wdODbv1wCTIGuWywWlYefuffoM/8HvR/0v43QN72f2M8prjlP0Pe9n/niPUB7vkHydv+bxLjiAT/EPnb/6XI3/5vmMT6M4f8X6BnvA+TRYcC/4jAP0+b0ADrP+cglnQNwu4/mT2flzj/UYHf7/srv6Hb/069WdGa37+V9XX/C7bdr8ELTOX7B1n7HxPs7wb4nirfflTi3xTJ3X+M74t/S/DBwjH2vxMCP8s6eZvZ5LdP9Y9/kwL/X1BLAQIXCxQAAgAIAKoC5UaLkYYHwgMAAAgmAAAJAAkAAAAAAAAAAAAAgAAAAABVSVBhY2thZ2VVVAUAB6F4mFVQSwUGAAAAAAEAAQBAAAAA+gMAAAAA


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
