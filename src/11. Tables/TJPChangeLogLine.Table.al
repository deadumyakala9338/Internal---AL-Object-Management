table 99103 "TJP Change Log Line"
{
    Caption = 'TJP - Change Log Line';
    fields
    {
        field(1; "App Category"; Enum "App Category TJP")
        {
            Caption = 'App Category';
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "TJP Change Log Header"."No." where("App Category" = field("App Category"));
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(20; "App Subcategory"; Enum "App Subcategory TJP")
        {
            Caption = 'App Subcategory';
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
        key(Key1; "App Category", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}