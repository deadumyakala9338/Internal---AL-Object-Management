table 99105 "Japanese Objects Line"
{
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
        field(19; "Object Name"; Text[30])
        {
            Caption = 'Object Name';
        }
        field(10; "Object Element"; Enum "Object Element TJP")
        {
            Caption = 'Object Element';

            trigger OnValidate()
            begin
                GetJapaneseObjectsHeader();
                InitHeaderDefaults(JapaneseObjectsHeader);
            end;
        }
        field(11; "Field ID"; Integer)
        {
            Caption = 'Field ID';
            TableRelation = Field."No." where(TableNo = field("Object ID"));
            trigger OnValidate()
            begin
                if Rec."Object Type" = Rec."Object Type"::"Table" then
                    UpdateTableFieldInfo();
            end;
        }
        field(12; "Field Name"; Text[100])
        {
            Caption = 'Name/Description';
        }
        field(13; "Field Caption"; Text[100])
        {
            Caption = 'Field Caption';
        }
        field(14; "Field Caption (Japanese)"; Text[100])
        {
            Caption = 'Field Caption (Japanese)';
        }
        field(15; "ToolTip"; Text[500])
        {
            Caption = 'ToolTip';
        }
        field(16; "ToolTip (Japanese)"; Text[500])
        {
            Caption = 'ToolTip (Japanese)';
        }
        field(17; "Element ID"; Integer)
        {
            Caption = 'Element ID';
        }
        field(18; "Element Name"; Text[50])
        {
            Caption = 'Element Name';
        }
        field(20; "Field Data Type"; Text[50])
        {
            Caption = 'Field Data Type';
        }
        field(21; "Field Length"; Text[5])
        {
            Caption = 'Field Length';
        }
        field(22; "Field Class"; Text[50])
        {
            Caption = 'Field Class';
            Editable = false;
        }
        field(23; "Relation Table No."; Integer)
        {
            Caption = 'Relation Table No.';
            Editable = false;
        }
        field(24; "Relation Field No."; Integer)
        {
            Caption = 'Relation Field No.';
            Editable = false;
        }
        field(25; "Option String"; Text[2047])
        {
            Caption = 'Option String';
            Editable = false;
        }
        field(26; IsPartOfPrimaryKey; Boolean)
        {
            Caption = 'IsPartOfPrimaryKey';
            Editable = false;
        }
        field(27; "App Package ID"; Guid)
        {
            Caption = 'App Package ID';
            Editable = false;
        }
        field(28; "App Runtime Package ID"; Guid)
        {
            Caption = 'App Runtime Package ID';
            Editable = false;
        }
        field(29; "Event Object Type"; Text[200])
        {
            Caption = 'Event Object Type';
        }
        field(30; "Event Object Name"; Text[200])
        {
            Caption = 'Event Object Name';
        }
        field(31; "Event Name"; Text[100])
        {
            Caption = 'Event Name';
        }
        field(32; "Event Element Name"; Text[100])
        {
            Caption = 'Event Element Name';
        }
        field(33; "Brief"; Text[1024])
        {
            Caption = 'Brief';
        }
        field(34; "Procedure Name"; Text[200])
        {
            Caption = 'Procedure Name';
        }
        field(60; "Creation By"; Code[50])
        {
            Caption = 'Creation By';
            TableRelation = "User Setup";
            Editable = false;
        }
        field(61; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
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
        key(Key2; "App Name", "Object Type", "Object ID") { }
        key(Key3; "Object Type") { }
    }
    trigger OnInsert()
    begin
        "Creation By" := UserId;
        "Creation Date" := WorkDate();
    end;

    trigger OnModify()
    begin
        "Last Modified By" := UserId;
        "Last Modified Date" := WorkDate();
    end;

    procedure UpdateTableFieldInfo()
    var
        RecField: Record Field;
    begin
        RecField.Reset();
        RecField.SetCurrentKey(TableNo);
        RecField.SetRange(TableNo, "Object ID");
        RecField.SetRange("No.", "Field ID");
        if RecField.FindFirst() then begin
            Rec."Field ID" := RecField."No.";
            Rec."Field Name" := RecField.FieldName;
            Rec."Field Caption" := RecField."Field Caption";
            Rec."Field Data Type" := Format(RecField.Type);
            Rec."Field Length" := Format(RecField.Len);
            Rec."Field Class" := Format(RecField.Class);
            Rec."Relation Table No." := RecField.RelationTableNo;
            Rec."Relation Field No." := RecField.RelationFieldNo;
            Rec."Option String" := RecField.OptionString;
            Rec.IsPartOfPrimaryKey := RecField.IsPartOfPrimaryKey;
            Rec."App Package ID" := RecField."App Package ID";
            Rec."App Runtime Package ID" := RecField."App Runtime Package ID";
        end;
    end;

    procedure GetJapaneseObjectsHeader()
    begin
        Rec.TestField("Entry No.");
        Clear(JapaneseObjectsHeader);
        if JapaneseObjectsHeader.Get("Entry No.") then;
    end;

    procedure InitHeaderDefaults(JapaneseObjectsHeader: Record "Japanese Objects Header")
    var
        NotApplicableLbl: Label 'n/a';
    begin
        "App Name" := JapaneseObjectsHeader."App Name";
        "Object Type" := JapaneseObjectsHeader."Object Type";
        "Object ID" := JapaneseObjectsHeader."Object ID";
        "Object Name" := JapaneseObjectsHeader."Object Name";
        if "Object Element" = "Object Element"::"Procedure" then begin
            "Field Caption" := NotApplicableLbl;
            "Field Caption (Japanese)" := NotApplicableLbl;
            "Field Data Type" := NotApplicableLbl;
            "Field Length" := NotApplicableLbl;
            "Field Class" := NotApplicableLbl;
            "Option String" := NotApplicableLbl;
            ToolTip := NotApplicableLbl;
            "ToolTip (Japanese)" := NotApplicableLbl;
        end;
    end;

    var
        JapaneseObjectsHeader: Record "Japanese Objects Header";
}