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
MacroID=9994924f-d0da-4ef8-b830-4dfc8dbd7834
Description=Ñ°ÕÒ·½¿é
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
UEsDBBQAAgAIAOalsUaAVxTCzAMAAAgmAAAJABEAVUlQYWNrYWdlVVQNAAdn/lhVZ/5YVWf+WFXtWE1PE0EYfrdFaAv0A6F8CuVb8aJevBgTSySSABJaPXgwVkRBy0K2Reu/8B8YLl686MF4MlyNHoR/oIkX482DN6nPbGftlEDcmdm6NuElL1PKzj4z77xfzwSpIrufEp+3X/d9oQNymYK0Xw5Ts/CdwdWWOFGA/71fLpedr8vH0lDyC9rEz5Cd9QloCzQMDUEj0HZoK7QNGq0cPcWgCT5v/9iMDStLtIGfIqXoKpkYLXpKMpKExzjvMv7y7J2HnS+eP9s1gsQdC3KDZukcqUuIDMPBDxzxzOJ0BdfBF/83TVma01hBhOMneezI4mdh701aoQXK0TpGWemggI2f4LnX7bwmPjrx+7/qsdRXZjasdY3wIzb/vMZ8g/REd76ufNzbe/X23c431fkSIVuX+ap5p5r/AjU9n9szc3Ilqzo5ukt5xTVEkf9aeTlxix8Q8t9NWqMCVHUFcYX9BwX8JaDm6B5dhx3ykrXXyf9t/J1u8ZsE/CzwS6j7GudvyO6fnX2If55G95GHWoor6VTAbxb2X8VP4xyW6ZE8vt0vxyTs33Lg/Jc17d/O7ekWP0SVHl6UVQRliRpPWnzG/3m4ze2yNJ9JZXJmIZVZsdbu1wl//OVtrfm3kHks5J8V/FYRln+7eEy59b+w4P9ziD35qKv1/zh/n1v8yKHxn8E6VmEHuWrYg/g/SSwPu8dvFfCvoPvftGuABTWxBrkqlMT+w1Th5W7x2wT8Gezd1Ms/0vWP5atLf/afR/V9gDUwu5sq+V8aP1pz/jnYv4g1MDuk7XNwKkHVN46W0wr1Jybgp+33V+LPDd4h/md0UvXezc2cuICvmz90+09dmTU3t4rpjZLufFUO0+j8JQvPL9q9r4r32flHOv4Sgv8tAr8E9Dy6cBWJKuB31MQ/u/9RZ7ARnKCD3XvEM869Tz3vf8bJff5n9crpv/3gfyxfhflnL/jfEMZBif13kaf8z0hhnJDAT5K3/K8PY7cEfjf5y/96qNq3e8D/pP2vl7zlf/0YRyXs30fe8r9hjAMS+P1U5X8fvr7/vvND5wZPT3T7hwvQMehFg/Wy8uJ3/Q36jO8B/5OOvwHylv+N8ZziFv8Uecv/zhDjAe7xB8lb/jeJcUQCf4j85X8p8pf/DZPYf+ZQ/wv0hPMwWelQwB8R8OdpCxZg/HMOakr3IOz+k/nzWYnzHxXw/b6/8lt0+e/Um1Wt+f3bWV/3v2D7/TqiIK98/yDr/2OC/10D3mPl249K/psiufuP8QP5bxkxWPiH/HdCwGdVx7KR8/z2qf75b1LA/w1QSwECFwsUAAIACADmpbFGgFcUwswDAAAIJgAACQAJAAAAAAAAAAAAAIAAAAAAVUlQYWNrYWdlVVQFAAdn/lhVUEsFBgAAAAABAAEAQAAAAAQEAAAAAA==


[Script]
Set dm = createobject("dm.dmsoft")

Dim MyArray(1), Addresses

SubID = 121
SupID = 160

handle = Plugin.Window.MousePoint
SubAddress = dm.ReadInt(handle, "[[<Cubic.exe>+280A20]+680]+75C", 0)
MyArray(0) = CStr(Hex(SubAddress + 14))
MyArray(1) = CStr(Hex(SubAddress + 80*60*60*14))
MyRange = Join(MyArray, "-")

TargetAdsArr = dm.FindIntEx(handle, MyRange, SubID, SupID, 2, 14, 0, 0)

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
	End If
Next

MessageBox X & "|" & Y & "|" &Z &"---"& BlockCount


Function AdrToPos(adr, off)
	Dim Arr(1)
	Arr(0) = adr
	Arr(1) = CStr(off)
	PStr = Join(Arr,"+")
	AdrToPos = dm.ReadInt(handle,PStr,2)
End Function
