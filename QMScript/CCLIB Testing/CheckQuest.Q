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
MacroID=cb76095f-ed59-44a4-a8c3-3547aab97b7c
Description=CheckQuest
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
Call Lib.CC.Initailize()

//result = dm.FindString(handle,"00000000-FFFFFFFF","Craft ",0)
result = dm.FindString(handle,"00000000-FFFFFFFF","Your Daily Quest is to",0)
//result = dm.FindString(handle,"00000000-FFFFFFFF","A New Quest",0)
if len(result) = 0 then
     MessageBox "�Ҳ���"
     EndScript
End If

MessageBox result
result = split(result, "|")

count = ubound(result) + 1
For i = 0 To count-1 
MessageString = MessageString & Chr(13) &  dm.ReadString(handle, result(i), 0, 70)
Next
MessageBox MessageString


Function SubtractSet(minor, major)

For Each minor_element In minor
	major = Filter(major, minor_element,False)
Next
SubtractSet=major
End Function