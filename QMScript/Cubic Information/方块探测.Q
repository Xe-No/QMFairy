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
MacroID=d0c356d5-f71c-4e94-9f2a-13f97748ca5c
Description=����̽�⡾�ɰ汾��
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
//����̽��ű�

UserVar bx = 0 "xƫ��"
UserVar by = 0 "yƫ��"
UserVar bz = 0 "zƫ��"


Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()
Call Lib.CC.GetCharPosInt()

ID = Lib.CC.ReadBlock(CharX + bx, CharY + by, CharZ + bz)


MessageBox "�˷���Ϊ��" & ID
