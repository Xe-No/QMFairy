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
MacroID=76a77ca0-6fdc-4a0a-89ce-428189f90580
Description=采集宝石【领域级】【内存】【半自动】
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



GetCursorPos MX, MY
Array_Rect =Split( 	Plugin.Window.GetClientRect(handle)	, "|") 
//下面这句将字符串转换成数值   
L = Clng(Array_Rect(0)): T = Clng(Array_Rect(1))   
R = Clng(Array_Rect(2)) : B = Clng(Array_Rect(3))

bomb_x = mx - L
bomb_y = my - T

Block_Count = 0

For Each Block In Reap_Array
    target_ads_arr = Lib.CC.FindBlockEx(Block)
    addresses = Split(target_ads_arr, "|")


    For Each I In addresses
        Dim block_ID, block_type, bx, by, bz, dx, dy, dz
        block_ID = Lib.CC.AdrToPos(I,0)
        block_type = Lib.CC.AdrToPos(I, 1) Mod 8
        BlockCount = BlockCount + 1
        bx = Lib.CC.AdrToPos(I, 2)
        by = Lib.CC.AdrToPos(I, 4)
        bz = Lib.CC.AdrToPos(I, 6)
		
		
        If Lib.CC.ReadBlock(bx, by, bz) = Block  Then 
        Else
            Goto Skip
        End If
	
 		Lib.CC.SetCamera 0, 89
		
		//设置爆炸点
		
		Do
			bz = bz - 1
		Loop While Lib.CC.InArray(Lib.CC.ReadBlock(bx, by, bz - 1), Reap_Array)
        
        //清空爆炸点附近方块
        
        For dz = -10 To 0 
        For dx = - 2 To + 2
        For dy = - 2 To + 2
        	If (dx = 0) And (dy = 0) And (dz = 0) Then 
        	Else
        		Lib.CC.WriteBlock bx + dx, by + dy, bz + dz, 0
        	End If
            	
            	
        Next
		Next
		Next
		
		Lib.CC.WriteBlock bx, by-1, bz  , 401
        Lib.CC.WriteBlock bx, by-1, bz-1, 0
        Lib.CC.TP bx, by - 1, bz - 1
        
        If Lib.CC.ReadBlock(bx, by, bz) <> 0 Then 
        	Grab 
      		Delay 1000
      		Lib.CC.TP bx, by - 1, bz - 1
        End If
        
        Boom 
        Delay 1000
        Lib.CC.TP bx + 2.3, by + 2.3 , bz - 1
        dm.WaitKey 115, 0
        
        
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
        
        
        
		
        Block_Count = Block_Count + 1
        Rem Skip
    Next
Next

MessageBox BlockCount





Sub OnScriptExit
   
	
End Sub


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
