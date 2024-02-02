report 99101 "Japanese Object Data Export"
{
    ApplicationArea = All;
    Caption = 'Japanese Object Data Export';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(TableLines; "Japanese Objects Line")
        {
            DataItemTableView = sorting("Entry No.", "Line No.") order(ascending);

            trigger OnPreDataItem()
            begin
                CreateTableExcelHeader();
                CreatePageExcelHeader();
            end;

            trigger OnAfterGetRecord()
            begin
                if (TableLines."Object Type" = TableLines."Object Type"::"Table") or
                   (TableLines."Object Type" = TableLines."Object Type"::"TableExtension") then
                    CreateTableExcelLines();
                if (TableLines."Object Type" = TableLines."Object Type"::"Page") or
                   (TableLines."Object Type" = TableLines."Object Type"::"PageExtension") then
                    CreatePageExcelLines();
            end;

            trigger OnPostDataItem()
            begin
                if (TableLines."Object Type" = TableLines."Object Type"::"Table") or
                   (TableLines."Object Type" = TableLines."Object Type"::"TableExtension") then
                    CreateExcelSheet(CopyStr('Table', 1, 250), false);
                /*if (TableLines."Object Type" = TableLines."Object Type"::"Page") or
                   (TableLines."Object Type" = TableLines."Object Type"::"PageExtension") then
                    CreateExcelSheet(CopyStr('Pages', 1, 250), false);
                    */
            end;
        }
    }

    trigger OnInitReport()
    begin
        TempExcelBuffer.DeleteAll();
    end;

    trigger OnPostReport()
    begin
        CreateExcelBook();
    end;

    local procedure CreateExcelBook()
    begin
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('All Japanese Objects Information');
        TempExcelBuffer.OpenExcel();
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

    local procedure CreateTableExcelHeader()
    begin
        TempExcelBuffer.AddColumn(TableLines.FieldCaption("App Name"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines.FieldCaption("Object Type"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines.FieldCaption("Object ID"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines.FieldCaption("Object Name"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines.FieldCaption("Object Element"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines.FieldCaption("Field ID"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines.FieldCaption("Field Name"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure CreatePageExcelHeader()
    begin
        TempExcelBuffer.AddColumn(TableLines.FieldCaption("App Name"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines.FieldCaption("Object Type"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines.FieldCaption("Object ID"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines.FieldCaption("Object Name"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines.FieldCaption("Object Element"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines.FieldCaption("Field Name"), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure CreateTableExcelLines()
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(TableLines."App Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines."Object Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines."Object ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines."Object Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines."Object Element", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines."Field ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines."Field Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure CreatePageExcelLines()
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(TableLines."App Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines."Object Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines."Object ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines."Object Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines."Object Element", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TableLines."Field Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
}