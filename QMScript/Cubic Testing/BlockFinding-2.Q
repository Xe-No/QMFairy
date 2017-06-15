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
MacroID=6fff8272-88e1-4ae4-a84d-af10e553cfbb
Description=*采集宝石【界面】【领域级】【内存】
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
	
        If Lib.CC.ReadBlock(bx, by, bz) - Block = 0 Then 
        Else
            Goto Skip
        End If
	
 		Lib.CC.SetCamera 0, 89

        Lib.CC.WriteBlock bx, by, bz-1, 401
        For dz = 30 To bz - 2
        For dx = bx - 2 To bx + 2
        For dy = by - 2 To by + 2
            Lib.CC.WriteBlock dx, dy, dz, 0
        Next
		Next
		Next
		
        Lib.CC.WriteBlock bx, by-1, bz-2, 0
        Lib.CC.TP bx, by, bz - 2
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



