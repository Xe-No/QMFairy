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
MacroID=45a67518-d8b0-40a8-9f1e-fe6d1437bfb0
Description=寻找CaveArt&Fossil（小地图）
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
UEsDBBQAAgAIAN5Nv0bW2GRoywMAAAgmAAAJABEAVUlQYWNrYWdlVVQNAAeH2GpVh9hqVYfYalXtWM1PE0EUf9sitAVKi1A+hfKteFEvXoyJJRJJAI2tHjyYVEQhloVsi9a/xRMnDyZGD8aT4Wr0IBy8Y+LFePPgTepvdmftlEDcmdm6NuGRx5Sys7+ZN+/rN2FyZOdTcm/rdf8XOiCXKUz7lSg1C98ZXG1JEIX43/uVSsX9unIsDSW/oE38DNlZn4C2QKPQCDQGbYe2QtugcefoqQOa5PP2j83YsHKT1vFTojRdJROjRU9JRlLwGPddxl+e3ftceT7zbMcIE3csyC2ao3OkLhEyDBc/dMQzOy8dXBdf/N8M5WheYwUxjp/isSOLn4O9N2iZFilPaxhlpZNCNn6S516v85r46Mbv/6rHUl+ZXbfWNMKP2PzzGvMN0hPd+brycXf31dt3299U50uEbF3mq+adav4L1fR8Xs/MzZWs6uTpHhUU1xBH/mvl5cQrfkjIf7dplYpQ1RUkFPYfFvBvAjVP9+k67FCQrL1u/m/j7/SK3yTg54BfRt3XOH9Ddv/s7CP88wy6jwLUUlxJlwJ+s7D/Kn4G57BEj+Tx7X65Q8L+LQfOf0nT/u3cnl7xI+T08KKsICjL1HjSEjD+z8NtbpelhWw6mzeL6eyytfqgTvgTL+5qzb+DzGMh/yzjt4qw/NvNY8qr/0UF/59H7MlHXa3/J/j7vOLHDo3/LNaxAjvIVcNexP9JYnnYO36rgH8F3f+GXQMsqIk1yFWhFPYfJYeXe8VvE/BnsXdTL/9I1z+Wry792X8B1fch1sDsbqrkf2n8eM3552H/EtbA7JCxz8GtBFXfOFpOK9SfDgE/Y7/fiT8veIf4n9FF1Xs3L3MSAr5u/tDtP3VlztzYLGXWy7rzVTlMo/OXHDy/ZPe+Kt5n5x/p+EsK/ncD+GWgF9CFq0hcAb+zJv7Z/Y86g43hBF3sviOece996nn/M0He8z+rV27/HQT/Y/kqyj/7wf+GMQ5J7L+bfOV/RhrjpAR+ivzlf/0YeyTweyhY/tdL1b7dB/4n7X995C//G8A4JmH/fvKX/41gHJTAH6Aq//vw9f337R86N3h6ots/XICOQy8arJeVl6DrbzhgfB/4n3T8DZK//G+c5xSv+KfIX/53hhgP8I4/RP7yvymMoxL4wxQs/0tTsPxvhMT+M4/6X6QnnIfJSqcC/qiAv0CbsADjn/NQU7oHYfefzJ/PSpz/mIAf9P1V0KLLf6ffrGjNH9jKBbr/Rdvv1xAFBeX7B1n/Hxf87xrwHivffjj5b5rk7j8mDuS/JcRg8R/y30kBn1Udy0Yu8Nun+ue/KQH/N1BLAQIXCxQAAgAIAN5Nv0bW2GRoywMAAAgmAAAJAAkAAAAAAAAAAAAAgAAAAABVSVBhY2thZ2VVVAUAB4fYalVQSwUGAAAAAAEAAQBAAAAAAwQAAAAA


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
//  lol  MessageBox "WorldSize:  " & SizeX & "-" & SizeY & "-" & SizeZ

MyArray(0) = CStr(Hex(SubAddress + 14))
MyArray(1) = CStr(Hex(SubAddress + SizeX*SizeY*SizeZ*14))
MyRange = Join(MyArray, "-")

TargetAdsArr = dm.FindIntEx(handle, MyRange, CaveSub, CaveSup, 2, 14, 0, 0) & "|" & dm.FindIntEx(handle, MyRange, FossilSub, FossilSup, 2, 14, 0, 0)

Addresses = Split(TargetAdsArr, "|")


//初始化窗口
fooX1 = 50
fooY1 = 660
fooWide = 241
fooHght = 241
foobar = dm.CreateFoobarRect(handle, fooX1, fooY1, fooWide, fooHght)
Delay 100
dm_ret = dm.FoobarDrawLine(foobar, fooWide/2, 0, fooWide/2, fooHght, "808080", 0, 1)
dm_ret = dm.FoobarDrawLine(foobar, 0, fooHght / 2, fooWide, fooHght / 2, "808080", 0, 1)



BlockCount = 0
For Each I In Addresses
	BlockID = AdrToPos(I,0)
	BlockType = AdrToPos(I, 1) Mod 16
	If BlockType = 1 And BlockID <> 134 Then 
		X = CStr(AdrToPos(I, 2))
		Y = CStr(AdrToPos(I, 3))
		Z = CStr(AdrToPos(I, 4))
		BlockCount = BlockCount + 1
		dm_ret = dm.FoobarFillRect(foobar, 4 * X + 1, 4 * Y + 1, 4 * X + 4, 4 * Y + 4, "FF9c3b")//标出坐标
		If BlockID > 120 And BlockID < 133 Then 
			Block = "CaveArt"
			Else 
			Block = "Fossil"
		End If
		For iz = 0 To 79
			add = SubAddress + (((BX * SizeY) + BY) * SizeZ + iz)*14
		Next
	End If
Next

dm_ret = dm.FoobarDrawText(foobar,125,0,200,30, Block&" :"&X & "|" & Y & "|" &Z,"D19466",1)



While 0=0
	Call DrawCharPos
	dm_ret = dm.FoobarUpdate(foobar)
	Delay 500
Wend

Function AdrToPos(adr, off)
	Dim Arr(1)
	Arr(0) = adr
	Arr(1) = CStr(off)
	PStr = Join(Arr,"+")
	AdrToPos = dm.ReadInt(handle,PStr,2)
End Function



Sub DrawCharPos
	dm_ret = dm.FoobarTextRect(foobar,5,5,100,200)
	dm_ret = dm.FoobarClearText(foobar)
	CharX = round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC"))
	CharY = round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC0"))
	CharZ = round(dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBC4"))
	dm_ret = dm.FoobarPrintText(foobar,CharX&"|"&CharY&"|"&CharZ,"d19466")
	dm_ret = dm.FoobarFillRect(foobar, 4*CharX+1 , 4*CharY + 1, 4*CharX+4 , 4*CharY + 4, "FF0000")
	
End Sub


Sub OnScriptExit
	dm_ret = dm.FoobarClose(foobar)
End Sub
