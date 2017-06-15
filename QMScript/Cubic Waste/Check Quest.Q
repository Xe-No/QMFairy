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
MacroID=c5b7ce8b-24a1-49ef-88f6-88daa1ac7ebf
Description=Check Quest
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
Call Lib.CC.Initailize()

dm_ret = dm.BindWindow(handle, "dx2", "dx2", "dx", 0)
Delay 100
Dm.SetPath "C:\Users\Administrator\Documents\DmRes"
 
Target_Array = Array("Blue_Flower", "Mountain_Boulder", "Mud", "Nest", "Pink_Coral", "Sandy_Block", "Sandy_Brick", "Soil", "String", "Water")

 


If	   dm.FindPic(150, 300, 550, 350, "Craft.bmp", "000000", 0.9, 2, intX, intY) = 0 Then 
	send_string = "Craft"
ElseIf dm.FindPic(150, 300, 550, 350, "Mine.bmp", "000000", 0.9, 2, intX, intY) = 0
	send_string = "Mine"
End If

For Each target In Target_Array
	If dm.FindPic(150, 300, 550, 350, target & ".bmp", "000000", 0.9, 2, intX, intY) = 0 Then 
		//MessageBox target
		send_string = send_string & "_" & target
	End If
Next

Delay 200
MessageBox send_string

Delay 1000
Call Plugin.Bkgnd.LeftClick(handle, 640, 880)
Delay 100

Select Case Send_string
Case "Mine_Blue_Flower"
	Call Lib.CC.TP(3, 16, 99)
Case "Mine_Mountain_Boulder"
	Call Lib.CC.TP(9, 5, 99)
Case "Craft_Mud"
	Call Lib.CC.TP(6, 12, 99)
Case "Craft_Nest"
	Call Lib.CC.TP(5, 12, 99)
Case "Mine_Pink_Coral"
	Call Lib.CC.TP(2, 5, 99)
Case "Craft_Sandy_Block"
	Call Lib.CC.TP(8, 12, 99)
Case "Craft_Sandy_Block"
	Call Lib.CC.TP(8, 12, 99)
Case "Craft_Soil"
	Call Lib.CC.TP(6, 12, 99)
Case "Craft_String"
	Call Lib.CC.TP(6, 12, 99)
Case "Mine_Water"
	Call Lib.CC.TP(10, 16, 99)
End Select




