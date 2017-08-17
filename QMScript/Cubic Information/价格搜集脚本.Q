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
MacroID=aefba036-07ef-4fe1-98d7-f56f5da0d917
Description=价格搜集脚本
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
【功能说明】
用于在商场内收集贩卖机的价格信息。

【使用说明】
在商场内启动脚本即可。

[Script]
//物价探测脚本

Call Lib.CC.Initailize()
CAll dm.BindWindow(handle, "dx3", "dx2", "dx", 0)
path = "D:\GameData\CC\Infomation\"'大漠全局路径设置


target_ads_arr = Lib.CC.FindBlock(769)
target_ads_arr = Split(target_ads_arr, "|")

For Each address In target_ads_arr

Call CheckPrice(address)

Next




Sub CheckPrice(address)

bx = Lib.CC.AdrToPos(address, 2)
by = Lib.CC.AdrToPos(address, 4)
bz = Lib.CC.AdrToPos(address, 6)

If Lib.CC.DetectEntity(bx - 0.1, bx + 0.1, by - 0.1, by + 0.1, bz - 1 - 0.1, bz - 1 + 0.1) = 0 Then 
	Exit Sub
End If

Call Lib.CC.TP(bx,by,bz)
Delay 1000


//TracePrint dm.FindPic(296,0,1025,727, path & "Use_Vend.bmp", "000000", 0.9, 0, intX, intY) = - 1 


Call Lib.CC.CubicClick(handle, 640, 300)

Do
Delay 100
TracePrint dm.GetColor(600, 540) = "ffffff"

Loop Until dm.GetColor(600, 540) = "ffffff"


ScreenShot
Delay 500

Call Lib.CC.CubicClick(handle, 708,552)

End Sub


Sub ScreenShot
Dim path,temp
temp = CStr(Now)
temp = Replace(temp, ":", "+")
temp = Replace(temp, "/", "-" )
path = "D:\GameData\CC\Infomation\" & temp & ".bmp"
TracePrint path
Call dm.Capture(421, 438, 837, 498, path)
	
End Sub
