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
MacroID=8f4a2509-bafb-4e4d-bef8-ead72fcf54c8
Description=Ë²ÒÆ
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
dm_ret1 = dm.WriteFloat(handle,"[[[<Cubic.exe>+281D68]+44]+720]+24",83.0)
dm_ret2 = dm.WriteFloat(handle,"[[[<Cubic.exe>+281D68]+44]+720]+28",14.0)
MessageBox dm_ret1
