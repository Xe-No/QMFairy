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
MacroID=b2a4312d-3c20-42bf-a1ea-e536d8c76c0f
Description=采集特定多种方块【世界级】A
Enable=1
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
//UserVar WorldName = "WorldA" "世界名称"
//WorldName = "WorldA"

UserVar WorldName = DropList{"Eden":"WorldE"|"Tinker":"WorldT"|"Pelago":"WorldP"|"Spyre":"WorldS"|"Aspen":"WorldA"} "世界名称"
UserVar ReapCases=DropList{"自定义":0|"大理石 579,585,586 ":1|"块石 133,220,235":2|"Rubber&Cotton":3}=2 "收获类型"
UserVar ReapString = "127,147,143,220,235,223,228,240,372,466" "目标方块"
Dim block, ReapArray
Select Case ReapCases
	Case 0
		ReapArray = Split(ReapString,",")
	Case 1
		ReapArray = Array(579,585,586)
	Case 2
		ReapArray = Array(133,220,235)
End Select

BlockCount = 0

Collect_Enable = True

BreakPoint = False

Call Lib.CC.Initailize()

//MessageBox Lib.CC.FindBlockEx(621)
//Leave
//EndScript
//
//dm_ret = dm.BindWindowEx(handle, "dx2", "dx.mouse.position.lock.api|dx.mouse.position.lock.message", "dx", "", 0)
Call Lib.CC.DMBind(handle)



Delay 100
Dm.SetPath "C:\Users\Administrator\Documents\DmRes"'大漠全局路径设置

Rem Start
//Hunt 
//EndScript


Randomize

Do

World_Index = Round( Rnd() * 50 ) 

If TPMine(WorldName, World_Index) = 0 Then 
	World_Index = World_Index + 1
Else	
	World_Index = 0
	Goto Skip
End If
JumpForward
WaitLoading

Hunt

Leave
WaitLoading
Delay 1500

Rem Skip

Loop


Function TPMine(WorldName, MineIndex)
Dim MyString, MyArray
MinePos = Lib.文件.读取指定行文本内容("C:\Users\Administrator\Documents\DmRes\" & WorldName & ".txt",MineIndex)
If MinePos = "" Then 
//EndScript
	TPMine = 1
Else 
	MyString = Split(MinePos, ",", - 1 , 1)
	MineX = CSng(MyString(0))
	MineY = CSng(MyString(1))
	MineZ = CSng(MyString(2))
	
	Call Lib.CC.TP(MineX, MineY, MineZ)
	Delay 1000
	TPMine = 0
End If
	
	
End Function


Sub JumpForward

Dim  ty
Call Lib.CC.GetCharPos()

ty = CharY



Delay 200
dm.KeyDownChar "W"
Delay 16
dm.KeyDownChar "Space"
Delay 219
dm.KeyUpChar "Space"
Delay 31
dm.KeyUpChar "W"
Delay 1000

Call Lib.CC.GetCharPos()

If Abs(ty - CharY) < 0.7 Then 
	Goto Skip
End If


End Sub


Sub Hunt
Dim index
Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()
Call Lib.CC.GetEntitySize()





Dim block
For Each block In ReapArray

Call Lib.CC.ReplaceBlockAll(block, 705)

Next

//转化不利的方块
Call Lib.CC.ReplaceBlockAll(218, 138)
Call Lib.CC.ReplaceBlockAll(222, 138)
Call Lib.CC.ReplaceBlockAll(234, 138)
Call Lib.CC.ReplaceBlockAll(240, 138)
Call Lib.CC.ReplaceBlockAll(230, 138)


Call Lib.CC.ReapBlock(705, "down")




Rem SkipHunting

Delay 100
End Sub

Sub Leave

//TracePrint "Ready for leave"
//Delay 500
//Call Lib.CC.CubicClick(handle, 1256, 22)
//
//Call Lib.CM.WaitColor(600,540, "ffffff")
//Delay 500
//TracePrint "Popup Menu"
//Call Lib.CC.CubicClick(handle, 560, 536)

Dim addr,addr_lst,x,y,z
addr_lst = Lib.CC.FindBlock(10)
addr_lst = Split(addr_lst, "|")

For Each addr In addr_lst

x = Lib.CC.AdrToPos(addr, 2)
y = Lib.CC.AdrToPos(addr, 4)
z = Lib.CC.AdrToPos(addr, 6)


If x = 50 And y = 50 Then 
	Call Lib.CC.TPP(x, y + 0.5, z)
	Exit For
End If



	
Next

Delay 500
dm.KeyDownChar "W"
Delay 800
dm.KeyUpChar "W"



TracePrint "Leave"
End Sub


Sub WaitInnerWorld

Do
Delay 1000
Loop Until Lib.CC.GetGameState() = "Realm"

End Sub


Sub WaitOverWorld

Do
Delay 1000
Loop Until Lib.CC.GetGameState() = "Main_World"

End Sub


Function AdrToPos(adr, off)
	Dim Arr(1)
	Arr(0) = adr
	Arr(1) = CStr(off)
	PStr = Join(Arr,"+")
	AdrToPos = dm.ReadInt(handle,PStr,2)
End Function

Sub OnScriptExit
	MessageBox BlockCount
End Sub

Function WaitLoading()
	
Do
	Call Lib.CC.GetCharPos()
	Delay 100
Loop Until CharX = 0

Do
	Call Lib.CC.GetCharPos()
	Delay 100
Loop While CharX = 0



End Function


Function WaitLoadingNew()
Dim count_wln

count_wln = 0

Do
	Delay 200
	count_wln = count_wln + 1
	If count_wln > 50 Then 
		WaitLoadingNew = 1
		Exit Function
	End If
	
Loop Until Plugin.Bkgnd.GetPixelColor(handle, 741, 502) = "FFFFFF"

count_wln = 0

Do
	Delay 50
	count_wln = count_wln + 1
	If count_wln > 50 Then 
		WaitLoadingNew = 2
		Exit Function
	End If
Loop While Plugin.Bkgnd.GetPixelColor(handle, 741, 502) = "FFFFFF"
WaitLoadingNew = 0


End Function
