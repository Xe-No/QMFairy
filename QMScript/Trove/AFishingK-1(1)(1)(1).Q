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
MacroID=10465e92-d4b0-425b-a1d2-c9148d49dbc6
Description=*Fishing
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

GetCursorPos MX, MY
Array_Rect =Split( 	Plugin.Window.GetClientRect(handle)	, "|")  
L = Clng(Array_Rect(0)): T = Clng(Array_Rect(1))   
R = Clng(Array_Rect(2)) : B = Clng(Array_Rect(3))

X = MX - L 
Y = MY - T


For fish_count = 1 To Fish_Time


Dim  R1, G1, B1,  R2, G2, B2

Do 
	
	Call Plugin.Color.ColorToRGB(Plugin.Bkgnd.GetPixelColor(Handle, X, Y ), R1, G1, B1)
	//Call Plugin.Color.ColorToRGB(Plugin.Bkgnd.GetPixelColor(Handle, X, Y + 10), R2, G2, B2)
	Delay 200
	
Loop Until R1 < 120 And R2 < 120


Plugin.Bkgnd.KeyPress handle, 70
Delay 2000


If fish_count mod 5 = 1 Then 	
	Plugin.Bkgnd.KeyPress handle, 32
	Delay 1000
End If

Plugin.Bkgnd.KeyPress handle, 70
Delay 3000


Do 

	Call Plugin.Color.ColorToRGB(Plugin.Bkgnd.GetPixelColor(Handle, X, Y ), R1, G1, B1)
	//Call Plugin.Color.ColorToRGB(Plugin.Bkgnd.GetPixelColor(Handle, X, Y + 10), R2, G2, B2)
	Delay 200
	
Loop While R1 < 120 And R2 < 120


Next

EndScript

For fish_count = 1 To Fish_Time 

//�Ӹ�
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



