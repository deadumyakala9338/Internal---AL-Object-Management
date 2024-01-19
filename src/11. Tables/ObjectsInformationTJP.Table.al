table 99100 "Object Information TJP"
{
    Caption = 'Object Information';
    DrillDownPageId = "Object Information List TJP";
    LookupPageId = "Object Information List TJP";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(4; Indentation; Integer)
        {
            Caption = 'Indentation';
            MinValue = 0;

            trigger OnValidate()
            begin
                if Indentation < 0 then
                    Indentation := 0;
            end;
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
        field(19; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';

            trigger OnValidate()
            begin
                if "Object Type" <> xRec."Object Type" then
                    Validate("Object ID", 0);
            end;
        }
        field(20; "Page Type"; Enum "Page Type TJP")
        {
            Caption = 'Page Type';
        }
        field(21; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            NotBlank = true;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = field("Object Type"));
            ValidateTableRelation = true;
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
    }
    keys
    {
        key(Key1; "No.") { }
    }
}