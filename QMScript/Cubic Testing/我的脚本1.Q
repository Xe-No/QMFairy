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
MacroID=8f4b387f-59bd-4899-89b8-66d383da6b5b
Description=特殊寻找方块测试
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
//特殊寻找方块测试

Call Lib.CC.Initailize()

block_want = 633

Call Lib.CC.GetSubAddress()
Call Lib.CC.GetWorldSize()

Dim block_ID_want, block_type_want
block_ID_want   = Block_Want Mod 256
block_type_want = Block_Want \ 256

Dim my_array(2), my_range
my_array(0) = CStr(Hex(SubAddress + 20 + 1))
my_array(1) = CStr(Hex(SubAddress + SizeX*SizeY*SizeZ*20 + 1))
my_range = Join(my_array, "-")

Dim target_ads_arr, addresses, Final
target_ads_arr = ""
For index = 0 To 7
target_ads_arr = target_ads_arr &"|"& dm.FindIntEx(handle, my_range, block_type_want + 16 * index, block_type_want + 16 * index, 2, 20, 0, 0) 
Next
target_ads_arr = Right(target_ads_arr, Len(target_ads_arr)-1)
addresses = Split(target_ads_arr, "|")
Final = ""
For Each address In addresses
	address = Hex(Lib.算法.十六进制转十进制(address) - 1)
	Final = Final &"|"& address 
Next
Final = Right(Final, Len(Final)-1)


MessageBox dm.FindIntEx(handle, Final, block_ID_want, block_ID_want, 2, 20, 0, 0)

