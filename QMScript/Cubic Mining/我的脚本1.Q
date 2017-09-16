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
MacroID=1b83e2e2-1103-4df8-ab05-ea45a148a4e3
Description=ÎÒµÄ½Å±¾1
Enable=1
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


addr = Lib.CC.FindBlock(773)
addresses = Split(addr, "|")



water_count = 0
For Each I In addresses

	If water_count mod 10 = 0 Then 
		index = water_count / 10
		Begin_Y = 929
		Begin_X_list = Array(440, 500, 560, 720, 780, 840, 900)
		Call Lib.CC.CubicClick(handle, Begin_X, Begin_X_List(index))
		Delay 500
	End If
	

	bx = Lib.CC.AdrToPos(I, 2)
	by = Lib.CC.AdrToPos(I, 4)
	bz = Lib.CC.AdrToPos(I, 6)
	
	Call Lib.CC.GetCharPos()
	dx = bx - CharX
	dy = by - CharY
	
	If Abs(dx) > 5 Or Abs(dy) > 5 Then 
		Call Lib.CC.TP(bx, by, bz - 1)
		
	End If
	
	Call Lib.CC.GetCharPos()
	dx = bx - CharX
	dy = by - CharY
	
	
	Call Lib.CC.BiasClick(handle, dx * 80, dy * 80)
	Delay 200
	
	water_count = water_count + 1
	
	

Next