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
MacroID=a254418b-cd36-400f-a924-04e019369073
Description=采集宝石【领域级】【内存】【全自动】
Enable=0
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=1
QUI=Form1
[Relative]
SetupOCXFile=
[Comment]

[Script]
Reap_Array = Array(651,652,653)
//Reap_Array = Array(371)


Set dm = createobject("dm.dmsoft")

Dim MyArray(1), Addresses
 
Call Lib.CC.Initailize()
Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()
Call Lib.CC.DMBind(handle)


//Call CollectItem()
//
//
//EndScript
//

Sub OnScriptExit()
    dm_ret = dm.UnBindWindow() 
End Sub

Block_Count = 0
Item_Count = 0
boom_x = 0
boom_y = 0
boom_z = 0

For Each Block In Reap_Array
    target_ads_arr = Lib.CC.FindBlock(Block)
    addresses = Split(target_ads_arr, "|")


    For Each I In addresses
        Dim block_ID, block_type, bx, by, bz, dx, dy, dz
        BlockCount = BlockCount + 1
        bx = Lib.CC.AdrToPos(I, 2)
        by = Lib.CC.AdrToPos(I, 4)
        bz = Lib.CC.AdrToPos(I, 6)
		
		
        If Lib.CC.ReadBlock(bx, by, bz) = Block  Then 
        Else
            Goto Skip
        End If
		
		If Abs(bx-boom_x) + Abs(by_boom_y) < 5  Then 
            Goto Skip
        End If
        
 		Lib.CC.SetCamera 0, 89
		
		//设置爆炸点
		
		Dim counter, sum_x, sum_y, sum_z
		couneter = 0
		sum_x = 0
		sum_y = 0
		sum_z = 0
		
		For dx = 0 To 4
		For dy = - 2  To 2
		For dz = - 1  To 3
			If Lib.CC.InArray(Lib.CC.ReadBlock(bx + dx, by + dy, bz + dz), Reap_Array) Then 
				counter = counter + 1
				sum_x = sum_x + dx
				sum_y = sum_y + dy
				sum_z = sum_z + dz
			End If	
		Next
		Next
		Next
		
		If counter < 3 Then 
			Goto Skip
		End If
		
		
		bx = bx + round(sum_x / counter)
		by = by + round(sum_y / counter)
		bz = bz + round(sum_z / counter)
		
		Do
			bz = bz + 1
		Loop While Lib.CC.InArray(Lib.CC.ReadBlock(bx, by, bz), Reap_Array)
        
        //清空爆炸点附近方块
        
        For dz = -10 To -1 
        For dx = - 2 To + 2
        For dy = - 2 To + 2
        	If (dx = 0) And (dy = 0) And (dz = 0) Then 
        	Else
        		Lib.CC.WriteBlock bx + dx, by + dy, bz + dz, 0
        	End If
            	
            	
        Next
		Next
		Next
		

        Lib.CC.TP bx, by - 1, bz - 1
        TracePrint Lib.CC.ReadBlock(bx, by, bz)
        If Lib.CC.ReadBlock(bx, by, bz) <> 0 Then 
        	
        	Grab 
      		Delay 1000
      		Lib.CC.TP bx, by - 1, bz - 1
      		
        End If
        
        Boom 
        Block_Count = Block_Count + 1
        boom_x = bx
        boom_y = by
        boom_z = bz
     
        Delay 1000
//        Lib.CC.TP bx + 2.3, by + 2.3, bz - 1
//        Delay 100
        
        
        
        
        
//        Lib.CC.WriteBlock bx, by, bz - 5, 650
//        Lib.CC.TP bx, by, bz - 6
//        Delay 200
//	
//        dm.WaitKey 115,0
//        Delay 200
//        Lib.CC.TP bx, by, bz
//        
//        dm.WaitKey 115, 0
//        Delay 200
        
        
        
		
        
        Rem Skip
    Next
Next

Lib.CC.TP boom_x + 3, boom_y + 3, boom_z
dm.KeyPressChar "space"

Delay 5000



CollectItem


MessageBox "Boom: "& Block_Count & vbCrLf & "Item: " & Item_Count








Sub DrawCharPos
    dm_ret = dm.FoobarTextRect(foobar,5,5,100,200)
    dm_ret = dm.FoobarClearText(foobar)
    Call Lib.CC.GetCharPosInt()
    dm_ret = dm.FoobarPrintText(foobar,CharX&"|"&CharY&"|"&CharZ,"FF0000")
    dm_ret = dm.FoobarFillRect(foobar, 4*CharX+1 , 4*CharY + 1, 4*CharX+4 , 4*CharY + 4, "FF0000")
	
End Sub


Function Grab()
	Call Lib.CC.CubicClick(handle,378,935)
	Delay 500
	Call Lib.CC.CubicClick(handle,640,540)
End Function

Function Boom()
	Call Lib.CC.CubicClick(handle,496,930)
	Delay 500
	Call Lib.CC.CubicClick(handle,640,540)
End Function

Function CollectItem()

e_size = Lib.CC.GetEntitySize() 
For index = e_size + 10 To 1 Step -1
Call Lib.CC.GetCharPos()
Call Lib.CC.GetEntityPos(index)
Call Lib.CC.GetEntityID(index)

If 1  < EntityX < SizeX And 1 < EntityY < SizeY And 0 < EntityZ < SizeZ And Lib.CC.InArray(EntityID,Reap_Array) Then 
	Call Lib.CC.WriteBlock(round(EntityX), round(EntityY), round(EntityZ+1), 401)
	Delay 100
	Call Lib.CC.TP(EntityX, EntityY , EntityZ - 1)
	dm.KeyPressChar "A"
	dm.KeyPressChar "D"
	dm.KeyPressChar "A"
	dm.KeyPressChar "D"
	Item_Count = Item_Count + 1
	Delay 150
End If

Next

End Function

Function 坐标排序(数组,返回类型)
    //数字="100,111,112|1,2,3|4,5,6"
    //数组=Split(数字,"|")
    //例子：Msgbox lib.算法.结构数组排序(数组,0)
    //语法格式：数组() = "数字大小=值"
    //数组：NB_PaiXu(0) = "200=A"
    //返回类型：[0全部1最小2最大]
    Dim Int_A,Int_B,Int_Num,Int_Len,A_Str,Int_Temp
    //〈————————————————————初始赋值
    Int_A = 0: Int_Num = UBound(数组)
    For Int_A=0 TO UBound(数组) - 1
        Int_B = Int_A
        For Int_Len=0 To Int_Num - Int_A 
            //〈————————————————根据“=”号分离，进行大小判断
            A_Str = Split(数组(Int_A), ",")
            B_Str = Split(数组(Int_B), ",")
            A_Val = CSng(A_Str(0)) * 10000 + CSng(A_Str(1)) * 100 + CSng(A_Str(2))
            B_Val = CSng(B_Str(0)) * 10000 + CSng(B_Str(1)) * 100 + CSng(B_Str(2))
            If A_Val > B_Val Then
                Int_Temp = 数组(Int_A): 数组(Int_A) = 数组(Int_B): 数组(Int_B) = Int_Temp
            End If 
            Int_B = Int_B + 1
        Next 
    Next 
    If 返回类型 = 0 Then
        //〈——————————————————排序结果
        结构数组排序 = Join(数组)
    ElseIf 返回类型 = 1 Then
        //〈——————————————————返回最小值
        结构数组排序 = 数组(0)
    ElseIf 返回类型 = 2 Then
        //〈——————————————————返回最大值
        结构数组排序 = 数组(Int_Num)
    End If 
End Function

Function 地址转坐标(地址数组)

	
End Function
