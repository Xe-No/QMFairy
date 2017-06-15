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
MacroID=4a10bc2f-47ed-43c2-a09f-0eb350582741
Description=野外采集
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
//---------------参数设置区域

//点击间隔(ms)
dTime = 200
//stuck是否提示(TRUE or FALSE)
tip = TRUE
//超过多少次就提示(50~100 recommended)
CheckNum = 50
//位置反馈强度 (0.6~1.2 recommended)
A = 0.6

//---------------参数设置结束

Call Lib.CC.Initailize()
Randomize

tCount = 0
cCount = 0
While 0 = 0
	
	Select Case cCount
		Case cCount mod 4000 < 1000
			TarX = 15
			TarY = 15
		Case cCount mod 4000 < 2000
			TarX = 45
			TarY = 15
		Case cCount mod 4000 < 3000
			TarX = 45
			TarY = 45
		Case cCount mod 4000 < 4000
			TarX = 15
			TarY = 45
	End Select
	Call Lib.CC.GetCharPos()
	
	If CharZ > 78.5 And Tip Then 
		tCount = tCount + 1
	End If
	If tCount > CheckNum Then 
		MessageBox ">.<"&Chr(13)&"Untrap and press F4"
		dm.waitkey 115, 0
		tCount = 0
	End If
	Call Plugin.Bkgnd.LeftClick(handle,int(Rnd()*160+560+Bias2(TarX, CharX)),int(Rnd()*160+400+Bias2(TarY, CharY)))
	Delay dTime
	cCount = cCount + 1
Wend


Sub OnScriptExit
	MessageBox "_(:з」∠)"
End Sub

Function Bias(a)
	Bias = -(a-15)*(a-45)*Sgn(a-30)/225*80
End Function

Function Bias2(Tar, Char)
	Bias2 = A*(Tar-Char)^3/(15^3)
End Function
