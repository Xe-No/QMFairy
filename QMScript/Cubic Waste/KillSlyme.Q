[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=122
StopHotkeyMod=0
RunOnce=0
EnableWindow=
MacroID=355e513b-ad28-4d61-969d-40505a549516
Description=KillSlyme
Enable=0
AutoRun=0
[Repeat]
Type=1
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]
===通用脚本===.
【功能说明】.
按下热键即可反复点击鼠标左键，可调整点击频率.
.
【使用说明】.
按下热键即可反复点击鼠标左键，按中止键停止运行。.
注意：默认中止热键是双击鼠标热键，一般情况下需要多次连击鼠标左键才会停止。也是演示如何使用鼠标热键。.
.
【作者介绍】.
vrBrothers.Leo.
.
【制作日期】.
06年09月04日.
.

[Script]
Call Lib.CC.Initailize()

handle = Plugin.Window.MousePoint
dm_ret = dm.BindWindow(handle,"dx2","dx2","dx",0)
GetCursorPos mx,my   

sRect = Plugin.Window.GetClientRect(handle)
dim MyArray
MyArray = Split(sRect, "|")   
//下面这句将字符串转换成数值   
L = Clng(MyArray(0)): T = Clng(MyArray(1))   
R = Clng(MyArray(2)) : B = Clng(MyArray(3))

For 250
	dm.MoveTo  mx - L, my - T
	dm.RightClick
	Delay 7800
Next

MessageBox Killed
