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
MacroID=776c61d4-eec9-42df-b6b0-dd1bcb060c89
Description=alts quest new 3
Enable=1
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
acc_index = acc_index + Kernel_Max
TracePrint acc_index
Loop



Function ActivateAccount(index)

path = "C:\Users\Administrator\Documents\DmRes\AltsState.log"

incar = Lib.文件.读取指定行文本内容(path, index)
incar = Split(incar, "|")
alt_name = incar(0)
alt_password = incar(1)
alt_time = incar(2)
alt_state = incar(3)

If alt_name = "" Then 
	ExitScript
End If


result = Lib.CM.ActivateQuest(alt_name, alt_password)

TracePrint result


End Function
//Function ActivateQuest(alt_name,alt_password)
//
//	If Lib.CC.GetAccState( alt_name ) = 1 Then 
//		Call Lib.CM.SendInfo(alt_name & " malfunctioned ! >_< Skipping ", 0)
//		Goto Pass
//	End If
//
//	
//	Call Login(alt_name, alt_password)
//	//Call Lib.CM.SendInfo("Loading...", 2)
//	Call Lib.CM.WaitLoading
//	Call Lib.CC.GetSubAddress()
//	
//	Delay 200
//	
//	Call TP_Start()
//	
//	If IsAltsWorld Then 
//		Call Lib.CM.SendInfo("Alts room verified ! >:3", 1)
//	Else 
//		Call Lib.CM.SendInfo("Alts room not verified , attempting to tp Master ", 3)
//		Delay 100
//		Call Lib.CM.SendInfo(      TP_BOSS()        , 1)
//		Delay 1000
//		Call Lib.CM.WaitLoading
//		If IsAltsWorld Then 
//		
//			Call Lib.CM.SendInfo("Alts room verified ! >:3", 1)
//		
//		Else 
//			Call Lib.CM.SendInfo("Alts room still not verified , quest aborted :Q:", 3)
//			Error_String = Error_String & alt_name &  " : Not in Room"   & Chr(13)
//			Goto Before_Logout
//			
//		End If
//	End If
//
//
//
//	If IsAltsWorld Then 
//	dm_ret = dm.FoobarPrintText(foobar, "Alts room verified ! >:3", "FF0000")
//	
//	Else 
//			dm_ret = dm.FoobarPrintText(foobar, "Alts room not verified , quest aborted :Q:", "FF7F00")
//			Error_String = Error_String & alt_name &  " : Not in Room"   & Chr(13)
//			Goto Before_Logout
//			
//	End If
//	
//	Delay Time_Sub
//	Call Lib.CM.SendInfo("Quest checking...", 2)
//	Quest_Checked = CheckQuest()
//	
//	If Quest_Checked = "Invalid Quest" Then 
//		Call Lib.CM.SendInfo("Invalid Quest", 3)
//		dm.WriteFile  "ScriptLog\" & Date & "Alts.txt", alt_name & " : Invalid Quest" & Chr(13)
//		Error_String = Error_String & alt_name & " : Invalid Quest" & Chr(13)
//		Goto Before_Logout
//	Else
//		Call Lib.CM.SendInfo("Quest " & Quest_Checked & " detected ", 0)
//	End If
//	
//	
//	Call ExecuteQuest(Quest_Checked)
//
//	Call Lib.CM.SendInfo(EvaluateQuest, 1)
//	
//	
//	
//	Rem Before_Logout
//	
//	Call Lib.CM.DropItem()
//	
//	Delay 300
//	
//	Call Logout
//	Call Lib.CM.SendInfo(alt_name & " deactivated !", 0)
//	
//	Rem Pass
//	
//Rem PassLogin	
//
//End Function
//
