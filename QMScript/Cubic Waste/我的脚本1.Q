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
MacroID=0840aeeb-5310-421c-a5bb-e90c114f148e
Description=ÎÒµÄ½Å±¾1
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
Set dm = createobject("dm.dmsoft")


handle = Plugin.Window.MousePoint
dm_ret = dm.BindWindow(handle,"normal","normal","normal",0)
MessageBox dm_ret
