Sub getCSV()
Application.DisplayAlerts  = False
Application.ScreenUpdating = False
Dim data As Workbook
file = Application.GetOpenFilename(MultiSelect:=True)
For i = LBound(file) To UBound(file)
    Workbooks.Open Filename:=file(i)
    Set data = ActiveWorkbook
    Path = data.Path
    On Error Resume Next
    VBA.MkDir (Path & "\csv")
    With data
        .SaveAs Path & "\csv\" & Replace(data.Name, ".xlsx", ".csv"), xlCSV
        .Close True
    End With
Next i
MsgBox "已轉換了" & (i-1) & "份文件"
Application.ScreenUpdating = True
Application.DisplayAlerts  = True
End Sub
