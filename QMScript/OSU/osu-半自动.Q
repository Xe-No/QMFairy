[General]
SyntaxVersion=2
BeginHotkey=113
BeginHotkeyMod=0
PauseHotkey=114
PauseHotkeyMod=0
StopHotkey=115
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=d084f9b8-ceeb-41df-9436-b86b34cd7f86
Description=osu-半自动
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
handle = Plugin.Window.MousePoint 

sRect = Plugin.Window.GetClientRect(handle) 
Dim temp_array   
temp_array = Split(sRect, "|")
L = Clng(temp_array(0)) : T = Clng(temp_array(1))
  

center_x = 640 : center_y = 560
center_x_g = 256 : center_y_g = 192
rate_g = 2



SetSimMode 2


Const ForReading = 1 : ForWriting = 2
Dim fso, osu
Set fso = CreateObject("Scripting.FileSystemObject")
Set osu = fso.OpenTextFile("E:\Program Files\按键精灵9A\QMScript\OSU\Various Artists - Square Jump Practice Maps (Jemmmmy) [BPM149 Distorted Reality Holy Crap!!That's Square jump!! AR8].osu", ForReading)
Do
Loop While osu.ReadLine <> "[HitObjects]"



WaitClick

diff_time = Plugin.Sys.GetTime() - 12920


Do
state_string = osu.ReadLine
If state_string = "" Then 
	Exit Do
End If

Dim state_array   
state_array = Split(state_string, ",")
target_x = state_array(0) : target_y = state_array(1) : target_t = state_array(2)
Call MoveSmooth(target_x, target_y, target_t - ( Plugin.Sys.GetTime() -  diff_time ) )
LeftClick 1
 

Loop 



Sub WaitStart

Do
FindColorEx L + 760, T +30, L + 762, T + 40,"0000D5",1,0.99,find_x, find_y
Delay 5
Loop While find_x < 0 And find_y < 0 


End Sub


Function MoveSmooth(target_x_g, target_y_g, allow_time)
// L,T,rate_g,center_?_? from outside
Dim delay_time
delay_time = 5 
Dim circle_radius
circle_radius = 30
Dim k_start
k_start = 0.95
Dim current_x,current_y, l_x,l_y, a_x,a_y, b_x,b_y, d_x,d_y, t

target_x = L + center_x + rate_g * (target_x_g - center_x_g)
target_y = T + center_y + rate_g * (target_y_g - center_y_g)


GetCursorPos current_x, current_y

t = 0
l_x = target_x - current_x
l_y = target_y - current_y
a_x = - 2  * l_x / allow_time ^ 3
a_y = - 2  * l_y / allow_time ^ 3
b_x =  3  * l_x / allow_time ^ 2
b_y =  3  * l_y / allow_time ^ 2
d_x = current_x
d_y = current_y


For allow_time\delay_time
GetCursorPos current_x, current_y

t = t + delay_time
f_x = a_x * t ^ 3 + b_x * t ^ 2 + d_x     + 0 * (Rnd() -0.5)
f_y = a_y * t ^ 3 + b_y * t ^ 2 + d_y     + 0 * (Rnd() -0.5)


MoveTo f_x, f_y
Delay delay_time
Next
	
	
End Function


