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
MacroID=7c1a57e5-3a5a-4bfe-9f2c-3c7db25ce89f
Description=alts quest new 2
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
//小号任务状态写入测试

UserVar Kernel_Number = 1 "核心编号"
UserVar Kernel_Max = 4 "核心总数"


Call Lib.CC.Initailize()
Call dm.SetWindowText(hwnd, "Kernel: " & Kernel_Number & "/" & Kernel_Max ) 
IsBind = dm.BindWindow(handle, "dx2", "dx2", "dx", 0)
Delay 500
Dm.SetPath "C:\Users\Administrator\Documents\DmRes"'大漠全局路径设置
dm.WriteFile  "ScriptLog\" &  "Alts.txt",   "[" & Date & "]" & "Start Log" & vbCrLf


//初始化窗口
fooX1 = 100
fooY1 = 400
foobar = dm.CreateFoobarCustom(handle, fooX1, fooY1, "UI2.bmp", "FF00FF", 1.0)
////////////////////
Call Lib.CM.SendInfo("Script Initialized", 1)

If IsBind = 1 Then 
	TracePrint IsBind
	Call Lib.CM.SendInfo("Window Binded", 1)
End If
	
Dim index	
acc_index = Kernel_Number




Do
Call ActivateAccount(acc_index)
acc_index = acc_index + 1
TracePrint acc_index
Loop



Function ActivateAccount(index)

path = "C:\Users\Administrator\Documents\DmRes\AltsState.log"


incar = Lib.文件.读取指定行文本内容(path, index)
If incar = "" Then 
	ExitScript
End If

incar = Split(incar, "|")
alt_name = incar(0)
alt_password = incar(1)


If CheckAccount(alt_name) Then 
	
	result = Lib.CM.ActivateQuest(alt_name, alt_password)
	TracePrint result
	
End If





End Function

Function CheckAccount(alt_name)

Dim path2, fso, f
path2 = "C:\Users\Administrator\Documents\DmRes\AltsComplete.log"

Set fso = CreateObject("Scripting.FileSystemObject")
Set f = fso.OpenTextFile(path2, 1)

Dim alt_list
alt_list = Split(f.ReadAll,vbCrLf)

If Lib.CC.InArray(alt_name, alt_list) Then 
	CheckAccount = False
Else 
	CheckAccount = True
	Set f = fso.OpenTextFile(path2, 8, True)
	f.WriteLine alt_name
End If
f.close
	
End Function
