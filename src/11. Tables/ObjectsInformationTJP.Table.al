table 99100 "Object Information TJP"
{
    Caption = 'Object Information';
    DrillDownPageId = "Object Information List TJP";
    LookupPageId = "Object Information List TJP";

    fields
    {
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(5; "Entry Type"; Enum "Entry Type TJP")
        {
            Caption = 'Entry Type';
        }
        field(6; "App Category"; Enum "App Category TJP")
        {
            Caption = 'App Category';
        }
        field(7; "App Subcategory"; Enum "App Subcategory TJP")
        {
            Caption = 'App Subcategory';
        }
        field(8; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
        }
        field(9; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            NotBlank = true;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = field("Object Type"));
            ValidateTableRelation = true;
        }
        field(20; "Page Type"; Enum "Page Type TJP")
        {
            Caption = 'Page Type';
        }
        field(22; "Object Name"; Text[80])
        {
            Caption = 'Object Name';
        }
        field(23; "Object Caption"; Text[100])
        {
            Caption = 'Object Caption';
        }
        field(24; "Object Caption (Japanese)"; Text[100])
        {
            Caption = 'Object Caption (Japanese)';
        }
        field(25; "Extends Object ID"; Integer)
        {
            Caption = 'Extends Object ID';
        }
        field(26; "Extends Object Name"; Text[100])
        {
            Caption = 'Extends Object Name';
        }
        field(27; "Field ID"; Text[30])
        {
            Caption = 'Field ID';
        }
        field(28; "Field Name"; Text[30])
        {
            Caption = 'Field Name';
        }
        field(29; "Field Caption"; Text[100])
        {
            Caption = 'Field Caption';
        }
        field(30; "Field Caption (Japanese)"; Text[100])
        {
            Caption = 'Field Caption (Japanese)';
        }
        field(31; "ToolTip"; Text[500])
        {
            Caption = 'ToolTip';
        }
        field(32; "ToolTip (Japanese)"; Text[500])
        {
            Caption = 'ToolTip (Japanese)';
        }
        field(33; "Field Data Type"; Text[50])
        {
            Caption = 'Field Data Type';
        }
        field(34; "Field Length"; Text[5])
        {
            Caption = 'Field Length';
        }
        field(35; "Source Object ID"; Integer)
        {
            Caption = 'Source Object ID';
        }
        field(36; "Source Object Name"; Text[100])
        {
            Caption = 'Source Object Name';
        }
        field(37; "Object Element"; Enum "Object Element TJP")
        {
            Caption = 'Object Element';
        }
        field(50; "Change Reason"; Text[50])
        {
            Caption = 'Change Reason';
        }
    }
    keys
    {
        key(Key1; "Entry No.") { }
        key(Key2; "App Category", "Object Type", "Object ID") { }
    }

    procedure InsertObjectLog()
    var
        TJPChangeLogHeader: Record "TJP Change Log Header";
        TJPChangeLogLine: Record "TJP Change Log Line";
        InsertTJPChangeLogLine: Record "TJP Change Log Line";
    begin
        TJPChangeLogHeader.Reset();
        TJPChangeLogHeader.SetRange("App Category", Rec."App Category");
        if TJPChangeLogHeader.FindFirst() then begin
            TJPChangeLogLine.Reset();
            TJPChangeLogLine.SetRange("App Category", TJPChangeLogHeader."App Category");
            TJPChangeLogLine.SetRange("Document No.", TJPChangeLogHeader."No.");
            if TJPChangeLogLine.FindLast() then begin
                InsertTJPChangeLogLine.Init();
                InsertTJPChangeLogLine."App Category" := TJPChangeLogHeader."App Category";
                InsertTJPChangeLogLine."Document No." := TJPChangeLogHeader."No.";
                InsertTJPChangeLogLine."Line No." := TJPChangeLogLine."Line No." + 10000;
                InsertTJPChangeLogLine."App Subcategory" := Rec."App Subcategory";
                InsertTJPChangeLogLine."Object Type" := Rec."Object Type";
                InsertTJPChangeLogLine."Object ID" := Rec."Object ID";
                InsertTJPChangeLogLine."Line Change Log" := "Change Reason";
                InsertTJPChangeLogLine.Insert();
            end;
        end;
    end;
}