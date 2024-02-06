report 99100 "Japanese Object Change Log"
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
                group(Option)
                {
                    Caption = 'Create Japanese Object Change Logs.';

                    field(SetChangeLogReason; ChangeLogReason)
                    {
                        ApplicationArea = All;
                        Caption = 'Define Change Log Reason';
                        MultiLine = true;
                    }
                }
            }
        }
    }
    trigger OnPostReport()
    var
        JapaneseObjectsHeader: Record "Japanese Objects Header";
        JapaneseChangelogLine: Record "Japanese Changelog Line";
    begin
        JapaneseObjectsHeader.Reset();
        JapaneseObjectsHeader.SetCurrentKey("Entry No.");
        JapaneseObjectsHeader.SetRange("Entry No.", ObjectEntryNo);
        if JapaneseObjectsHeader.FindFirst() then begin
            JapaneseChangelogLine.Init();
            FindLastLogEntryLineNo(ObjectEntryNo);
            JapaneseChangelogLine."Entry No." := ObjectEntryNo;
            JapaneseChangelogLine."Line No." := LastLogEntryLineNo;
            JapaneseChangelogLine."App Name" := JapaneseObjectsHeader."App Name";
            JapaneseChangelogLine."Object Type" := JapaneseObjectsHeader."Object Type";
            JapaneseChangelogLine."Object ID" := JapaneseObjectsHeader."Object ID";
            JapaneseChangelogLine."Change Log Reason" := ChangeLogReason;
            JapaneseChangelogLine.Insert(true);
        end;
    end;

    var
        ChangeLogReason: Text;
        ObjectEntryNo: Integer;
        LastLogEntryLineNo: Integer;

    procedure SetObjectInfo(_EntryNo: Integer)
    begin
        ObjectEntryNo := _EntryNo;
    end;

    procedure FindLastLogEntryLineNo(pObjectEntryNo: Integer): Integer
    var
        JapaneseChangelogLine: Record "Japanese Changelog Line";
    begin
        Clear(LastLogEntryLineNo);
        JapaneseChangelogLine.Reset();
        JapaneseChangelogLine.SetCurrentKey("Entry No.");
        JapaneseChangelogLine.SetRange("Entry No.", pObjectEntryNo);
        if JapaneseChangelogLine.FindLast() then
            LastLogEntryLineNo := JapaneseChangelogLine."Entry No." + 10000
        else
            LastLogEntryLineNo := 10000;
    end;
}