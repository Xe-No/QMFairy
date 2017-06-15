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
MacroID=3eb15e42-ca70-47ec-b544-672d01301193
Description=Ë²ÒÆÑ°Ö·
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

dm_ret = dm.WriteFloat(handle, "[<Cubic.exe>+29720c]+2DBB4",0)

FakeX = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC")
result = dm.FindFloatEx(handle, "00000000-ffffffff", FakeX - 0.1, FakeX + 0.1, 4, 1, 1)




Do
dm.KeyDown 65
Delay 500
dm.KeyUp 65
Delay 300
FakeX = dm.ReadFloat(handle, "[<Cubic.exe>+29720c]+2DBBC")
result = dm.FindFloat(handle, result, FakeX - 0.1, FakeX + 0.1)
Loop While len(result) > 100
result = Split(result, "|")


i = 0
Do 
dm_ret = dm.WriteFloat(handle, result(i), 0)
Delay 20
tempX = dm.ReadFloat(handle, result(i))
i = i+1
Loop While tempX <> 0


MessageBox result(i-1)
