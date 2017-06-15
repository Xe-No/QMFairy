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
MacroID=b1223e5e-6a71-456a-93e8-e5acb77dfd06
Description=AutoHuntingCaveArt&Fossil
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
UEsDBBQAAgAIAFiEPkeIaguDyAMAAAgmAAAJABEAVUlQYWNrYWdlVVQNAAcUDwxWFA8MVhQPDFbtWE1PE0EYfrdFaAuUFqF8CuVb8aJevBgTSySSACqtHjiYVEQhLoVsi9afw9mLHownw9XoQfAXaOLFePPgxUh9ZnfWTgnEnZmtaxNe8jKl7Owz88779UyYHNn7kPy087L/Mx2SqxSmg0qUmoXvDK62JIhC/O+DSqXifl05kYaSX9AmfobsrE9BW6BRaAQag7ZDW6Ft0Lhz9NQBTfJ5BydmbFhZok38lChN16mA0aJnJCMpeIz7LuMvz6Zvhz4u/9wzwsQdC3KH5ugCqUuEDMPFDx3zTGLawXXxxf/NUI7mNVYQ4/gpHjuy+DnYe4tWaZHytIFRVjopZOMnee71Oq+Jj278/q96IvWV2U1rQyP8iM2/qDHfID3Rna8r7/f3X7x+s/tVdb5EyNZlvmreqea/UE3P5/XM3FzJqk6e7pOpuIY48l8rLyde8UNC/rtL61SEqq4gobD/sIC/BNQ8PaCbsIMpWXvd/N/G3+kVv0nAzwG/jLqvcf6G7P7Z2Uf45xl0HybUUlxJlwJ+s7D/Kn4G57BCj+Xx7X65Q8L+LYfOf0XT/u3cnl7xI+T08KKsISjL1HjSEjD+j6NtbpelhWw6my8U09lVa/1hnfAnnt/Tmr+MzGMh/6zit4qw/NvNY8qr/0UF/59H7MlHXa3/J/j7vOLHjoz/LNaxBjvIVcNexP9pYnnYO36rgH8N3f+WXQMsaAFrkKtCKew/Sg4v94rfJuDPYu8FvfwjXf9YvrryZ/8mqu8jrIHZvaCS/6Xx4zXnn4f9S1gDs0PGPge3ElR943g5q1B/OgT8jP1+J/684B3hf0YXVe/dvMxJCPi6+UO3/9SVucLWdimzWdadr8phGp2/5OD5Jbv3VfE+O/9Ix19S8L9bwC8D3UQXriJxBfzOmvhn9z/qDDaGE3Sx+455xr33qef9zwR5z/+sXrn9dxD8j+WrKP/sB/8bxjgksf9u8pX/GWmMkxL4KfKX//Vj7JHA76Fg+V8vVft2H/iftP/1kb/8bwDjmIT9+8lf/jeCcVACf4Cq/O/dl7ffdr/r3ODpiW7/cAk6Dr1ssF5WXoKuv+GA8X3gf9LxN0j+8r9xnlO84p8hf/nfOWI8wDv+EPnL/6YwjkrgD1Ow/C9NwfK/ERL7zzzqf5Gech4mK50K+KMC/gJtwwKMf85DC9I9CLv/ZP58XuL8xwT8oO+vghZd/jv9ak1r/sBOLtD9L9p+v4EoMJXvH2T9f1zwvxvAe6J8++Hkv2mSu/+YOJT/VhCDxX/IfycFfFZ1LBvZ5LdP9c9/UwL+b1BLAQIXCxQAAgAIAFiEPkeIaguDyAMAAAgmAAAJAAkAAAAAAAAAAAAAgAAAAABVSVBhY2thZ2VVVAUABxQPDFZQSwUGAAAAAAEAAQBAAAAAAAQAAAAA


[Script]

CaveSub = 121
CaveSup = 132
FossilSub = 149
FossilSup = 160


Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()



Dim MyArray(1), Addresses
MyArray(0) = CStr(Hex(SubAddress + 18))
MyArray(1) = CStr(Hex(SubAddress + SizeX*SizeY*SizeZ*18))
MyRange = Join(MyArray, "-")

TargetAdsArr = dm.FindIntEx(handle, MyRange, CaveSub, CaveSup, 2, 18, 0, 0) & "|" & dm.FindIntEx(handle, MyRange, FossilSub, FossilSup, 2, 18, 0, 0)

Addresses = Split(TargetAdsArr, "|")

Lock = 0
BlockCount = 0
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
