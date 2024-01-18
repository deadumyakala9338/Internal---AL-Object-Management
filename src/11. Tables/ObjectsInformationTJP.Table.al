table 99100 "Object Information TJP"
{
    Caption = 'Object Information';
    DrillDownPageId = "Object Information List TJP";
    LookupPageId = "Object Information List TJP";

    fields
    {
        field(1; "Object Type"; Option)//Enum "Object Type TJP")
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
        field(2; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            NotBlank = true;
            TableRelation = AllObj."Object ID" where("Object Type" = field("Object Type"));
            trigger OnValidate()
            begin

            end;
        }
        field(10; "Object Name"; Text[80])
        {
            Caption = 'Object Name';
        }
        field(11; "Object Caption (ENG)"; Text[100])
        {
            Caption = 'Object Caption (ENG)';
        }
        field(12; "Object Caption (JPN)"; Text[100])
        {
            Caption = 'Object Caption (JPN)';
        }
    }
    keys
    {
        key(Key1; "Object Type", "Object ID") { }
    }
}