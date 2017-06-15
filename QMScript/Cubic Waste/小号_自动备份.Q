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
MacroID=28764077-846c-4603-bc81-5ae1dd21497d
Description=小号_自动备份
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
handle = Plugin.Window.MousePoint


AccArray = Array("Syner1", "Syner5", "Syner8","Syner9","buluo2","buluo3","buluo4")//用户名序列，加引号，用逗号隔开
PswArray = "xeno"//密码序列，处理方法同上
Count = 7                       //数量

For i = 0 To Count-1
	Rem Wait1
		Kk = WaitKey()
		If Kk = 115 Then 
			Call Plugin.Bkgnd.LeftClick(handle, 763, 618)
			Delay 50
			SayString AccArray(i)
			Delay 50
			Call Plugin.Bkgnd.LeftClick(handle, 763, 671)
			Delay 50
			SayString PswArray
			Call Plugin.Bkgnd.LeftClick(handle, 640, 777)
		Else 
			Goto Wait1
		End If
		
	Rem Wait2
		Kk = WaitKey()
		If Kk = 115 Then
			Call Plugin.Bkgnd.LeftClick(handle, 20, 20)
			Delay 500
			Call Plugin.Bkgnd.LeftClick(handle, 1010, 720)
		Else 
			Goto Wait2
		End If	
Next
