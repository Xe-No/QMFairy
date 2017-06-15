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
MacroID=0879e115-0237-4fe7-af53-1024348e3bef
Description=阴阳师副本挂机360p-主
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
UserVar host = Droplist{ "副机" : 0 | "主机" : 1 } = 0 "主副机选项"

Set dm = createobject("dm.dmsoft")  //创建对象
handle = Plugin.Window.MousePoint()
dm_ret = dm.BindWindow(handle, "normal", "windows", "windows", 0)

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

button_x = Array( 50,  100, 150, 200, 395, 583, 525 )
button_y = Array( 335, 335, 335, 335, 213, 272, 300 )
scene_x =  Array( 	101, 583, 242, 395, 525)
scene_y  = Array( 	322, 272, 93, 213, 300)
scene_color = Array(	"4035ad",	"d3ae7c",	"cdbea9"	,"f4b25f"	,"f4b25f")

//dm.WaitKey 115,0
//test_name = "胜利"
//index = scene.Item(test_name)
//get_color = dm.GetColor(scene_x(index), scene_y(index))
//MessageBox get_color
//MessageBox SceneQ(test_name)
//ClickButton ("觉醒")
//EndScript

Do

If host Then 
	WaitScene ("开始")
	Delay 5000 
	ClickButton ("开始")
Else
	WaitScene("邀请")
	ClickButton ("邀请")
End If

WaitScene ("准备")
Delay 2000 + 100 * host
ClickButton("准备")

WaitScene ("胜利")
Delay 500 + 100 * host

ClickButton ("邀请") //fake
Delay 2000 + 100 * host

ClickButton ("邀请")//fake
Delay 5000 + 100 * host

ClickButton ("邀请")//fake
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



