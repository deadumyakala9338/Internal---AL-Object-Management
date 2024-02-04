codeunit 99100 "Export Japanese Object Data"
{
    trigger OnRun()
    var
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        InStream: Instream;
        FileName: Text;
        FileExt: Label '.xlsx';
    begin
        ExportTablesData();
        ExportPagesData();
        ExportReportsData();
        ExportCodeunitsData();
        ExportEnumsData();
        ExportPermissionSetData();
        ExportProfileData();
        CreateExcelBook();

        TempBlob.CreateOutStream(OutStream);
        ExcelBuffer.SaveToStream(OutStream, true);
        TempBlob.CreateInStream(InStream);
        CopyStream(OutStream, InStream);
        FileName := FriendlyFilenameLbl + FileExt;
        DownloadFromStream(InStream, '', '', '', FileName);
    end;

    local procedure ExportTablesData()
    var
        JapaneseObjectsHeader: Record "Japanese Objects Header";
        JapaneseObjectsLine: Record "Japanese Objects Line";
    begin
        ExcelBuffer.Reset();
        ExcelBuffer.DeleteAll();

        JapaneseObjectsLine.Reset();
        JapaneseObjectsLine.SetCurrentKey("Object Type");
        JapaneseObjectsLine.SetFilter("Object Type", '%1|%2', JapaneseObjectsLine."Object Type"::"Table", JapaneseObjectsLine."Object Type"::"TableExtension");
        if JapaneseObjectsLine.FindSet() then begin
            if JapaneseObjectsHeader.Get(JapaneseObjectsLine."Entry No.") then;
            ExcelBuffer.NewRow();
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("App Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Type"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object ID"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Object Caption"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Object Caption (Japanese)"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Element"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Field ID"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Field Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Field Caption"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Field Caption (Japanese)"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Field Data Type"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Field Length"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Extends Object ID"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Extends Object Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            repeat
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(JapaneseObjectsLine."App Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object ID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Object Caption", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Object Caption (Japanese)", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Element", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Field ID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Field Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Field Caption", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Field Caption (Japanese)", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Field Data Type", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Field Length", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Extends Object ID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Extends Object Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            until JapaneseObjectsLine.Next() = 0;
            ExcelBuffer.CreateNewBook(TableDataLbl);
            ExcelBuffer.WriteSheet(FriendlyFilenameLbl, CompanyName, UserId);
        end;

        ExcelBuffer.SetColumnWidth('A', 27);
        ExcelBuffer.SetColumnWidth('B', 15);
        ExcelBuffer.SetColumnWidth('C', 09);
        ExcelBuffer.SetColumnWidth('D', 30);
        ExcelBuffer.SetColumnWidth('E', 16);
        ExcelBuffer.SetColumnWidth('F', 24);
        ExcelBuffer.SetColumnWidth('G', 15);
        ExcelBuffer.SetColumnWidth('H', 09);
        ExcelBuffer.SetColumnWidth('I', 30);
        ExcelBuffer.SetColumnWidth('J', 48);
        ExcelBuffer.SetColumnWidth('K', 53);
        ExcelBuffer.SetColumnWidth('L', 15);
        ExcelBuffer.SetColumnWidth('M', 12);
        ExcelBuffer.SetColumnWidth('N', 16);
        ExcelBuffer.SetColumnWidth('O', 20);
    end;

    local procedure ExportPagesData()
    var
        JapaneseObjectsHeader: Record "Japanese Objects Header";
        JapaneseObjectsLine: Record "Japanese Objects Line";
    begin
        ExcelBuffer.DeleteAll();
        ExcelBuffer.SetCurrent(0, 0);
        ExcelBuffer.SelectOrAddSheet(PageDataLbl);

        JapaneseObjectsLine.Reset();
        JapaneseObjectsLine.SetCurrentKey("Object Type");
        JapaneseObjectsLine.SetFilter("Object Type", '%1|%2', JapaneseObjectsLine."Object Type"::"Page", JapaneseObjectsLine."Object Type"::"PageExtension");
        if JapaneseObjectsLine.FindSet() then begin
            if JapaneseObjectsHeader.Get(JapaneseObjectsLine."Entry No.") then;
            ExcelBuffer.NewRow();
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("App Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Type"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object ID"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Object Caption"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Object Caption (Japanese)"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Element"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Field Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Field Caption"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Field Caption (Japanese)"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Extends Object ID"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Extends Object Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Source Object ID"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Source Object Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            repeat
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(JapaneseObjectsLine."App Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object ID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Object Caption", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Object Caption (Japanese)", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Element", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Field Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Field Caption", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Field Caption (Japanese)", false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Extends Object ID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Extends Object Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Source Object ID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Source Object Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            until JapaneseObjectsLine.Next() = 0;
            ExcelBuffer.WriteSheet(FriendlyFilenameLbl, CompanyName, UserId);
        end;

        ExcelBuffer.SetColumnWidth('A', 27);
        ExcelBuffer.SetColumnWidth('B', 15);
        ExcelBuffer.SetColumnWidth('C', 09);
        ExcelBuffer.SetColumnWidth('D', 30);
        ExcelBuffer.SetColumnWidth('E', 29);
        ExcelBuffer.SetColumnWidth('F', 24);
        ExcelBuffer.SetColumnWidth('G', 15);
        ExcelBuffer.SetColumnWidth('H', 91);
        ExcelBuffer.SetColumnWidth('I', 48);
        ExcelBuffer.SetColumnWidth('J', 53);
        ExcelBuffer.SetColumnWidth('K', 16);
        ExcelBuffer.SetColumnWidth('L', 20);
        ExcelBuffer.SetColumnWidth('M', 16);
        ExcelBuffer.SetColumnWidth('N', 20);
        ExcelBuffer.SetColumnWidth('O', 20);
    end;

    local procedure ExportReportsData()
    var
        JapaneseObjectsHeader: Record "Japanese Objects Header";
        JapaneseObjectsLine: Record "Japanese Objects Line";
    begin
        ExcelBuffer.DeleteAll();
        ExcelBuffer.SetCurrent(0, 0);
        ExcelBuffer.SelectOrAddSheet(ReportDataLbl);

        JapaneseObjectsLine.Reset();
        JapaneseObjectsLine.SetCurrentKey("Object Type");
        JapaneseObjectsLine.SetFilter("Object Type", '%1|%2', JapaneseObjectsLine."Object Type"::"Report", JapaneseObjectsLine."Object Type"::"ReportExtension");
        if JapaneseObjectsLine.FindSet() then begin
            if JapaneseObjectsHeader.Get(JapaneseObjectsLine."Entry No.") then;
            ExcelBuffer.NewRow();
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("App Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Type"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object ID"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Object Caption"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Object Caption (Japanese)"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Element"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Extends Object ID"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Extends Object Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            repeat
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(JapaneseObjectsLine."App Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object ID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Object Caption", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Object Caption (Japanese)", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Element", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Extends Object ID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Extends Object Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            until JapaneseObjectsLine.Next() = 0;
            ExcelBuffer.WriteSheet(FriendlyFilenameLbl, CompanyName, UserId);
        end;

        ExcelBuffer.SetColumnWidth('A', 27);
        ExcelBuffer.SetColumnWidth('B', 16);
        ExcelBuffer.SetColumnWidth('C', 09);
        ExcelBuffer.SetColumnWidth('D', 30);
        ExcelBuffer.SetColumnWidth('E', 30);
        ExcelBuffer.SetColumnWidth('F', 46);
        ExcelBuffer.SetColumnWidth('G', 16);
        ExcelBuffer.SetColumnWidth('H', 20);
        ExcelBuffer.SetColumnWidth('I', 30);
    end;

    local procedure ExportCodeunitsData()
    var
        JapaneseObjectsHeader: Record "Japanese Objects Header";
        JapaneseObjectsLine: Record "Japanese Objects Line";
    begin
        ExcelBuffer.DeleteAll();
        ExcelBuffer.SetCurrent(0, 0);
        ExcelBuffer.SelectOrAddSheet(CodeunitDataLbl);

        JapaneseObjectsLine.Reset();
        JapaneseObjectsLine.SetCurrentKey("Object Type");
        JapaneseObjectsLine.SetFilter("Object Type", '%1', JapaneseObjectsLine."Object Type"::"Codeunit");
        if JapaneseObjectsLine.FindSet() then begin
            if JapaneseObjectsHeader.Get(JapaneseObjectsLine."Entry No.") then;
            ExcelBuffer.NewRow();
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("App Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Type"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object ID"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Object Caption"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Object Caption (Japanese)"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Element"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Event Object Type"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Event Object Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Event Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Event Element Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Procedure Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            //ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption(Brief), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            repeat
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(JapaneseObjectsLine."App Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object ID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Object Caption", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Object Caption (Japanese)", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Element", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Event Object Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Event Object Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Event Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Event Element Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Procedure Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            //ExcelBuffer.AddColumn(JapaneseObjectsLine.Brief, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            until JapaneseObjectsLine.Next() = 0;
            ExcelBuffer.WriteSheet(FriendlyFilenameLbl, CompanyName, UserId);
        end;

        ExcelBuffer.SetColumnWidth('A', 27);
        ExcelBuffer.SetColumnWidth('B', 12);
        ExcelBuffer.SetColumnWidth('C', 09);
        ExcelBuffer.SetColumnWidth('D', 30);
        ExcelBuffer.SetColumnWidth('E', 20);
        ExcelBuffer.SetColumnWidth('F', 25);
        ExcelBuffer.SetColumnWidth('G', 15);
        ExcelBuffer.SetColumnWidth('H', 18);
        ExcelBuffer.SetColumnWidth('I', 31);
        ExcelBuffer.SetColumnWidth('J', 60);
        ExcelBuffer.SetColumnWidth('K', 30);
        ExcelBuffer.SetColumnWidth('L', 60);
    end;

    local procedure ExportEnumsData()
    var
        JapaneseObjectsHeader: Record "Japanese Objects Header";
        JapaneseObjectsLine: Record "Japanese Objects Line";
    begin
        ExcelBuffer.DeleteAll();
        ExcelBuffer.SetCurrent(0, 0);
        ExcelBuffer.SelectOrAddSheet(EnumDataLbl);

        JapaneseObjectsLine.Reset();
        JapaneseObjectsLine.SetCurrentKey("Object Type");
        JapaneseObjectsLine.SetFilter("Object Type", '%1|%2', JapaneseObjectsLine."Object Type"::"Enum", JapaneseObjectsLine."Object Type"::"EnumExtension");
        if JapaneseObjectsLine.FindSet() then begin
            if JapaneseObjectsHeader.Get(JapaneseObjectsLine."Entry No.") then;
            ExcelBuffer.NewRow();
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("App Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Type"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object ID"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Object Caption"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Object Caption (Japanese)"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Element"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Element ID"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Element Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Field Caption"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Field Caption (Japanese)"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            repeat
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(JapaneseObjectsLine."App Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object ID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Object Caption", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Object Caption (Japanese)", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Element", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Element ID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Element Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Field Caption", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Field Caption (Japanese)", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            until JapaneseObjectsLine.Next() = 0;
            ExcelBuffer.WriteSheet(FriendlyFilenameLbl, CompanyName, UserId);
        end;

        ExcelBuffer.SetColumnWidth('A', 27);
        ExcelBuffer.SetColumnWidth('B', 15);
        ExcelBuffer.SetColumnWidth('C', 15);
        ExcelBuffer.SetColumnWidth('D', 31);
        ExcelBuffer.SetColumnWidth('E', 29);
        ExcelBuffer.SetColumnWidth('F', 30);
        ExcelBuffer.SetColumnWidth('G', 27);
        ExcelBuffer.SetColumnWidth('H', 15);
        ExcelBuffer.SetColumnWidth('I', 40);
        ExcelBuffer.SetColumnWidth('J', 40);
        ExcelBuffer.SetColumnWidth('K', 30);
    end;

    local procedure ExportPermissionSetData()
    var
        JapaneseObjectsHeader: Record "Japanese Objects Header";
        JapaneseObjectsLine: Record "Japanese Objects Line";
    begin
        ExcelBuffer.DeleteAll();
        ExcelBuffer.SetCurrent(0, 0);
        ExcelBuffer.SelectOrAddSheet(PermSetsDataLbl);

        JapaneseObjectsLine.Reset();
        JapaneseObjectsLine.SetCurrentKey("Object Type");
        JapaneseObjectsLine.SetFilter("Object Type", '%1', JapaneseObjectsLine."Object Type"::"PermissionSet");
        if JapaneseObjectsLine.FindSet() then begin
            if JapaneseObjectsHeader.Get(JapaneseObjectsLine."Entry No.") then;
            ExcelBuffer.NewRow();
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("App Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Type"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object ID"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Object Caption"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsHeader.FieldCaption("Object Caption (Japanese)"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Element"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            //ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption(Brief), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            repeat
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(JapaneseObjectsLine."App Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object ID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Object Caption", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsHeader."Object Caption (Japanese)", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Element", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            //ExcelBuffer.AddColumn(JapaneseObjectsLine.Brief, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            until JapaneseObjectsLine.Next() = 0;
            ExcelBuffer.WriteSheet(FriendlyFilenameLbl, CompanyName, UserId);
        end;

        ExcelBuffer.SetColumnWidth('A', 27);
        ExcelBuffer.SetColumnWidth('B', 15);
        ExcelBuffer.SetColumnWidth('C', 09);
        ExcelBuffer.SetColumnWidth('D', 30);
        ExcelBuffer.SetColumnWidth('E', 25);
        ExcelBuffer.SetColumnWidth('F', 30);
        ExcelBuffer.SetColumnWidth('G', 27);
        ExcelBuffer.SetColumnWidth('H', 15);
    end;

    local procedure ExportProfileData()
    var
        JapaneseObjectsHeader: Record "Japanese Objects Header";
        JapaneseObjectsLine: Record "Japanese Objects Line";
    begin
        ExcelBuffer.DeleteAll();
        ExcelBuffer.SetCurrent(0, 0);
        ExcelBuffer.SelectOrAddSheet(ProfileDataLbl);

        JapaneseObjectsLine.Reset();
        JapaneseObjectsLine.SetCurrentKey("Object Type");
        JapaneseObjectsLine.SetFilter("Object Type", '%1', JapaneseObjectsLine."Object Type"::"Profile");
        if JapaneseObjectsLine.FindSet() then begin
            if JapaneseObjectsHeader.Get(JapaneseObjectsLine."Entry No.") then;
            ExcelBuffer.NewRow();
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("App Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Type"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption("Object Element"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            //ExcelBuffer.AddColumn(JapaneseObjectsLine.FieldCaption(Brief), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            repeat
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(JapaneseObjectsLine."App Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseObjectsLine."Object Element", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            //ExcelBuffer.AddColumn(JapaneseObjectsLine.Brief, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            until JapaneseObjectsLine.Next() = 0;
            ExcelBuffer.WriteSheet(FriendlyFilenameLbl, CompanyName, UserId);
        end;

        ExcelBuffer.SetColumnWidth('A', 27);
        ExcelBuffer.SetColumnWidth('B', 15);
        ExcelBuffer.SetColumnWidth('C', 18);
        ExcelBuffer.SetColumnWidth('D', 30);
    end;

    local procedure CreateExcelBook()
    begin
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(FriendlyFilenameLbl);
    end;

    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        FriendlyFilenameLbl: Label 'Localization Object Data';
        TableDataLbl: Label 'Tables';
        PageDataLbl: Label 'Pages';
        ReportDataLbl: Label 'Reports';
        CodeunitDataLbl: Label 'Codeunits';
        EnumDataLbl: Label 'Enums';
        PermSetsDataLbl: Label 'Permission Sets';
        ProfileDataLbl: Label 'Profiles';
}