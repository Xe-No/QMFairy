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
MacroID=d020eae0-5e0e-41e6-9ef8-3828ff3b04fe
Description=背包栏行数测试
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
//背包栏行数测试

Call Lib.CC.Initailize()


Call Lib.CC.SetCamera(0, 89)

Call Lib.CC.GetCameraFocus()
Call Lib.CC.GetCharPos()

MessageBox round( ((CamY - CharY) - 0.185) / 0.325  )
