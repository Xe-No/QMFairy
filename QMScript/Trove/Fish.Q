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
MacroID=ee29ef9c-0260-467d-b7c1-aa3c88e77eaa
Description=Fish
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

rate_x = 0.487
rate_y_1 = 0.4
rate_y_2 = 0.5

For rate_y = rate_y_1 To rate_y_2 Step 0.01

MessageBox Plugin.Bkgnd.GetPixelColor(handle, rate_x * Wide, rate_y * High )

Next


EndScript


For fish_count = 1 To Fish_Time 

//挥杆
Plugin.Bkgnd.KeyPress handle, 70

Delay 1000

//找寻浮标坐标
XY = Plugin.Bkgnd.FindColorEx(handle, rate_x_1 * Wide, rate_y_1 * High, rate_x_2 * Wide, rate_y_2 * High, "3325FF", 0, 0.7)
   
MyArray = Split(XY, "|")

X = Clng(MyArray(0)) : Y = Clng(MyArray(1))
MessageBox X
If X > 0 Then 
	Goto Finded
End If

XY = Plugin.Bkgnd.FindColorEx(handle, rate_x_1 * Wide, rate_y_1 * High, rate_x_2 * Wide, rate_y_2 * High, "231DAB", 0, 0.7)
 
MyArray = Split(XY, "|")     
X = Clng(MyArray(0)) : Y = Clng(MyArray(1))
If X > 0 Then 
	Goto Finded
End If

MessageBox "GG"
Rem Finded 

MessageBox XY
Delay 19000


Do

//Call Plugin.Color.ColorToRGB(Plugin.Bkgnd.GetPixelColor(handle, rate_x * Wide, rate_y * High), R, G, B)
Call Plugin.Color.ColorToRGB(     Plugin.Bkgnd.GetPixelColor(handle, X + 10, Y + 10 ) ,R, G, B   )
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


Function ColorFinding(Color)
XY = Plugin.Bkgnd.FindColorEx(Hwnd, 0, 0, 20, 20, "FFFFFF", 0, 0.9)   
//下面这句用于分割字符串   
dim MyArray   
MyArray = Split(XY, "|")   
//下面这句将字符串转换成数值   
X = Clng(MyArray(0)): Y = Clng(MyArray(1))   



	
	
End Function
