table 99104 "Japanese Changelog Line"
{
    Caption = 'Japanese Changelog Line';
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "App Name"; Text[250])
        {
            Caption = 'App Name';
            Editable = false;
        }
        field(4; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
            Editable = false;
        }
        field(5; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            Editable = false;
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(20; "Object Name"; Text[30])
        {
            Caption = 'Object Name';
            Editable = false;
        }
        field(21; "Change Log Reason"; Text[1024])
        {
            Caption = 'Change Log Reason';
            trigger OnValidate()
            begin
                if "Change Log Reason" <> '' then
                    UpdateChangeLogInfo();
            end;
        }
        field(60; "Log Creation By"; Code[50])
        {
            Caption = 'Log Creation By';
            TableRelation = "User Setup";
            Editable = false;
        }
        field(61; "Log Creation Date"; Date)
        {
            Caption = 'Log Creation Date';
            Editable = false;
        }
        field(62; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            TableRelation = "User Setup";
            Editable = false;
        }
        field(63; "Last Modified Date"; Date)
        {
            Caption = 'Last Modified Date';
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Entry No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "App Name", "Object Type", "Object ID")
        {
        }
    }
    trigger OnInsert()
    begin
        "Log Creation By" := UserId;
        "Log Creation Date" := WorkDate();
    end;

    trigger OnModify()
    begin
        "Last Modified By" := UserId;
        "Last Modified Date" := WorkDate();
    end;

    procedure UpdateChangeLogInfo()
    var
        JapaneseObjectsHeader: Record "Japanese Objects Header";
        JapaneseChangelogLine: Record "Japanese Changelog Line";
    begin
        JapaneseObjectsHeader.Reset();
        JapaneseObjectsHeader.SetCurrentKey("Entry No.");
        JapaneseObjectsHeader.SetRange("Entry No.", Rec."Entry No.");
        if JapaneseObjectsHeader.FindFirst() then begin
            Rec."App Name" := JapaneseObjectsHeader."App Name";
            Rec."Object Type" := JapaneseObjectsHeader."Object Type";
            Rec."Object ID" := JapaneseObjectsHeader."Object ID";
            Rec."Object Name" := JapaneseObjectsHeader."Object Name";
        end;
    end;
}