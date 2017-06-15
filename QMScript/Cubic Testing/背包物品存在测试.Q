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
MacroID=d5fab30b-a491-45d5-92ec-ef200c8cc110
Description=背包物品存在测试
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
//背包物品存在测试


Call Lib.CC.Initailize()
dm_ret = dm.BindWindow(handle, "dx2", "dx2", "dx", 0)

color_chain = ""


For y = 0 To 3
For x = 0 To 7
//  内存方法
//	btype = GetInvData(x, y, 0, 2)
//	ID = GetInvData(x, y, 2, 1)
//	quantity = GetInvData(x, y, 4, 1)
//	
//	
//	MessageBox btype & " " & ID & " " & quantity


//图色方法
	color = GetInvState(x,y)
	
	color_chain = color_chain & " " & color

Next
	color_chain = color_chain & chr(13)
Next

MessageBox color_chain






Function GetInvData(inv_x, inv_y, inv_bias, method)
//Inv的长度为64字节
// 0 1 物品类别
// 2 3 物品ID
// 4 5 物品数量


glo_bias = Hex(((inv_y * 8) + inv_x - 1) * 64 + inv_bias)

GetInvData = dm.ReadInt(handle, "[[[<Cubic.exe>+002EB8C8]+2E80]+8]+" & glo_bias, method)

End Function

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
