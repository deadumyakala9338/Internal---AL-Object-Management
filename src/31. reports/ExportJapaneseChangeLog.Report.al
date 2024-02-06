report 99101 "Export Japanese Change Log"
{
    Caption = 'Change Log Creation';
    ProcessingOnly = true;
    UsageCategory = None;

    dataset { }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                field(RepStartDate; StartDate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Start Date';
                    NotBlank = true;
                }
                field(RepEndDate; EndDate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'End Date';
                    NotBlank = true;
                }
            }
        }
    }
    trigger OnPostReport()
    begin
        ExportJapaneseObjectChanges.ExportTablesData(StartDate, EndDate);
    end;

    var
        ExportJapaneseObjectChanges: Codeunit "Export Japanese Object Changes";
        StartDate: Date;
        EndDate: Date;
}