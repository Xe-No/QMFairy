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
MacroID=e10c66cb-16ee-4b4d-ad8f-5d7c7e661e73
Description=×Ô¶¯Ñ°ÕÒCaveArt&Fossil v2.0
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
UEsDBBQAAgAIAPaw90YYSD+HzgMAAAgmAAAJABEAVUlQYWNrYWdlVVQNAAePZbFVj2WxVY9lsVXtWE1PE0EYfrdFaAuUFqF8KuVb8aJevBgTSySSABJaPXgwqYhCXArZFq0/wh/B2YsmEk+Gk4nRg/AHjCZejDcP3qQ+s52lUwK4M7N1bcJDXqaUnX1m3nk/J0hl7HyKf9l81fuVDuAaBWmvFKZG4TuDi40YUYD/vVcqlZyvSyeoK/yGNPAzZGd9CtIECUNCkAikFdIMaYFEy0dPbZA4n7d3osa6xQKt4adASbpBOYwWPSMZJGAxzruMvzwbe731ef7djhEkbljAbZqmi6SOEBmGwx846qHnZV6HX/zXJGVoRmMFEc6f4L5zHP/+KCADfa/TEs1RllYxyqKdAjZ/nMdet/Ma+Oj47/8qJ6gtptasVQ33Izb/ksZ8g/SgO18XH3d3X755u/1ddb6Ey9ZkvmrcqcS/QFXN5/bMnFjJsk6W7pOpuIYo4l8zTydu+QNC/LtDK5SHqK4gprD/oMC/ANYsPaBb0IMpmXud+N/C3+mWv0Hgz4C/iLyvcf6G7P7Z2Yf450lUHybEUlxJhwJ/o7D/Cn8K57BIj+X57Xq5TUL/TQfOf1FT/61cn275Q1Su4UUswymLVH9o8pn/1+E6t9PSbDqZzubyyfSStfKwRvyjL+5pzb+LyGMh/izhtwpY/O3kPuXW/sKC/c/A9+S9rtr+Y/x9bvkjh/p/GutYhh7ksmE3/P80sTjsnr9Z4L+O6n/dzgEWJIc1yGWhBPYfpnJf7pa/ReCfwt5zevFHOv+xeHV1f/8msu8jrIHpPacS/6X5o1Xnn4X+C1gD00PKPgcnE1Rs42icU8g/bQJ/yn5/2f/c8B1if0YHVe7d3MyJCfy68UO3/tTFdG59o5BaK+rOV+1h6r1/ycDyC3btq2J9dvyR9r+4YH/z4C+C3UQVroKoAn97lf+z+x/1DjaCE3S4e4566Jj7J6/uf0bJffxn+cqpv/3o/1i8CvPPXvR/AxjPSuy/kzzt/4wkxjEJ/gR52//1YuyS4O8if/u/bqrU7R70f9L210Pe9n99GIcl9N9L3vZ/gxj7Jfj7qNL/ffj2/sf2T50bPD3o1g+XISOQKwarZeXhd/4N+szvQf8n7X/95G3/N8Jjilv+M+Rt/3eeWB/gnv8sedv/jWMckuAfIH/7vyT52/8Nklh/ZpH/8/SU92GyaFfgHxL4Z2kDGmD95wwkJ12DsPtPZs8XJM5/WOD3+/7Kb+j2vxNby1rz+zYzvu5/zrb7VXiBqXz/IGv/I4L93QTfE+Xbj3L8myC5+4/RA/FvET6Y/4f975jAz7KOZTOb/Pap9vFvXOD/A1BLAQIXCxQAAgAIAPaw90YYSD+HzgMAAAgmAAAJAAkAAAAAAAAAAAAAgAAAAABVSVBhY2thZ2VVVAUAB49lsVVQSwUGAAAAAAEAAQBAAAAABgQAAAAA


[Script]

CaveSub = 121
CaveSup = 132
FossilSub = 149
FossilSup = 160


Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()



Dim MyArray(1), Addresses
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
		X = AdrToPos(I, 2)
		Y = AdrToPos(I, 3)
		Z = AdrToPos(I, 4)
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

KeyPress "Enter", 1
SayString "Null ;3;"
KeyPress "Enter", 1

EndScript
Rem TP
For i = Y To SizeY - 1
For j = 40 To Z - 1
	Call Lib.CC.WriteBlock(X, i ,j, 0)
Next
Next

Call Lib.CC.TP(X,Y,Z-1)




Function AdrToPos(adr, off)
	Dim Arr(1)
	Arr(0) = adr
	Arr(1) = CStr(off)
	PStr = Join(Arr,"+")
	AdrToPos = dm.ReadInt(handle,PStr,2)
End Function
