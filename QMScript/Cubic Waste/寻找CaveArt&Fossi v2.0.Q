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
MacroID=6319a512-31ae-416b-a123-dfb76ad85709
Description=—∞’“CaveArt&Fossil v2.0
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
UEsDBBQAAgAIAAgM90bUpEOjwwMAAAgmAAAJABEAVUlQYWNrYWdlVVQNAAc0RLBVNESwVTREsFXtWE1PE0EYfrdFaAuUFqF8CuVb8SB68WJMLJFIAmho8eDBpCIIcVlIW7T+HBJvXvRgPBkuHowehH+giRfjzYM3qc9sZ+2UQNiZ2bI24Wlepi2dfWbeeT8nSGXsfYl/3XnT+40O4SYF6aAUpkbhO4OLjRhRgH8+KJVKztelM9QV/kAa+Bmysz4HaYKEISFIBNIKaYa0QKLlo6c2SJzPOzhTY91ikTbxKlCSbpOFMUcvSAYJWIzzLOOE304NX1l9+WHPCBI3LGCJZmmK1BEiw3D4AyfwOqP4v2nK0JzGCiKcP8F9R5Y/A31v0QotUJY2MMqinQI2f5zHXrfzGvjo+O//KmeoLWY2cxsa7kds/lWN+QbpQXe+Lj7v779+9373h+p8CZetyXzVuFOJf4Gqms/tmTmxkmWdLD0iU3ENUcS/Zp5O3PIHhPh3n9YpD1FdQUxh/0GBfxGsWXpMd6EHUzL3OvG/hT/TLX+DwJ8BfxF5X+P8Ddn9s7MP8ffTqD5MSE5xJR0K/I3C/iv8KZzDMj2V57fr5TYJ/TcdOv9lTf23cn265Q9RuYYXsQanLFL9ocln/t9H69xOS/PpZDpr5ZPpldz6ao34x1491Jr/AJEnh/izgr8qYPG3k/uUW/sLC/Y/B9+T97pq+4/x57nljxzp/2msYw16kMuG3fD/88TisHv+ZoH/Fqr/LTsH5CAW1iCXhRLYf5jKfblb/haBfwZ7t/Tij3T+Y/Hqxr/9m8i+T7AGpndLJf5L80erzj8L/RewBqaHlH0OTiao2MbxuKiQf9oE/pT9/LL/ueE7wv6MDqrcu7mZExP4deOHbv2pi1lra7uQ2izqzlftYeq9f8nA8gt27atifXb8kfa/uGB/98BfBLuJKlwFUQX+9ir/Z/c/6h1sBCfocPcc85vTuP8ZI/fxn+Urp/72o/9j8SrM33vR/w1iHJDYfyd52v8ZSYzjEvwJ8rb/68XYJcHfRf72f91Uqds96P+k7a+HvO3/+jCOSOi/l7zt/4Yw9kvw91Gl//v0/ePP3V86N3h60K0frkFGIdcNVsvKw+/8G/SZ34P+T9r/+snb/m+UxxS3/BfI2/7vErE+wD3/AHnb/01gHJbgHyR/+78k+dv/DZFYf2aR//P0nPdhsmhX4B8W+OdpGxpg/eccxJKuQdj9J7PnyxLnPyLw+31/5Td0+9/Jt2ta8/t2Mr7uf8G2+w14gal8/yBr/6OC/d0B3zPl249y/JskufuPsUPxbxk+mD/F/ndc4GdZJ2czm/z2qfbxb0Lg/wtQSwECFwsUAAIACAAIDPdG1KRDo8MDAAAIJgAACQAJAAAAAAAAAAAAAIAAAAAAVUlQYWNrYWdlVVQFAAc0RLBVUEsFBgAAAAABAAEAQAAAAPsDAAAAAA==


[Script]

CaveSub = 121
CaveSup = 132
FossilSub = 149
FossilSup = 160


Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()



Dim MyArray(1), Addresses
MyArray(0) = CStr(Hex(PosAddress + 14))
MyArray(1) = CStr(Hex(PosAddress + SizeX*SizeY*SizeZ*14))
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
