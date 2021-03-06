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
MacroID=34cb4e22-ce60-4bfd-9568-22fd853990f5
Description=雷达
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
//探索传送门
Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()

//初始化窗口
WH = Lib.CD.GetWindowWH(handle)



fooX1 = 50
fooY1 = 140 + WH(1) / 4
fooWide = SizeX * 4 + 1
fooHigh = SizeY * 4 + 1

foobar = dm.CreateFoobarRect(handle, fooX1, fooY1, fooWide, fooHigh + 100)
dm_ret = dm.FoobarTextRect(foobar,5,5 + fooHigh,400,50)
Delay 100

Call dm.FoobarDrawLine(foobar, 0, 			0, 0, 			fooHigh, "808080", 0, 1)
Call dm.FoobarDrawLine(foobar, fooWide / 2, 0, fooWide / 2, fooHigh, "808080", 0, 1)
Call dm.FoobarDrawLine(foobar, fooWide - 1, 0, fooWide - 1, fooHigh, "808080", 0, 1)


Call dm.FoobarDrawLine(foobar, 0, 0, 			fooWide, 	0, 				"808080", 0, 1)
Call dm.FoobarDrawLine(foobar, 0, fooHigh / 2,	 fooWide, 	fooHigh / 2, 	"808080", 0, 1)
Call dm.FoobarDrawLine(foobar, 0, fooHigh - 1,	 fooWide, 	fooHigh - 1, 	"808080", 0, 1)

DrawMapSize


//绘制地图代码块-------------------------------

Call PrintCord(653, "FF00FF")	//绿宝石，绿色
Call PrintCord(652, "FF0000")  	//红宝石，红色
Call PrintCord(651, "00FFFF")	//钻石，青色
Call PrintCord(830, "FFFFFF")
Call PrintItemCord("F86F00")
//
//For index = 377 To 388
//	Call PrintCord(index, "ffff00")
//Next
//
//For index = 405 To 416
//	Call PrintCord(index, "ffff00")
//Next
//
//For index = 618 To 629
//	Call PrintCord(index, "ffff00")
//Next
//
//For index = 632 To 643
//	Call PrintCord(index, "ffff00")
//Next
//


// Call ScanEgg

//---------------------------------------------


While 0=0
    DrawCharPos 
    DrawMapSize
    dm_ret = dm.FoobarUpdate(foobar)
    Delay 500
    dm.FoobarClearText(foobar)
Wend

Function PrintCord(block, rgb)

    Dim addr
    addr = Lib.CC.FindBlock(block)
    Block_Count = 0
    addr_list = Split(addr, "|")

    For Each site In addr_list
        bx = Lib.CC.AdrToPos(site, 2)
        by = Lib.CC.AdrToPos(site, 4)
        bz = Lib.CC.AdrToPos(site, 6)
        dm_ret = dm.FoobarFillRect(foobar, 4 * BX + 1, 4 * BY + 1, 4 * BX + 4, 4 * BY + 4, rgb)//标出坐标
        Block_Count = Block_Count + 1
	
    Next

    //MessageBox Block_Count
	
End Function

Function PrintItemCord(rgb)

Lib.CC.GetEntitySize 
TracePrint EntitySize
For index = 0 To EntitySize
	Lib.CC.GetEntityPos index
	Lib.CC.GetEntityID index
	If EntityID = 154 Then
		dm_ret = dm.FoobarFillRect(foobar, 4 * EntityX + 1, 4 * EntityY + 1, 4 * EntityX + 4, 4 * EntityY + 4, rgb)//标出坐标
	End If
	
Next
	
	
End Function




Sub OnScriptExit
    dm_ret = dm.FoobarClose(foobar)
	
End Sub


Sub DrawCharPos
	Dim char_pos
    char = Lib.CD.GetCharPosInt(handle)
    dm_ret = dm.FoobarPrintText(foobar,"人物坐标:" &char(0)&","&char(1)&","&char(2),"FF0000")
    dm_ret = dm.FoobarFillRect(foobar,  4*char(0)+1 , 4*char(1) + 1, 4*char(0)+4 , 4*char(1) + 4, "9C661F") //砖红
	
End Sub

Sub DrawMapSize
    Dim size
    size = Lib.CD.GetMapSize(handle)
    Call dm.FoobarPrintText(foobar, "世界大小:" & size(0) & "," & size(1) & "," & size(2), "FF0000")
End Sub


Function ScanEgg
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
                If index_bound > 1000 Then 
                    Exit Do
                End If
	
            Else 
                Zero_Counter = Zero_Counter + 1
	
            End If


            Index = Index + 1

            If Zero_Counter > 1 Then 
	
                Delay 200
                Exit Do
            End If


        Loop

        Delay 50

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
                    dm_ret = dm.FoobarFillRect(foobar, 4 * EntityX + 1, 4 * EntityY + 1, 4 * EntityX + 4, 4 * EntityY + 4, "FF9c3b")
                    //		dm.WaitKey 115, 0
                    Delay 100
                End If

            End If

        Next

    Next

    TracePrint "Scanned"

    Delay 1000

End Function
