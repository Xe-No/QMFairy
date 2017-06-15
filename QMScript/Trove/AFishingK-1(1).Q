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
MacroID=d63f8e9d-d3ec-4cb8-b643-1bf28fbfca10
Description=AFishingK-Refine
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

Dim Wide, High
Handle = Plugin.Window.MousePoint()
Wide = 1280
High = 960
Plugin.Window.SetClientSize Handle, Wide, High


For fish_count = 1 To Fish_Time



Plugin.Bkgnd.KeyPress handle, 70
Delay 15000

XY = Plugin.Bkgnd.FindColorEx(Handle, 0.4 * Wide, 0.3 * High, 0.6 * Wide, 0.5 * High, "7060D0", 1, 0.7)
Array_XY = Split(XY, "|")
X = Array_XY(0)
Y = Array_XY(1)



Do 
	Dim  R1, G1, B1,  R2, G2, B2
	Call Plugin.Color.ColorToRGB(Plugin.Bkgnd.GetPixelColor(Handle, X, Y - 10), R1, G1, B1)
	Call Plugin.Color.ColorToRGB(Plugin.Bkgnd.GetPixelColor(Handle, X, Y + 10), R2, G2, B2)

Loop Until R1 < 120 And R2 < 120


Plugin.Bkgnd.KeyPress handle, 70
Delay 2000



If fish_count mod 5 = 1 Then 	
	Plugin.Bkgnd.KeyPress handle, 32
	Delay 1000
End If


Next

EndScript

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



