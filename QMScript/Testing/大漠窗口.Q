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
MacroID=4ecac60f-f0cd-4463-bf72-7129156f86a5
Description=´óÄ®´°¿Ú
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

foobar2 = dm.CreateFoobarRect(handle, 900, 500, 80, 300)
dm_ret = dm.FoobarTextRect(foobar,5,5,100,200)
dm_ret = dm.FoobarPrintText(foobar2,"´óÄ®²âÊÔ","ff0000")
Delay 10000
