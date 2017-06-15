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
MacroID=6df7d3ab-4d22-4f45-8090-7c4d3816a401
Description=ÎÒµÄ½Å±¾1
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
Set dm = createobject("dm.dmsoft") 
handle = Plugin.Window.MousePoint()

GetColor = Plugin.Bkgnd.GetPixelColor(Hwnd, 0, 0)

Plugin.Window.Size handle, 1200, 800

dm_ret = dm.BindWindow(handle, "dx2", "dx2", "dx", 0)


For 200
	
dm.MoveTo 290, 605
dm.LeftClick 

Delay 3000

Next
