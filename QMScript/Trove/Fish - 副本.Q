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
MacroID=6087fdc6-4661-4cec-91b6-2edda01616ee
Description=Fish Original
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


UserVar Fish_Time = 90 "FishTime"


handle = Plugin.Window.MousePoint()
Plugin.Window.Size handle, 1200, 800



sRect = Plugin.Window.GetClientRect(handle)    
Dim MyArray   
MyArray = Split(sRect, "|")     
L = Clng(MyArray(0)): T = Clng(MyArray(1))   
R = Clng(MyArray(2)): B = Clng(MyArray(3))   
Wide = R - L
High = B - T

rate_x = 0.505
rate_y = 0.512


For fish_count = 1 To Fish_Time


Plugin.Bkgnd.KeyPress handle, 70

Delay 20000
c1 = 9
Do
Call Plugin.Color.ColorToRGB(     Plugin.Bkgnd.GetPixelColor(handle, 679, 387) ,R, G, B   )
Delay 200

Loop Until R < 90

//MessageBox "Catcha!"

Plugin.Bkgnd.KeyPress handle, 70

Delay 2000

If fish_count mod 5 = 1 Then 
	
Plugin.Bkgnd.KeyPress handle, 32
Delay 1000
End If


Next
