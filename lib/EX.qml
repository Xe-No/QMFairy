[General]
SyntaxVersion=2
MacroID=aa2c4146-68a3-448d-a594-0c928fbaa002
[Comment]

[Script]
Function InArray(Element, Target_Array)
Dim index

For Each index In Target_Array
	If index - Element = 0 Then 
		InArray = True
		Exit For
		Else 
		InArray = False
	End If
Next

End Function

Function AdrToPos(Address, Off)
	Dim array(2), string
	array(0) = Address
	array(1) = CStr(Off)
	string = Join(array,"+")
	AdrToPos = dm.ReadInt(handle, string, 2)
End Function