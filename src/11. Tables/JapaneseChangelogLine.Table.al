table 99104 "Japanese Changelog Line"
{
    Caption = 'Japanese Changelog Line';
    fields
    {
        field(1; "App Name"; Text[250])
        {
            Caption = 'App Name';
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Japanese Changelog Header"."No." where("App Name" = field("App Name"));
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(21; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
        }
        field(22; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            NotBlank = true;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = field("Object Type"));
            ValidateTableRelation = true;
        }
        field(50; "Line Change Log"; Text[500])
        {
            Caption = 'Line Change Log';
        }
    }
    keys
    {
        key(Key1; "App Name", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}