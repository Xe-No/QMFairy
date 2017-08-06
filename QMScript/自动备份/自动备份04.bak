[General]
SyntaxVersion=2
MacroID=1834d786-5987-496b-befe-1a380672e8f1
[Comment]

[Script]
Function WaitLoading

Dim count 
count = 0

Do
	If count > 100 Then 
		WaitLoading = 1
		Exit Function
	End If
	Delay 200
	count = count + 1

Loop Until dm.GetColor(10, 10) = "000000"

TracePrint "Loading"

Do

	Delay 200
	count = count + 1
Loop While dm.FindPic(0, 0, 100, 100, "Menu.bmp", "000000", 0.95, 2, intX, intY) = -1 

TracePrint "UI found"
WaitLoading = 0

End Function

Function WaitColor(x, y, rgb)

Dim count 
count = 0

Do
	If dm.GetColor(x, y) = rgb Then 
		Exit Do
	End If

	Delay 50
Loop

End Function

Function ReapEgg
Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()

reset_time = 2

For reset_time
Dim Index, Zero_Counter, Reset_Counter
Index = 0
Zero_Counter = 0
index_bound = 0

Do
	
Call Lib.CC.GetEntityPos(Index)
Call Lib.CC.GetEntityID(Index)


//获取实体上界
If -1 < EntityX < SizeX And -1  < EntityY < SizeY And -1  < EntityZ < SizeZ  Then 
	index_bound = index 
	
Else 
	Zero_Counter = Zero_Counter + 1
	
End If


Index = Index + 1

If Zero_Counter > 1 Then 
	
	Delay 200
	Exit Do
End If


Loop

TracePrint index_bound

For index = index_bound To 0 Step -1

Call Lib.CC.GetEntityPos(Index)
Call Lib.CC.GetEntityID(Index)

//Collect
If -1 < EntityX < SizeX And -1  < EntityY < SizeY And -1  < EntityZ < SizeZ And 94 <=  EntityID <=99 Then 
	Dim block
	block = Lib.CC.ReadBlock( round(EntityX) , round(EntityY) , round(EntityZ)  )
	
	If block <> 140 Then 
		Call Lib.CC.GetCharPos() 
		Call Lib.CC.GetEntityPos(Index)
		Call Lib.CC.TP(EntityX, EntityY, EntityZ)
		dm.KeyPressChar "W"
//		dm.WaitKey 115, 0
		Delay 200
	End If

End If

Next

Next

TracePrint "Reap"

Delay 1000

End Function

Function GetBlockPixel(BX,BY,BZ)

Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()
Call Lib.CC.GetCamera()
Call Lib.CC.GetCharPix()

//定义单位：°
Dim Deg, Pi, disCamChar, WHA, HHA, XHP, YHP
Pi = 4 * Atn(1)
Deg = Pi / 180

//相机与人物距离

DisCamChar = 22.5

//游戏视角

WHA = 0.341615	//宽半角
HHA = 0.260602	//高半角

//游戏分辨率

XHP = 640	//x半分辨率
YHP = 480 	//y半分辨率


Dim dX,dY,dZ, dpox,dpoy, theta, phi

dX = BX - CharX
dY = BY - CharY
dZ = BZ - CHarZ

phi = Aizmu * Deg
theta = Polar * Deg

dpox = - dX * Cos( phi ) + dY * Sin( phi ) 
dpoy = dX * Sin(phi) * Cos( theta ) + dY * Cos( phi ) * Sin( theta ) + dZ * Sin(Theta)
	
BlockPix = Atn( dpox / DisCamChar ) / WHA * XHP + CharPix
BLockPiy = Atn( dpoy / DisCamChar ) / HHA * YHP + CharPiy


End Function

Function GetCursorBlockPos(pass_num)

Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()
Call Lib.CC.GetCamera()


//定义单位：°
Dim Deg, Pi, disCamChar, WHA, HHA, XHP, YHP
Pi = 4 * Atn(1)
Deg = Pi / 180

//相机与人物距离

DisCamChar = 22.5

//游戏视角

WHA = 0.341615	//宽半角
HHA = 0.260602	//高半角

//游戏分辨率

XHP = 640	//x半分辨率
YHP = 480 	//y半分辨率

Call Lib.CM.GetBkgndCursor()

Call Lib.CC.GetCamera()

Tx = tan( (CursorX - XHP) / XHP * WHA )
Ty = tan( (CursorY - YHP) / YHP * HHA )

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


Dim pass, counter
pass = pass_num
counter = 0
Do

//TracePrint bx & " " & by & " " & bz
//方块判定
If Lib.CC.ReadBlock(BX, BY, BZ) <> 0 And 0 <= BX <= SizeX - 1 And 0 <= BY <= SizeY - 1 And 0 <= BZ <= SizeZ - 1 Then 
	//MessageBox pass
	pass = pass - 1
	If pass < 0 Then 
		Exit Do
	End If
Else 
	
	

End If


direction = Lib.CM.InterscetBlock(BX, BY, BZ)
//TracePrint direction
Select Case direction
Case 0
	BX = BX + DirX
Case 1
	BY = BY + DirY
Case 2
	BZ = BZ + DirZ
End Select

counter = counter + 1
If counter > 300 Then 
	Exit Do
End If

Loop

GoldX = BX
GoldY = BY
GoldZ = BZ

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


InterscetBlock = Lib.CC.FindMin(radius)

	
End Function

Function GetBkgndCursor()


//获取鼠标位置
sRect = Plugin.Window.GetWindowRect(handle)    
Dim MyArray   
MyArray = Split(sRect, "|")    
W1 = Clng(MyArray(0)): H1 = Clng(MyArray(1))   
W2 = Clng(MyArray(2)): H2 = Clng(MyArray(3)) 
GetCursorPos mx,my 

CursorX = mx - W1
CursorY = my - H1



End Function

Sub DropItem


Call Lib.CC.TP(3, 37, 98)
dm.KeyPressChar "A"
Delay 3000
Call Lib.CC.BindClick(600,400)
Delay 1000

dm.MoveTo 414, 379
dm.LeftDown 
Delay 200

dm.MoveTo 591, 381
dm.LeftUp 
Delay 200

dm.MoveTo 743, 373
dm.LeftClick 
Delay 200

//快捷栏为空的颜色
Dim  Begin_Y, End_X, End_Y, em_color
Begin_Y = 929
End_X = 750
End_Y = 400
em_color = "465d5f"



Begin_X_list = Array(500,560,720,780,840,900)

For Each Begin_X In Begin_X_list
If dm.GetColor(Begin_X, Begin_Y) <> em_color Then 
	TracePrint dm.GetColor(Begin_X, Begin_Y)
	Call Lib.CM.DragFromTo( Begin_X, Begin_Y, End_X, End_Y)
	
End If
Next


//丢弃背包中的物品
//点击下拉框
Call Lib.CC.BindClick(640,945)
Delay 500
//判断物品存在
For index = 0 To 1000
	x = index mod 8
	y = index \ 8
	If Lib.CM.GetInvState(x,y) > 0 Then
		Exit For	
	End If
	
Next

For j = index - 1 To 0 Step - 1 
	
	pix0 = 412
	piy0 = 732

	//背包栏间隔
	inter = 64
	//初始坐标

	x = j mod 8
	y = j \ 8
	pix = pix0 + inter * x
	piy = piy0 + inter * y
	
	Call Lib.CM.DragFromTo( pix, piy, End_X, End_Y)
	Delay 500
	
	TracePrint "Item Dropped"
Next 



End Sub

Function GetInvState(inv_x, inv_y)
pix0 = 412
piy0 = 732

//背包栏间隔
inter = 64
//取色区域半径
radius = 30
//初始坐标
pix = pix0 + inter * x
piy = piy0 + inter * y
	
//color = dm.GetAveHSV(pix - radius , piy - radius , pix + radius , piy + radius )

pos = dm.FindColorE(pix - radius , piy - radius , pix + radius , piy + radius , "000000" , 0.9 , 0)
pos = split(pos,"|")
If int(pos(0)) > 0 Then
	GetInvState = 0
Else    
    GetInvState = 1
End If


	
End Function

Function DragFromTo(begin_x, begin_y, end_x, end_y)

Dim InterDrag
InterDrag = "400"
dm.MoveTo begin_x, begin_y
dm.LeftDown 
Delay 200

dm.MoveTo end_x, end_y
dm.LeftUp 
Delay 200
Delay InterDrag

	

End Function

Function LoginSequence(SeqName,Password,SeqSub,SeqSup)

For SeqIndex = SeqSub To SeqSup
	//跳过无效的小号
	If Lib.CC.GetAccState( SeqName & SeqIndex ) = 1 Then 
		Call SendInfo(SeqName & SeqIndex & " malfunctioned ! >_< Skipping ", 0)
		Goto Pass
	End If

	
	Call Login(SeqName & SeqIndex, Password)
	//Call SendInfo("Loading...", 2)
	Call Lib.CM.WaitLoading
	Call Lib.CC.GetSubAddress()
	
	Delay 200
	
	Call TP_Start()
	
	If IsAltsWorld Then 
		Call SendInfo("Alts room verified ! >:3", 1)
	Else 
		Call SendInfo("Alts room not verified , attempting to tp Master ", 3)
		Delay 100
		Call SendInfo(      TP_BOSS()        , 1)
		Delay 1000
		Call Lib.CM.WaitLoading
		If IsAltsWorld Then 
		
			Call SendInfo("Alts room verified ! >:3", 1)
		
		Else 
			Call SendInfo("Alts room still not verified , quest aborted :Q:", 3)
			Error_String = Error_String & SeqName & SeqIndex &  " : Not in Room"   & Chr(13)
			Goto Before_Logout
			
		End If
	End If



//	If IsAltsWorld Then 
//	dm_ret = dm.FoobarPrintText(foobar, "Alts room verified ! >:3", "FF0000")
//	
//	Else 
//			dm_ret = dm.FoobarPrintText(foobar, "Alts room not verified , quest aborted :Q:", "FF7F00")
//			Error_String = Error_String & SeqName & SeqIndex &  " : Not in Room"   & Chr(13)
//			Goto Before_Logout
//			
//	End If
	
	Delay Time_Sub
	Call SendInfo("Quest checking...", 2)
	Quest_Checked = CheckQuest()
	
	If Quest_Checked = "Invalid Quest" Then 
		Call SendInfo("Invalid Quest", 3)
		dm.WriteFile  "ScriptLog\" & Date & "Alts.txt", SeqName & SeqIndex & " : Invalid Quest" & Chr(13)
		Error_String = Error_String & SeqName & SeqIndex& " : Invalid Quest" & Chr(13)
		Goto Before_Logout
	Else
		Call SendInfo("Quest " & Quest_Checked & " detected ", 0)
	End If
	
	
	Call ExecuteQuest(Quest_Checked)

	Call SendInfo(EvaluateQuest, 1)
	
	
	
	Rem Before_Logout
	
	Call Lib.CM.DropItem()
	
	Delay 300
	
	Call Logout
	Call SendInfo(SeqName & SeqIndex & " deactivated !", 0)
	
	Rem Pass
	
Rem PassLogin	
Next

End Function

Function ActivateQuest(alt_name,alt_password)

//	If Lib.CC.GetAccState( alt_name ) = 1 Then 
//		Call SendInfo(alt_name & " malfunctioned ! >_< Skipping ", 0)
//		Goto Pass
//	End If
	info = ""
//继承上一个版本的变量
plat_z = 99
Time_PopUp = 500
Time_Logout = 500
Time_Sub = 500
Time_Craft_Click = 1500
	
	
	Call Login(alt_name, alt_password)
	Call Lib.CM.WaitLoading
	Call Lib.CC.GetSubAddress()
	
	Delay 200
	
	Call TP_Start()
	
	If IsAltsWorld Then 
		Call SendInfo("Alts room verified ! >:3", 1)
	Else 
		Call SendInfo("Alts room not verified , attempting to tp Master ", 3)
		Delay 100
		Call SendInfo(      TP_BOSS()        , 1)
		Delay 1000
		Call Lib.CM.WaitLoading
		If IsAltsWorld Then 
		
			Call SendInfo("Alts room verified ! >:3", 1)
		
		Else 
			Call SendInfo("Alts room still not verified , quest aborted :Q:", 3)
			ActivateQuest =  "Not in Room"
			Goto Before_Logout
			
		End If
	End If



//	If IsAltsWorld Then 
//	dm_ret = dm.FoobarPrintText(foobar, "Alts room verified ! >:3", "FF0000")
//	
//	Else 
//			dm_ret = dm.FoobarPrintText(foobar, "Alts room not verified , quest aborted :Q:", "FF7F00")
//			Error_String = Error_String & alt_name &  " : Not in Room"   & Chr(13)
//			Goto Before_Logout
//			
//	End If
	
	Delay Time_Sub
	Call SendInfo("Quest checking...", 2)
	Quest_Checked = CheckQuest()
	
	If Quest_Checked = "Invalid Quest" Then 
		Call SendInfo("Invalid Quest", 3)
		ActivateQuest = "Invalid Quest"
		Goto Before_Logout
	Else
		Call SendInfo("Quest " & Quest_Checked & " detected ", 0)
	End If
	
	
	Call ExecuteQuest(Quest_Checked)

	Call SendInfo(EvaluateQuest, 1)
	
	ActivateQuest = "Quest Completed"
	
	Rem Before_Logout
	
	Call Lib.CM.DropItem()
	
	Delay 500
	
	Call Logout
	Call SendInfo(alt_name & " deactivated !", 0)
		

End Function


Function TP_start()

Call Lib.CC.Tp( 11 , 37 , 98 )
Delay 200
dm.KeyPressChar "W" 


End Function

Function Login(Name, Password)

Call Lib.CC.BindClick( 763, 618)
Delay 50
dm.SendString handle, Name
Delay 50
Call Lib.CC.BindClick( 763, 671)
Delay 50
dm.SendString handle, Password
Call Lib.CC.BindClick( 640, 777)



Call SendInfo(Name & " activated ! ^^", 0)


End Function


Sub Logout

Dim result, count, Time_PopUp

Time_PopUp = 500

Call Lib.CC.BindClick( 20, 20)
Delay Time_PopUp
Call Lib.CC.BindClick( 1010, 720)

Do
Delay 100
Loop While dm.FindPic(800, 0, 1300, 200, "UI_login.bmp", "000000", 0.95, 2, intX, intY) = -1

Delay 100

End Sub


Function IsAltsWorld()

Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()
//MessageBox SizeX
//MessageBox Lib.CC.ReadBlock(0, 0, 99)
If SizeX = 99 Then 
	If Lib.CC.ReadBlock(0, 0, 99) = 401 Then 
		IsAltsWorld = True
		//MessageBox "AltsWorld"
	Else	
		IsAltsWorld = False
	End If
Else 
	IsAltsWorld = False
Delay 500
End If

End Function


Function TP_Boss
Dim count
count = 0 
Call Lib.CC.BindClick(20, 20)

Do
Delay 100
Loop While dm.FindPic(0, 0, 1280, 960, "Profile.bmp", "000000", 0.95, 2, intX, intY) <> 0

Call Lib.CC.BindClick(830, 455)

Do
count = count + 1 
Delay 100
If count = 30 Then 
 	TP_Boss = "Master not online"
 	Call Lib.CC.BindClick( 640, 880) 
	Goto Skip
End If
Loop While dm.FindPic(0, 0, 1280, 960, "Entropy_0.bmp", "000000", 0.95, 2, intX, intY) = -1 

Call Lib.CC.BindClick(1080, 275)

Delay 500

Call Lib.CC.BindClick(640, 160)
Delay 500
TP_Boss = "Master online"

Rem Skip
End Function


Function CheckQuest()
Dim quest_type, quest_target, quest_number
quest_type   = -1
quest_target = ""
quest_number = ""

Type_Array = Array("Mine", "Craft")
Target_Array = Array("Nest", "String", "Mud", "Soil", "Bouncy_Block", "Glue", "Cloth", "Sandstone", "Sandy_Block", "Sandy_Brick", "Pink_Coral", "Mountain_Boulder", "Ice_Boulder", "Blue_Flower", "Water", "Ice", "Lily_Pad", "Oil", "Cave_Wall", "Lava", "Bones" )
Number_Array = Array( 10, 12, 14, 16, 18, 3, 4, 5, 6, 7, 8, 9)


Delay 500
Call Lib.CC.BindClick( 20, 20)
Delay 300
Call Lib.CC.BindClick( 470, 315)
Delay 200

Do
	Delay 200
Loop While dm.FindPic(200, 0, 800, 200, "YOUR_QUESTS.bmp", "000000", 0.95, 2, intX, intY) = -1


Dim index, quest

For index = 0 To 2
	
quest = CheckQuestXX(index)
TracePrint quest
If quest <> "" Then 
	CheckQuest = CheckQuest & " " & quest	
End If

Next

Delay 500
Call Lib.CC.BindClick( 640, 880)    //Click Done
Delay 100

If CheckQuest = "" Then 
	CheckQuest = "Invalid Quest"
End If


End Function

Function CheckQuestXX(index)
	
Dim x0, x1, y0, y1, dy
dy = 46
x0 = 150
x1 = 550
y0 = 256 + index * dy
y1 = 296 + index * dy


Dim path, result
path = "D:\GameData\CC\TextRecognition\"

Call dm.Capture(x0, y0, x1, y1, path & Kernel_Number & ".bmp")
Do Until dm.IsFileExist(path & Kernel_Number & ".txt")
	Delay 100
Loop

result = dm.ReadFile(path & Kernel_Number & ".txt")
Call dm.DeleteFile(path & Kernel_Number & ".txt")

If Left(result, 2) <> "Mi" And Left(result, 2) <> "Cr" Then 
	result = ""
End If

CheckQuestXX = result

End Function


Function CheckQuestX(index)

Type_Array = Array("Mine", "Craft")
Target_Array = Array("Nest", "String", "Mud", "Soil", "Bouncy_Block", "Glue", "Cloth", "Sandstone", "Sandy_Block", "Sandy_Brick", "Pink_Coral", "Mountain_Boulder", "Ice_Boulder", "Blue_Flower", "Water", "Ice", "Lily_Pad", "Oil", "Cave_Wall", "Lava", "Bones" )
Number_Array = Array( 10, 12, 14, 16, 18, 3, 4, 5, 6, 7, 8, 9)



Dim x0, x1, y0, y1, dy
dy = 46
x0 = 150
x1 = 550
y0 = 256 + index * dy
y1 = 296 + index * dy


quest_type = dm.FindPic(x0, y0, x1, y1, "Mine.bmp|Craft.bmp", "000000", 0.95, 2, intX, intY)
Delay 50


For Each target In Target_Array
	If dm.FindPic(x0, y0, x1, y1, target & ".bmp", "000000", 0.95, 2, intX, intY) = 0 Then 
		//MessageBox target
		quest_target = target
		Exit For
	End If
Next

Delay 50
For Each number In Number_Array
	If dm.FindPic(x0, y0, x1, y1, "Number_" & number & ".bmp", "000000", 0.95, 2, intX, intY) = 0 Then 
		quest_number = number
		Exit For
	End If
Next



If quest_type = - 1  Or quest_target = ""  Or quest_number = ""  Then 
	CheckQuestX = ""
Else 
	CheckQuestX = Type_Array(quest_type)  & "|" & quest_target & "|" & quest_number
End If
	
	
End Function


Function ExecuteQuest(quest)
Dim quest_array, score
quest_array = Split(quest, " ")
score = 0

For Each q In quest_array

score = score + ExecuteQuestX(q)
Delay 50
	
Next

If score > 0 Then 
	
End If


End Function


Function ExecuteQuestX(quest)
Dim craft_position, quest_array, quest_type, quest_target, quest_number
quest_array = Split(quest, "|")

quest_type =   quest_array(0)
quest_number = quest_array(1)
quest_target = quest_array(2)

Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()
Call Lib.CC.SetCamera(0, 45)


Dim result
Select Case quest_type
	Case "Mine"
		result = Lib.CM.Mine(quest_target,quest_number)
	Case "Craft"
		result Lib.CM.Craft(quest_target,quest_number)
End Select

ExecuteQuestX = results

Call TP_start

End Function



Function EvaluateQuest()
Dim count
count = 0
Do
	count = count + 1
	Delay 200
	
Loop While	dm.FindPic(0, 0, 200, 800, "Finish.bmp", "000000", 0.95, 2, intX, intY) = -1 And count < 10

If count > 8 Then 
	EvaluateQuest = "Quest not completed"
	Error_String = Error_String & SeqName & SeqIndex &  " : Not completed"   & Chr(13)
Else 
	EvaluateQuest = "Quest completed"
End If


End Function

Function Craft(target, number)
TracePrint target

Select Case target
Case "Nest"
	Call Lib.CC.TP(6, 39, 99)
	craft_position = 0
	
Case "String"
	Call Lib.CC.TP(7,39, 99)
	craft_position = 0
Case "Mud"
	Call Lib.CC.TP(7,39, 99)
	craft_position = 1
Case "Soil"
	Call Lib.CC.TP(7,39, 99)
	craft_position = 2

Case "Bouncy_Block"
	Call Lib.CC.TP(8, 39, 99)
	craft_position = 0
Case "Glue"
	Call Lib.CC.TP(8, 39, 99)
	craft_position = 1
Case "Cloth"
	Call Lib.CC.TP(8, 39, 99)
	craft_position = 2
	
Case "Sandstone"
	Call Lib.CC.TP(9, 39, 99)
	craft_position = 0
Case "Sandy_Block"
	Call Lib.CC.TP(9, 39, 99)
	craft_position = 1
Case "Sandy_Brick"
	Call Lib.CC.TP(9, 39, 99)
	craft_position = 2
End Select
	
Delay 200
	
dm.KeyPressChar "W" 
	
Delay 3000
	
	///Do     //check smith
	///Delay 200
	///Loop While FindAndClick(handle, "Smith") <> 0
Call Lib.CC.BindClick(640, 300)
	
	///Do      //check anvil
	///Delay 200
	///Loop While dm.FindPic(150, 300, 550, 350,  "Anvil.bmp", "000000", 0.95, 2, intX, intY) = 0 Then
	
Delay 2000
Select Case craft_position
	Case 0
	Case 1
		Call Lib.CC.BindClick( 430, 390)
	Case 2
		Call Lib.CC.BindClick( 430, 450)
End Select
Delay 100

	
For number

Call Lib.CC.BindClick( 430, 494)
Delay Time_Craft_Click
	
Next
	
	
Call Lib.CC.BindClick( 603, 240)

End Function


Function Mine(target, number)

Dim ReapArray, target_index
ReapArray = Array(138, 143, 220, 235, 147, 223, 127, 228, 230, 231, 240, 372)

TracePrint target

Select Case target 
Case "Water"
	target_index = 0
	
Case "Blue_Flower"
	target_index = 1

Case "Mountain_Boulder"
	target_index = 2
	
Case "Ice_Boulder"
	target_index = 3
	
Case "Ice"
	target_index = 4
	
Case "Pink_Coral"
	target_index = 5
	
Case "Nest"
	target_index = 6
	
Case "Lily_Pad"	
	target_index = 7
	
Case "Oil"
	target_index = 8
	
Case "Cave_Wall"
	target_index = 9
	
Case "Lava"
	target_index = 10
	
Case "Bones"
	target_index = 11

End Select

TracePrint target_index
TracePrint ReapArray(target_index)

center_x = 15 + target_index * 4


Call Lib.CC.GetWorldSize()


If Lib.CC.DetectPpl(center_x - 1.5, center_x + 1.5, 0, SizeY, 0, SizeZ) = 1  Then 
	Mine = 1
	Exit Function
End If
//Do
//	Delay 200
//Loop While Lib.CC.DetectPpl( center_x - 1.5, center_x + 1.5, 0, SizeY,  0, SizeZ )


TracePrint AltsRoom_ReapLine_Bind( center_x, ReapArray, number)
//Call Lib.CC.ReplaceBlockAll(ReapArray(target_index), 705)
//Call Lib.CM.ReapBlockCount(705, "down", number)
//Call Lib.CC.ReplaceBlockAll(705, ReapArray(target_index))


Mine = 0
End Function

Function SendInfo(info, info_type)

Dim prefix, colorL
prefix = "[" & Date & " " & Time & "]"	
colorL = Array("000000", "FF0000", "0000FF", "FF7F00")

Call dm.WriteFile( "AltsQuest.log",  prefix & info & vbCrLf) 
Call dm.FoobarPrintText(foobar, info, colorL(info_type))
	
	
End Function

Function ReapBlockCount(Block_Want, num)
//2017-4-22 15:26:19
//MessageBox num
Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()



Dim block_ID_want, block_type_want
block_ID_want   = Block_Want Mod 256
block_type_want = Block_Want \ 256



Dim my_array(2), my_range
my_array(0) = CStr(Hex(SubAddress + 20))
my_array(1) = CStr(Hex(SubAddress + SizeX*SizeY*SizeZ*20))
my_range = Join(my_array, "-")

Dim target_ads_arr, addresses
target_ads_arr = dm.FindIntEx(handle, my_range, block_ID_want, block_ID_want, 2, 20, 0, 0) 
addresses = Split(target_ads_arr, "|")


Dim array_count, index, temp
array_count = UBound(addresses)


//If Direction = "up" Then 
//For index = 0 To Round(array_count / 2 - 0.1)
//	
//	temp = addresses(index)
//	addresses(index) = addresses(array_count - index)
//	addresses(array_count - index) = temp
//	
//Next
//End If

Dim block_count
block_count = 0

For Each I In addresses
	Dim block_ID, block_type
	block_ID = Lib.CC.AdrToPos(I, 0)
	block_type = Lib.CC.AdrToPos(I, 1) Mod 8
	If block_type = block_type_want Then 
		block_count = block_count + 1
		If block_count - num > 0 Then 
			ReapBlockCount = 0
			Exit Function
		End If
		
		bx = Lib.CC.AdrToPos(I, 2)
		by = Lib.CC.AdrToPos(I, 4)
		bz = Lib.CC.AdrToPos(I, 6)
		Call Lib.CC.MinePreciseEx(bx, by, bz, block_want)
		
			
	End If
Next






End Function

Function AltsRoom_ReapLine_Bind(Central_X, ReapArray, ReapTotal)
Dim reap_count, plat_z
reap_count = 0
plat_z = 99
Call Lib.CC.TP(Central_X, 39, plat_z)


For TarY = 40 To 5 Step  -1
For TarZ = 97 To 99
For TarX = Central_X - 1 To Central_X + 1
	
	If AltsRoom_Grab_Bind(TarX,TarY,TarZ, ReapArray) = 0 Then
		reap_count = reap_count + 1
		//MessageBox reap_count
		Delay 200
	End If
	If reap_count - ReapTotal = 0 Then 
		AltsRoom_ReapLine_Bind = 0
		Exit Function
	End If
	
Next
Next
Next

End Function


Function AltsRoom_Grab_Bind(TarX, TarY, TarZ, ReapArray)

ReapArray = Array(138, 143, 220, 235, 147, 223, 127, 228, 230, 231, 240, 372)

If Lib.CC.InArray(Lib.CC.ReadBlock(TarX, TarY, TarZ), ReapArray)  Then 
	

	Dim click_x, click_y, plat_z
	click_x = 640
	click_y = 480 + (TarZ - 100) * 60
	plat_z = 99
	BlockCount = BlockCount + 1
	Call Lib.CC.TP(TarX, TarY + 1, plat_z)
	Delay 200
	Call Lib.CC.BindClick( click_x, click_y)
	
	Do
		Delay 100
	Loop While Lib.CC.InArray(Lib.CC.ReadBlock(TarX, TarY, TarZ), ReapArray) 
	AltsRoom_Grab_Bind = 0
	
Else 
	AltsRoom_Grab_Bind = 1
End If
TracePrint AltsRoom_Grab_Bind

End Function

