codeunit 99100 "Export Japanese Object Data"
{
    trigger OnRun()
    var
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
        OutStream: OutStream;
        InStream: Instream;
        SheetName: Label 'Localization Objects Information';
    begin
        ExportTableData();
        ExportPageData();
        CreateExcelBook();

        TempBlob.CreateOutStream(OutStream);
        TempExcelBuffer.SaveToStream(OutStream, true);
        TempBlob.CreateInStream(InStream);
        CopyStream(OutStream, InStream);
        FileName := SheetName + '.xlsx';
        DownloadFromStream(InStream, '', '', '', FileName);
    end;

    local procedure ExportTableData()
    var
        JapaneseObjectsLine: Record "Japanese Objects Line";
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('App Name', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Object Type', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Object ID', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Object Name', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Object Element', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Field ID', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Field Name', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);

        JapaneseObjectsLine.Reset();
        JapaneseObjectsLine.SetCurrentKey("Object Type");
        JapaneseObjectsLine.SetFilter("Object Type", '%1|%2', JapaneseObjectsLine."Object Type"::"Table", JapaneseObjectsLine."Object Type"::"TableExtension");
        if JapaneseObjectsLine.FindSet() then
            repeat
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(JapaneseObjectsLine."App Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(JapaneseObjectsLine."Object Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(JapaneseObjectsLine."Object ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(JapaneseObjectsLine."Object Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(JapaneseObjectsLine."Object Element", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(JapaneseObjectsLine."Field ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(JapaneseObjectsLine."Field Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            until JapaneseObjectsLine.Next() = 0;
        TempExcelBuffer.CreateNewBook('Table Data');
        TempExcelBuffer.WriteSheet('Localization Object Data', CompanyName, UserId);

        TempExcelBuffer.SetColumnWidth('A', 27);
        TempExcelBuffer.SetColumnWidth('B', 15);
        TempExcelBuffer.SetColumnWidth('C', 09);
        TempExcelBuffer.SetColumnWidth('D', 30);
        TempExcelBuffer.SetColumnWidth('E', 15);
        TempExcelBuffer.SetColumnWidth('F', 09);
        TempExcelBuffer.SetColumnWidth('G', 30);
    end;

    local procedure ExportPageData()
    var
        JapaneseObjectsLine: Record "Japanese Objects Line";
    begin
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.SetCurrent(0, 0);
        TempExcelBuffer.SelectOrAddSheet('Page Data');
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('App Name', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Object Type', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Object ID', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Object Name', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Object Element', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Field Name', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);

        JapaneseObjectsLine.Reset();
        JapaneseObjectsLine.SetCurrentKey("Object Type");
        JapaneseObjectsLine.SetFilter("Object Type", '%1|%2', JapaneseObjectsLine."Object Type"::"Page", JapaneseObjectsLine."Object Type"::"PageExtension");
        if JapaneseObjectsLine.FindSet() then
            repeat
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(JapaneseObjectsLine."App Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(JapaneseObjectsLine."Object Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(JapaneseObjectsLine."Object ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(JapaneseObjectsLine."Object Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(JapaneseObjectsLine."Object Element", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(JapaneseObjectsLine."Field Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            until JapaneseObjectsLine.Next() = 0;
        TempExcelBuffer.WriteSheet('Localization Object Data', CompanyName, UserId);

        TempExcelBuffer.SetColumnWidth('A', 27);
        TempExcelBuffer.SetColumnWidth('B', 15);
        TempExcelBuffer.SetColumnWidth('C', 09);
        TempExcelBuffer.SetColumnWidth('D', 30);
        TempExcelBuffer.SetColumnWidth('E', 15);
        TempExcelBuffer.SetColumnWidth('F', 30);
    end;

    local procedure CreateExcelBook()
    begin
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('Localization Object Data');
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
}