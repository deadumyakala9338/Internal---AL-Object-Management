table 99105 "Japanese Objects Line"
{
    fields
    {
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
            Editable = false;
        }
        field(10; "Object Element"; Enum "Object Element TJP")
        {
            Caption = 'Object Element';
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
        field(12; "Field Name"; Text[30])
        {
            Caption = 'Field Name';
            Editable = false;
        }
        field(13; "Field Caption"; Text[100])
        {
            Caption = 'Field Caption';
            Editable = false;
        }
        field(14; "Field Caption (Japanese)"; Text[100])
        {
            Caption = 'Field Caption (Japanese)';
            Editable = false;
        }
        field(15; "ToolTip"; Text[500])
        {
            Caption = 'ToolTip';
        }
        field(16; "ToolTip (Japanese)"; Text[500])
        {
            Caption = 'ToolTip (Japanese)';
        }
        field(46; "Field Data Type"; Text[50])
        {
            Caption = 'Field Data Type';
            Editable = false;
        }
        field(47; "Field Length"; Text[5])
        {
            Caption = 'Field Length';
            Editable = false;
        }
        field(25; "Field Class"; Text[50])
        {
            Caption = 'Field Class';
            Editable = false;
        }
        field(33; "Relation Table No."; Integer)
        {
            Caption = 'Relation Table No.';
            Editable = false;
        }
        field(34; "Relation Field No."; Integer)
        {
            Caption = 'Relation Field No.';
            Editable = false;
        }
        field(40; "Option String"; Text[2047])
        {
            Caption = 'Option String';
            Editable = false;
        }
        field(43; IsPartOfPrimaryKey; Boolean)
        {
            Caption = 'IsPartOfPrimaryKey';
            Editable = false;
        }
        field(44; "App Package ID"; Guid)
        {
            Caption = 'App Package ID';
            Editable = false;
        }
        field(45; "App Runtime Package ID"; Guid)
        {
            Caption = 'App Runtime Package ID';
            Editable = false;
        }
    }

    keys
    {
        key(pk; "App Name", "Object Type", "Object ID", "Line No.")
        {
        }
    }

    local procedure UpdateTableFieldInfo()
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
}