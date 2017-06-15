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
MacroID=0fa3b82c-baa3-4c6e-af48-601f06bb6a5e
Description=自动启动测试
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
cubic_path = "E:\Program Files\Cubic Castles\Cubic.exe"

RunApp cubic_path
Delay 1500

Hwnd = Plugin.Window.Foreground()  

MessageBox Hwnd
Call Lib.CC.Initailize()
dm.WaitKey 115,0
Call Refill

//------------Refill
Function Refill
	


Call Lib.CC.GetWorldSize()
Call Lib.CC.GetCharPosInt()


plat_z = 99
Position_Array = Array(440,500,560,720,780,840,900)
Start_X = 15 
For Index = 0 To 6

Call Plugin.Bkgnd.LeftClick(handle, Position_Array(Index), 929)

Call PlaceBlock_Row(Start_X + 4 * Index) 

Next

End Function


Function PlaceBlock_Row(central_x)   //外部变量 plat_z
Dim tarX, tarY, tarZ


For tarY = 5  To 38  Step 1
For tarZ = 99 To 97  Step -1
For tarX = central_x - 1 To central_x + 1
	If Lib.CC.ReadBlock(tarX, tarY, tarZ) = 0 Then 
		Call Lib.CC.TP(tarX, tarY + 1, plat_z)
		Call PlaceBlock(tarX, tarY, tarZ)
		Delay 50
	End If


Next
Next
Next

End Function


Function PlaceBlock(target_x, target_y, target_z)
Dim dx, dy

Call Lib.CC.SetCamera(0, 45)
Call Lib.CC.GetCharPos()
dx = (target_x - CharX) * 80
dy = (target_y - CharY) * 60 + (target_z -CharZ) * 60 - 60
Delay 50


CCount = 0
Call Lib.CC.WriteBlock(target_x, target_y - 1, target_z, 324)
Call Plugin.Bkgnd.LeftClick(handle, 640 + dx , 480 + dy)
While Lib.CC.ReadBlock(target_x, target_y, target_z) = 0
	CCount = CCount + 1
	Delay 50

Wend

End Function


//----------------
