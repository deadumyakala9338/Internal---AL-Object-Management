codeunit 99100 "Export Japanese Object Data"
{
    trigger OnRun()
    var
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
        OutStream: OutStream;
        InStream: Instream;
        SheetName: Label 'AllObjects';
    begin
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.ClearNewRow();

        ExportTableObjectData();
        TempExcelBuffer.CreateNewBook('Tables');
        TempExcelBuffer.WriteSheet('Tables', '', '');
        //CreateExcelSheet('TJP-Table', true);
        ExportPageObjectData();
        TempExcelBuffer.CreateNewBook('Pages');
        TempExcelBuffer.WriteSheet('Pages', '', '');
        //CreateExcelSheet('TJP-Page', false);
        //CreateExcelBook();
        TempExcelBuffer.CloseBook();

        // Download Excel
        TempBlob.CreateOutStream(OutStream);
        TempExcelBuffer.SaveToStream(OutStream, true);
        TempBlob.CreateInStream(InStream);
        CopyStream(OutStream, InStream);
        FileName := SheetName + '.xlsx';
        DownloadFromStream(InStream, '', '', '', FileName);
    end;

    local procedure ExportTableObjectData()
    var
        JapaneseObjectsLine: Record "Japanese Objects Line";
    begin
        JapaneseObjectsLine.Reset();
        JapaneseObjectsLine.SetCurrentKey("Object Type");
        JapaneseObjectsLine.SetRange("Object Type", JapaneseObjectsLine."Object Type"::"Table", JapaneseObjectsLine."Object Type"::"TableExtension");
        if JapaneseObjectsLine.FindSet() then begin
            CreateExcelHeader(JapaneseObjectsLine);
            repeat
                CreateExcelBody(JapaneseObjectsLine);
            until JapaneseObjectsLine.Next() = 0;
        end;

    end;

    local procedure ExportPageObjectData()
    var
        JapaneseObjectsLine: Record "Japanese Objects Line";
    begin
        JapaneseObjectsLine.Reset();
        JapaneseObjectsLine.SetCurrentKey("Object Type");
        JapaneseObjectsLine.SetRange("Object Type", JapaneseObjectsLine."Object Type"::"Page", JapaneseObjectsLine."Object Type"::"PageExtension");
        if JapaneseObjectsLine.FindSet() then begin
            CreateExcelHeader(JapaneseObjectsLine);
            repeat
                CreateExcelBody(JapaneseObjectsLine);
            until JapaneseObjectsLine.Next() = 0;
        end;
    end;

    local procedure CreateExcelHeader(JapaneseObjectsLine: Record "Japanese Objects Line")
    begin
        TempExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("App Name"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Type"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object ID"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Name"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Element"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        if (JapaneseObjectsLine."Object Type" = JapaneseObjectsLine."Object Type"::"Table") or
           (JapaneseObjectsLine."Object Type" = JapaneseObjectsLine."Object Type"::"TableExtension") then begin
            TempExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Field ID"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Field Name"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        end;
        if (JapaneseObjectsLine."Object Type" = JapaneseObjectsLine."Object Type"::"Page") or
           (JapaneseObjectsLine."Object Type" = JapaneseObjectsLine."Object Type"::"PageExtension") then
            TempExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Field Name"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure CreateExcelBody(JapaneseObjectsLine: Record "Japanese Objects Line")
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(JapaneseObjectsLine."App Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(JapaneseObjectsLine."Object Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(JapaneseObjectsLine."Object ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(JapaneseObjectsLine."Object Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(JapaneseObjectsLine."Object Element", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        if (JapaneseObjectsLine."Object Type" = JapaneseObjectsLine."Object Type"::"Table") or
           (JapaneseObjectsLine."Object Type" = JapaneseObjectsLine."Object Type"::"TableExtension") then begin
            TempExcelBuffer.AddColumn(JapaneseObjectsLine."Field ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(JapaneseObjectsLine."Field Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        end;
        if (JapaneseObjectsLine."Object Type" = JapaneseObjectsLine."Object Type"::"Page") or
           (JapaneseObjectsLine."Object Type" = JapaneseObjectsLine."Object Type"::"PageExtension") then
            TempExcelBuffer.AddColumn(JapaneseObjectsLine."Field Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure CreateExcelSheet(SheetName: Text[250]; NewBook: Boolean)
    begin
        if NewBook then
            TempExcelBuffer.CreateNewBook(SheetName)
        else
            TempExcelBuffer.SelectOrAddSheet(SheetName);
        TempExcelBuffer.WriteSheet(SheetName, CompanyName, UserId);
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.ClearNewRow();
    end;

    local procedure CreateExcelBook()
    begin
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('All Japanese Objects Information');
        TempExcelBuffer.OpenExcel();
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
}