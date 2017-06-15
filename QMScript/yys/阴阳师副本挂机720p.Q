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
MacroID=f876e570-d919-464b-8c40-16c44aed9bf2
Description=阴阳师副本挂机720p
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
UserVar host = Droplist{ "副机" : 0 | "主机" : 1 } = 0 "主副机选项"

Set dm = createobject("dm.dmsoft")  //创建对象
handle = Plugin.Window.MousePoint()
dm_ret = dm.BindWindow(handle, "normal", "normal", "normal", 0)

Set button = CreateObject("Scripting.Dictionary")
button.add "觉醒", 0
button.add "御魂", 1
button.add "式神", 2
button.add "结界", 3
button.add "邀请", 4
button.add "准备", 5
button.add "开始", 6

Set scene = CreateObject("Scripting.Dictionary")
scene.add "探索", 0
scene.add "准备", 1
scene.add "胜利", 2
scene.add "邀请", 3
scene.add "开始", 4

button_x = Array( 100, 200, 300, 400, 790, 1167, 1050)
button_y = Array( 670, 670, 670, 670, 427, 545 , 600 )
scene_x =  Array( 		202			,1167	 	,484		,790		,1050)
scene_y  = Array( 		645			,545		,186		,427		,600)
scene_color = Array(	"4c47c9"	,"d4af7c"	,"ccbca8"	,"f4b25f"	,"f4b25f")


//MessageBox SceneQ ("准备")
//EndScript
//WaitScene "准备"
//Delay 1000
//ClickButton ("准备")

//EndScript

Do

If host Then 
	WaitScene("开始")
	ClickButton ("开始")
Else
	WaitScene("邀请")
	ClickButton ("邀请")
End If

WaitScene ("准备")
Delay 5000
ClickButton("准备")

WaitScene ("胜利")
Click 500,500
Delay 2000
Click 500,500
Delay 5000
Click 500,500
If host Then 
	WaitScene("邀请")
	ClickButton ("邀请")
End If




Loop




EndScript

Function ClickButton(name)
	Dim index
	index = button.Item (name)
	Call Click( button_x(index) , button_y(index)   )
End Function

Function SceneQ(name)
	Dim index, get_color, bool
	index = scene.Item(name)
	get_color = dm.GetColor(  scene_x(index) , scene_y(index) )
	bool = StrComp( get_color , scene_color(index) )
	If bool = 0 Then 
		SceneQ = 1
		Else 
		SceneQ = 0
	End If	
End Function

Function WaitScene(name)
	Do
		If SceneQ(name) = 1 Then 
			Exit Do
		End If
		Delay 200
	Loop

End Function


Function Click(x, y)
	dm.MoveTo x, y
	dm.LeftClick 
End Function



