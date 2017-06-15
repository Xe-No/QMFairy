[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=120
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=d72cad69-44b1-4b7f-915f-74f8554ad4b8
Description=后台连点
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
UserVar Tick = 200 "点击间隔(ms)"
handle = Plugin.Window.MousePoint
GetCursorPos mx,my   

sRect = Plugin.Window.GetClientRect(handle)
dim MyArray
MyArray = Split(sRect, "|")     
L = Clng(MyArray(0)): T = Clng(MyArray(1))   
R = Clng(MyArray(2)) : B = Clng(MyArray(3))

Do
	Call Plugin.Bkgnd.LeftClick(handle, mx - L, my - T)
	Delay Tick
Loop
