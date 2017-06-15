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
MacroID=cb130354-ff04-4715-943c-2c5f4ef0f0f9
Description=∞Û∂®≤‚ ‘
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
Set dm = createobject("dm.dmsoft")
handle = Plugin.Window.MousePoint

dm_ret = dm.BindWindow(handle, "normal", "windows", "dx", 0)
MessageBox dm_ret
dm.KeyDownChar "W"
Delay 1000
dm.KeyUpChar "W"
