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
MacroID=10e4fd03-2de8-44b7-a9fc-4c102d73f2e1
Description=我的脚本1
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
Const ForReading = 1 : ForWriting = 2
 Dim fso, osu


Set fso = CreateObject("Scripting.FileSystemObject")
Set osu = fso.OpenTextFile("E:\Program Files\按键精灵9A\QMScript\OSU\Various Artists - Square Jump Practice Maps (Jemmmmy) [BPM149 Distorted Reality Holy Crap!!That's Square jump!! AR8].osu", ForReading)


Do
	
Loop While osu.ReadLine <> "[HitObjects]"


MessageBox osu.ReadLine
