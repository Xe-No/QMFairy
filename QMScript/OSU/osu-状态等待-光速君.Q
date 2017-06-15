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
MacroID=352b62ff-95e0-42cf-b095-4ca36a04c7e1
Description=osu-×´Ì¬µÈ´ý-¹âËÙ¾ý
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
wait_time = 80
file_name = "112651 Various Artists - Square Jump Practice Maps\Various Artists - Square Jump Practice Maps (Jemmmmy) [200BPM t+pazolite_cheatreal GO TO HELL  AR10].osu"


handle = Plugin.Window.MousePoint 

sRect = Plugin.Window.GetClientRect(handle) 
Dim temp_array   
temp_array = Split(sRect, "|")
L = Clng(temp_array(0)) : T = Clng(temp_array(1))
  

center_x = 640 : center_y = 560
center_x_g = 256 : center_y_g = 192
rate_g = 2


//Call Spin(3000)
//EndScript

SetSimMode 2

//Hit Read
Const ForReading = 1 : ForWriting = 2
Dim fso, osu
Set fso = CreateObject("Scripting.FileSystemObject")
Set osu = fso.OpenTextFile("D:\Games\osu!\Songs\" & file_name, ForReading)
Do
Loop While osu.ReadLine <> "[HitObjects]"


Dim state_array(), index
index = 0

Do
If osu.atendofstream  Then 
	//MessageBox ""
	Exit Do
End If

ReDim Preserve state_array(index)
state_array(index) = osu.ReadLine

index = index + 1
Loop

osu.close
///Hit Read

WaitClick

diff_time = Plugin.Sys.GetTime() - 16



For index_2 = 1 To index
 


position_array = Split(state_array(index_2), ",")
target_x = position_array(0) : target_y = position_array(1) : target_t = position_array(2) : target_type = position_array(3) mod 4


Do
Delay 20
Loop Until target_t - ( Plugin.Sys.GetTime() -  diff_time ) < wait_time

Select Case target_type

Case 1
Call MoveSmooth(target_x, target_y, target_t - ( Plugin.Sys.GetTime() -  diff_time ) )
LeftClick 1
 
Case 0
Call MoveSmooth(L + center_x + 300,T + center_y, target_t - ( Plugin.Sys.GetTime() -  diff_time ) )
LeftDown 1

target_t_end = position_array(5) 
Call Spin(target_t_end - ( Plugin.Sys.GetTime() -  diff_time ) )
LeftUp 1

End Select


Next


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


Function Spin(allow_time)
Dim delay_time
delay_time = 5
Dim spin_radius
spin_radius = 100

Dim current_x, current_y, diff_x, diff_y, move_rate
move_rate = 0.4
dep_rate = 0.215
For allow_time\delay_time
GetCursorPos current_x, current_y
diff_x = (current_x - L - center_x)* move_rate
diff_y = (current_y - T - center_y)* move_rate


MoveR  diff_y - dep_rate * diff_x, -diff_x - dep_rate * diff_y
Delay delay_time
Next
	

End Function


