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
MacroID=abd55e5e-af4a-4772-9afd-ca4aae184df8
Description=AltsRoom_Testing
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

ReapArray = Array(138,143,220,235,147,223)

Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()
Call Lib.CC.GetCharPosInt()





Call Lib.CC.SetCamera(0, 45)
Call AltsRoom_ReapLine(15,ReapArray,6)

Function AltsRoom_ReapLine(Central_X, ReapArray, ReapTotal)
Dim reap_count, plat_z
reap_count = 0
plat_z = 99
Call Lib.CC.TP(Central_X, 39, plat_z)
Delay 200

For TarY = 38 To 10 Step  -1
For TarZ = 97 To 99
For TarX = Central_X - 1 To Central_X + 1
	
	
	If AltsRoom_Grab(TarX,TarY,TarZ, ReapArray) Then
		reap_count = reap_count + 1
	End If
	If reap_count - ReapTotal = 0 Then
		Exit Function
	End If
	
Next
Next
Next

End Function

Function AltsRoom_Grab(TarX, TarY, TarZ, ReapArray)
	
If InArray(Lib.CC.ReadBlock(TarX, TarY, TarZ), ReapArray) = 1 Then 
	

	Dim click_x, click_y, plat_z
	click_x = 640
	click_y = 480 + (TarZ - 100) * 60
	plat_z = 99
	
	BlockCount = BlockCount + 1
	Call Lib.CC.TP(TarX, TarY + 1, plat_z)
	Delay 100
	Call Plugin.Bkgnd.LeftClick(handle, click_x, click_y)
	
	Do
		Delay 100
	Loop While InArray(Lib.CC.ReadBlock(TarX, TarY, TarZ), ReapArray) = 1
	AltsRoom_Grab = True
	
Else 
	AltsRoom_Grab = False
End If


End Function

Function InArray(ele, TarArray)
	For Each TarI In TarArray
		If TarI - ele = 0 Then 
			InArray = 1
			Exit For
			Else 
			InArray = 0
		End If
	Next
	
End Function
