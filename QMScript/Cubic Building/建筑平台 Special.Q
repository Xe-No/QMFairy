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
MacroID=4b4ac69a-db87-4c30-8f93-7c4f6fc9528e
Description=建筑平台 Special
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
v2.1 支持撤销
v2.0 追加更新

[Script]
UserVar Z_Bias = 1 "偏移 "

Call Lib.CC.Initailize()
Call Lib.CC.GetWorldSize()
Call Lib.CC.GetCharPosInt()



If CharZ - SizeZ < -1 Then
    For i = 0 To SizeX - 1
        For j = 0 To SizeY - 1
            If Lib.CC.ReadBlock(i, j, CharZ+Z_Bias) = 0 Then
                Call Lib.CC.WriteBlock(i,j,Round(CharZ + Z_Bias),140)
            End If
        Next
    Next
End If

dm.WaitKey 115,0 




Sub OnScriptExit
    If CharZ - SizeZ < -1 Then
        For i = 0 To SizeX - 1
            For j = 0 To SizeY - 1
                If Lib.CC.ReadBlock(i, j, CharZ+Z_Bias) = 140 Then
                    Call Lib.CC.WriteBlock(i, j, Round(CharZ + Z_Bias), 0)
                End If
            Next
        Next
    End If

End Sub
