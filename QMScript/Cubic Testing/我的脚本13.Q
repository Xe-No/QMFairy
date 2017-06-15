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
MacroID=dc604ead-580b-49e0-997e-a59d1131f9e0
Description=随意瞬移脚本
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
//任意传送脚本


Call Lib.CC.Initailize()



Call Lib.CC.GetWorldSize()
Call Lib.CC.GetCamera()

//定义单位：°
Dim Deg, Pi
Pi = 4 * Atn(1)
Deg = Pi / 180



//MessageBox Lib.CC.ReadBlock(19, 0, 87)
//EndScript



//相机与人物距离

DisCamChar = 22.5

//游戏视角

WHA = 0.341615	//宽半角
HHA = 0.260602	//高半角

//游戏分辨率

XHP = 640	//x半分辨率
YHP = 480 	//y半分辨率


//获取鼠标位置
sRect = Plugin.Window.GetWindowRect(handle)    
dim MyArray   
MyArray = Split(sRect, "|")    
W1 = Clng(MyArray(0)): H1 = Clng(MyArray(1))   
W2 = Clng(MyArray(2)): H2 = Clng(MyArray(3)) 
GetCursorPos mx,my 

pixel_x = mx - W1
pixel_y = my - H1

//MessageBox pixel_x
//pixel_x = 640
//pixel_y = 480


Call Lib.CC.GetCamera()



Tx = tan( (pixel_x - XHP) / XHP * WHA )
Ty = tan( (pixel_y - YHP) / YHP * HHA )


TracePrint Tx
theta = Polar * Deg
phi = Azimu * Deg


//视角线方程的参数 ABCD
A = cos( theta ) * sin( phi )  + Tx * cos( phi ) - Ty * sin( theta ) * sin( phi )
B = -cos( theta ) * cos( phi ) + Tx * sin( phi ) + Ty * sin( theta ) * cos( phi )
C = sin(theta)                 + Ty * cos( theta )
D = - ( A*CamX + B*CamY + C*CamZ  )

DirX = Sgn(A)
DirY = Sgn(B)
DirZ = Sgn(C)

Call Lib.CC.GetCamPos()
Call Lib.CC.GetWorldSize()

BX = round(CamX)
BY = round(CamY)
BZ = round(CamZ)
Dim direction

Do

//TracePrint bx & " " & by & " " & bz
//方块判定
If Lib.CC.ReadBlock(BX, BY, BZ) <> 0 And 0 <= BX <=SizeX -1 And 0 <= BY <=SizeY -1 And 0 <= BZ <=SizeZ -1 Then 
	Call Lib.CC.TP(BX, BY, BZ - 1)
	Exit Do
Else 
	
	direction = InterscetBlock(BX, BY, BZ)
	//TracePrint direction
	Select Case direction
	Case 0
		BX = BX + DirX
	Case 1
		BY = BY + DirY
	Case 2
		BZ = BZ + DirZ
	End Select
End If


Loop



//
//Select Case max_i
//	Case 0
//		If A > 0 Then 
//			For x = round(CamX) + 1 To SizeX - 1
//				
//				dx = x - CamX + 0.5
//				t = dx / A
//				y = round( CamY + t * B)
//				z = round( CamZ + t * C)
//				
//				If Lib.CC.ReadBlock(x, y, z) <> 0 And 0 <= x <=SizeX -1 And 0 <= y <=SizeY -1 And 0 <= z <=SizeZ -1 Then 
//					//MessageBox x & " " & y & " " & z
//					Call Lib.CC.TP(x,y,z-1)
//					Exit For
//				End If
//				
//			Next
//		Else
//			For x = round(CamX) - 1 To 0
//				
//				dx = x - CamX - 0.5
//				t = dx / A
//				y = round( CamY + t * B)
//				z = round( CamZ + t * C)
//				
//				If Lib.CC.ReadBlock(x, y, z) <> 0 And 0 <= x <=SizeX -1 And 0 <= y <=SizeY -1 And 0 <= z <=SizeZ -1 Then 
//					//MessageBox x & " " & y & " " & z
//					Call Lib.CC.TP(x,y,z-1)
//					Exit For
//				End If
//				
//			Next
//				
//			
//			
//		End If
//	Case Else
//	
//End Select

Function FindMax(list)
//找到数组中最大元素的位置
Dim i, max_i, max
For i = 0 To UBound(list)	'假设数组元素个数为100个
  If max < list(i) Then 
     max = list(i)'如果x大于数组中的元素，则让x等于数组中的这个元素，这样x最终就成了数组中最小的数
     max_i = i'y获得x为最小值时，i的值，也就是x为数组中的第几个数字
  End If
Next

FindMax = max_i
End Function


Function FindMin(list)
//找到数组中最小元素的位置
Dim i, min_i, min
min = 10000000
For i = 0 To UBound(list)	'假设数组元素个数为100个
  If min > list(i) Then 
     min = list(i)'如果x大于数组中的元素，则让x等于数组中的这个元素，这样x最终就成了数组中最小的数
     min_i = i'y获得x为最小值时，i的值，也就是x为数组中的第几个数字
  End If
Next

FindMin = min_i
End Function


Function InterscetBlock(bloX, bloY, bloZ)

//计算各方向截距，并取最小值

Dim interX, interY, interZ
interX = bloX + DirX * 0.5
interY = bloY + DirY * 0.5
interZ = bloZ + DirZ * 0.5

Dim radius(2)
radius(0) = (interX - CamX) / A
radius(1) = (interY - CamY) / B
radius(2) = (interZ - CamZ) / C

//MessageBox radius(0) & " " & radius(1) & " " & radius(2)


InterscetBlock = FindMin(radius)

	
End Function
