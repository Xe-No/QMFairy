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
MacroID=eaf2986d-dfd7-45a1-965f-bdbe0f82fd6c
Description=AFishingK
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


sRect = Plugin.Window.GetClientRect(handle)    
Dim MyArray   
MyArray = Split(sRect, "|")     
L = Clng(MyArray(0)): T = Clng(MyArray(1))   
R = Clng(MyArray(2)): B = Clng(MyArray(3))   
Wide = R - L
High = B - T

rate_x = 0.493
rate_y = 0.465



For fish_count = 1 To Fish_Time 

//»Ó¸Ë
Plugin.Bkgnd.KeyPress handle, 70

Delay 20000


Do

//Call Plugin.Color.ColorToRGB(Plugin.Bkgnd.GetPixelColor(handle, rate_x * Wide, rate_y * High), R, G, B)
Call Plugin.Color.ColorToRGB(     Plugin.Bkgnd.GetPixelColor(handle, rate_x * Wide, rate_y * High ) ,R, G, B   )
Delay 200
Loop While Abs( R-G ) < 20


//MessageBox "Catcha!"

Plugin.Bkgnd.KeyPress handle, 70

Delay 2000

If fish_count mod 5 = 1 Then 
	
Plugin.Bkgnd.KeyPress handle, 32

Delay 1000
End If

Next



