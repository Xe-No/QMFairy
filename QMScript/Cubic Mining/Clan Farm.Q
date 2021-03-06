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
MacroID=d3d15286-59d4-43bd-895d-08d6434630ee
Description=Clan Farm 通用
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
//Configuration



UserVar ReapCases=DropList{"自定义":0|"杨梅-248":1|"棉花-241":2|"所有农作物":3|"Rubber&Cotton":4}=2 "收获类型"
UserVar ReapArea =DropList{"第一层":0|"第二层":1}=1 "收获区域"
UserVar ReapString="248" "自定义收获品种"

TeleWait = 50 //检测-传送间隔(ms) 建议:30-100
TeleWait2 = 100 //传送-点击间隔(ms) 建议:30-100
GrabWait = 50 //收获完成-再传送间隔(ms) 正常状态建议:400 5x建议:50-150"

//ReapArray = Array(238, 241, 243, 245, 247, 251) //All
//ReapArray = Array(238)  //Yumberry
  //Cotton,Rubber
Select Case ReapCases
	Case 0
		ReapArray = Split(ReapString,",")
	Case 1
		ReapArray = Array(238)
	Case 2
		ReapArray = Array(247)
	Case 3
		ReapArray = Array(238, 241, 243, 245, 247, 251)
	Case 4
		ReapArray = Array(247, 251)
End Select

max_entity = 250


//Configuration End

//Script Start
Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()
Call Lib.CC.GetCharPosInt()





Call Lib.CC.SetCamera(0, 89)

BlockCount = 0

Rem FarmStart

Call FarmPlane(99 - 30 * ReapArea )

Goto FarmStart


Function FarmPlane(TarZ)

TarY = 1

For SizeY - 1
	Call Lib.CC.GetCharPos()
	If CharX - SizeX / 2 < 0 Then 
		TarX = 0
		dx = 1
	Else
		TarX = SizeX - 1
		dx = -1
	End If
	
	
	For SizeX - 1
			If InArray(Lib.CC.ReadBlock(TarX, TarY, TarZ), ReapArray) = 1 Then 
				
				Delay TeleWait
				BlockCount = BlockCount + 1
				返回值 = Lib.CC.WriteBlock(TarX, TarY-1, TarZ, 0)
				返回值 = Lib.CC.TPEx(TarX, TarY -1,TarZ-1)
				Delay TeleWait2
				
				CCount = 0
//				Call Plugin.Bkgnd.LeftClick(handle, 640, 560)
								Call BiasClick(handle, 0,80)
				While InArray(Lib.CC.ReadBlock(TarX,TarY,TarZ), ReapArray) = 1
					CCount = CCount + 1
					Delay 20
					If CCount > 100 Then 
						Delay 500
						Goto Skip2
					End If
				Wend
				
For index = 1 To max_entity
	
	Call Lib.CC.GetCharPos()
	Call Lib.CC.GetEntityID(index)
	Call Lib.CC.GetEntityPos(index)
	If Abs(CharX - EntityX) <1.5 And Abs(CharY - EntityY) <1.5 And EntityType < 10 Then
		Call Lib.CC.TP(EntityX, EntityY, EntityZ)
	End If
Next
				Rem Skip2
				Delay GrabWait
			End If
			
			
		
		TarX = TarX + dx
		
	Next

	TarY = TarY + 1
Next

End Function


Function InArray(ele, TarArray)
	For Each TarI In TarArray
		If TarI - ele = 0 Then 
			InArray = 1
			Goto hell
			Else 
			InArray = 0
		End If
	Next
	Rem hell
End Function

Sub OnScriptExit
	MessageBox BlockCount
End Sub


Function BiasClick(handle, bx, by)

Call Lib.CC.GetCharPix()

Call Lib.CC.CubicClick(handle, CharPiX + bx, CharPiY + by)

	
	
End Function
