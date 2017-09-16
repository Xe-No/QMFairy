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
MacroID=d887c1cc-ecc5-4d56-b0b5-5b7799424fa5
Description=后台连点
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
UserVar Delay_Time = 200 "Delay_Time"
handle = Plugin.Window.MousePoint
GetCursorPos MX, MY

Array_Rect =Split( 	Plugin.Window.GetClientRect(handle)	, "|") 
  
//下面这句将字符串转换成数值   
L = Clng(Array_Rect(0)): T = Clng(Array_Rect(1))   
R = Clng(Array_Rect(2)) : B = Clng(Array_Rect(3))


Do
	Call Plugin.Bkgnd.LeftClick(handle, mx - L, my - T)
	Delay Delay_Time
Loop
