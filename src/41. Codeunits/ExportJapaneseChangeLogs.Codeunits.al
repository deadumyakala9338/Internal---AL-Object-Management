codeunit 99101 "Export Japanese Object Changes"
{
    procedure ExportTablesData(StartDate: Date; EndDate: Date)
    var
        JapaneseChangelogLine: Record "Japanese Changelog Line";
    begin
        ExcelBuffer.Reset();
        ExcelBuffer.DeleteAll();
        ExcelBuffer.CreateNewBook(ChangeObjectInfoLbl);

        JapaneseChangelogLine.Reset();
        JapaneseChangelogLine.SetCurrentKey("App Name", "Object Type", "Object ID", "Log Creation Date");
        JapaneseChangelogLine.SetRange("Log Creation Date", StartDate, EndDate);
        if JapaneseChangelogLine.FindSet() then begin
            ExcelBuffer.AddColumn(JapaneseChangelogLine.FieldCaption("App Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseChangelogLine.FieldCaption("Object Type"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseChangelogLine.FieldCaption("Object ID"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseChangelogLine.FieldCaption("Object Name"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(JapaneseChangelogLine.FieldCaption("Change Log Reason"), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            repeat
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(JapaneseChangelogLine."App Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseChangelogLine."Object Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseChangelogLine."Object ID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseChangelogLine."Object Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(JapaneseChangelogLine."Change Log Reason", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.NewRow();
            until JapaneseChangelogLine.Next() = 0;

            ExcelBuffer.WriteSheet(FriendlyFilenameLbl, CompanyName, UserId);
            ExcelBuffer.SetColumnWidth('A', 27);
            ExcelBuffer.SetColumnWidth('B', 15);
            ExcelBuffer.SetColumnWidth('C', 09);
            ExcelBuffer.SetColumnWidth('D', 30);
            ExcelBuffer.SetColumnWidth('E', 100);
            ExcelBuffer.CloseBook();
        end;

        TempBlob.CreateOutStream(OutStream);
        ExcelBuffer.SaveToStream(OutStream, true);
        TempBlob.CreateInStream(InStream);
        CopyStream(OutStream, InStream);
        FileName := FriendlyFilenameLbl + FileExt;
        DownloadFromStream(InStream, '', '', '', FileName);
    end;

    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        InStream: Instream;
        FileName: Text;
        FileExt: Label '.xlsx';
        FriendlyFilenameLbl: Label 'Localization Object Data';
        ChangeObjectInfoLbl: Label 'Object Change Log.';
}