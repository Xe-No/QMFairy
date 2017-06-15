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
MacroID=143a1f00-b844-420a-8c51-7580ad7efbde
Description=OCR
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
dm_ret = dm.BindWindow(handle,"dx","dx2","dx",0)
dm_ret = dm.UseDict(1)

s = dm.Ocr(0,0,2000,2000,"ffffff-000000",1.0)
MessageBox s
