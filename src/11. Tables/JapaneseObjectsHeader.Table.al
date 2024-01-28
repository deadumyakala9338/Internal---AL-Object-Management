table 99106 "Japanese Objects Header"
{
    Caption = 'Japanese Objects Header';
    DrillDownPageId = "Japanese Objects List";
    LookupPageId = "Japanese Objects List";
    DataPerCompany = false;
    ReplicateData = false;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(4; "App Name"; Text[250])
        {
            Caption = 'App Name';
            TableRelation = "Japanese App Information"."App Name";

            trigger OnValidate()
            var
                JapaneseAppInformation: Record "Japanese App Information";
            begin
                if Rec."App Name" <> xRec."App Name" then
                    MessageIfSalesLinesExist(FieldCaption("App Name"));

                JapaneseAppInformation.Reset();
                JapaneseAppInformation.SetRange("App Name", Rec."App Name");
                if JapaneseAppInformation.FindFirst() then;
                Rec."App ID" := JapaneseAppInformation."App ID";
                Rec."App Package ID" := JapaneseAppInformation."App Package ID";
            end;
        }
        field(11; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';

            trigger OnValidate()
            begin
                if Rec."Object Type" <> xRec."Object Type" then
                    MessageIfSalesLinesExist(FieldCaption("Object Type"));
            end;
        }
        field(12; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            NotBlank = true;
            TableRelation = AllObjWithCaption;

            trigger OnLookup()
            begin
                LookupAndValidateObjectFields();
            end;

            trigger OnValidate()
            begin
                if Rec."Object ID" <> xRec."Object ID" then
                    MessageIfSalesLinesExist(FieldCaption("Object ID"));

                if not JapaneseObjectLinesExist() then
                    ClearFieldValues();
            end;
        }
        field(5; "App ID"; Text[250])
        {
            Caption = 'App ID';
            Editable = false;
        }
        field(6; "App Package ID"; Text[250])
        {
            Caption = 'App Package ID';
            Editable = false;
        }
        field(10; "Object Category"; Enum "Object Category TJP")
        {
            Caption = 'Object Category';
        }
        field(20; "Page Type"; Text[50])
        {
            Caption = 'Page Type';
            Editable = false;
        }
        field(21; "Object Name"; Text[80])
        {
            Caption = 'Object Name';
            Editable = false;
        }
        field(22; "Object Caption"; Text[100])
        {
            Caption = 'Object Caption';
            Editable = false;
        }
        field(23; "Object Caption (Japanese)"; Text[100])
        {
            Caption = 'Object Caption (Japanese)';
            Editable = false;
        }
        field(24; "Extends Object Type"; Option)
        {
            Caption = 'Extends Object Type';
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
            Editable = false;
        }
        field(25; "Extends Object ID"; Integer)
        {
            Caption = 'Extends Object ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = field("Extends Object Type"));
            ValidateTableRelation = true;
            Editable = false;

            trigger OnValidate()
            begin
                CheckAndValidateExtendsObjectFields();
            end;
        }
        field(26; "Extends Object Name"; Text[100])
        {
            Caption = 'Extends Object Name';
            Editable = false;
        }
        field(49; "Source Object ID"; Integer)
        {
            Caption = 'Source Object ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = filter("Object Type"::"Table"));
            ValidateTableRelation = true;

            trigger OnValidate()
            begin
                CheckAndValidateSourceObjectFields();
            end;
        }
        field(50; "Source Object Name"; Text[100])
        {
            Caption = 'Source Object Name';
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "App Name", "Object Type", "Object ID") { }
    }

    trigger OnInsert()
    begin
        InsertEntryNo();
    end;

    local procedure InsertEntryNo()
    var
        JapaneseObjectsHeader: Record "Japanese Objects Header";
    begin
        JapaneseObjectsHeader.Reset();
        JapaneseObjectsHeader.SetCurrentKey("Entry No.");
        if JapaneseObjectsHeader.FindLast() then
            "Entry No." := JapaneseObjectsHeader."Entry No." + 1
        else
            "Entry No." := 1;
    end;

    local procedure LookupAndValidateObjectFields()
    var
        AllObjWithCaption: Record AllObjWithCaption;
        IntExtObjID: Integer;
    begin
        AllObjWithCaption.Reset();
        AllObjWithCaption.SetCurrentKey("Object Type", "Object ID");
        AllObjWithCaption.SetRange("Object Type", Rec."Object Type");
        AllObjWithCaption.SetRange("App Package ID", Rec."App Package ID");
        if AllObjWithCaption.FindFirst() then;
        if Page.RunModal(Page::"All Objects with Caption", AllObjWithCaption) = Action::LookupOK then begin
            Rec."Object ID" := AllObjWithCaption."Object ID";
            Rec."Object Name" := AllObjWithCaption."Object Name";
            Rec."Object Caption" := AllObjWithCaption."Object Caption";
            if (Rec."Object Type" = Rec."Object Type"::"TableExtension") then begin
                Rec."Extends Object Type" := Rec."Extends Object Type"::"Table";
                Evaluate(IntExtObjID, AllObjWithCaption."Object Subtype");
                Rec.Validate("Extends Object ID", IntExtObjID);
            end;
            if (Rec."Object Type" = Rec."Object Type"::"PageExtension") then begin
                Rec."Extends Object Type" := Rec."Extends Object Type"::"Page";
                Evaluate(IntExtObjID, AllObjWithCaption."Object Subtype");
                Rec.Validate("Extends Object ID", IntExtObjID);
            end;
            if (Rec."Object Type" = Rec."Object Type"::"ReportExtension") then begin
                Rec."Extends Object Type" := Rec."Extends Object Type"::"Report";
                Evaluate(IntExtObjID, AllObjWithCaption."Object Subtype");
                Rec.Validate("Extends Object ID", IntExtObjID);
            end;
            if (Rec."Object Type" = Rec."Object Type"::"EnumExtension") then begin
                Rec."Extends Object Type" := Rec."Extends Object Type"::"Enum";
                Evaluate(IntExtObjID, AllObjWithCaption."Object Subtype");
                Rec.Validate("Extends Object ID", IntExtObjID);
            end;
            if (Rec."Object Type" = Rec."Object Type"::"Page") then
                Rec."Page Type" := AllObjWithCaption."Object Subtype";
        end;
    end;

    local procedure CheckAndValidateExtendsObjectFields()
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        AllObjWithCaption.Reset();
        AllObjWithCaption.SetCurrentKey("Object Type", "Object ID");
        AllObjWithCaption.SetRange("Object Type", Rec."Extends Object Type");
        AllObjWithCaption.SetRange("Object ID", Rec."Extends Object ID");
        if AllObjWithCaption.FindFirst() then
            Rec."Extends Object Name" := AllObjWithCaption."Object Name"
        else
            Rec."Extends Object Name" := '';
    end;

    local procedure CheckAndValidateSourceObjectFields()
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        AllObjWithCaption.Reset();
        AllObjWithCaption.SetCurrentKey("Object Type", "Object ID");
        AllObjWithCaption.SetRange("Object Type", AllObjWithCaption."Object Type"::"Table");
        AllObjWithCaption.SetRange("Object ID", Rec."Source Object ID");
        if AllObjWithCaption.FindFirst() then
            Rec."Source Object Name" := AllObjWithCaption."Object Name"
        else
            Rec."Source Object Name" := '';
    end;

    local procedure ClearFieldValues()
    begin
        Validate(Rec."Page Type", '');
        Clear(Rec."Object Type");
        Validate(Rec."Object Name", '');
        Validate(Rec."Object Caption", '');
        Validate(Rec."Object Caption (Japanese)", '');
        Validate(Rec."Source Object ID", 0);
        Validate(Rec."Source Object Name", '');
        Clear(Rec."Extends Object Type");
        Validate(Rec."Extends Object ID", 0);
        Validate(Rec."Extends Object Name", '');
    end;

    procedure InsertObjectChangeLog()
    var
        JpnChangelogHeader: Record "Japanese Changelog Header";
        JpnChangelogLine: Record "Japanese Changelog Line";
        InsertJpnChangelogLine: Record "Japanese Changelog Line";
    begin
        JpnChangelogHeader.Reset();
        JpnChangelogHeader.SetRange("App Name", Rec."App Name");
        if JpnChangelogHeader.FindFirst() then begin
            JpnChangelogLine.Reset();
            JpnChangelogLine.SetRange("App Name", JpnChangelogHeader."App Name");
            JpnChangelogLine.SetRange("Document No.", JpnChangelogHeader."No.");
            if JpnChangelogLine.FindLast() then begin
                InsertJpnChangelogLine.Init();
                InsertJpnChangelogLine."App Name" := JpnChangelogHeader."App Name";
                InsertJpnChangelogLine."Document No." := JpnChangelogHeader."No.";
                InsertJpnChangelogLine."Line No." := JpnChangelogLine."Line No." + 10000;
                InsertJpnChangelogLine."Object Type" := Rec."Object Type";
                InsertJpnChangelogLine."Object ID" := Rec."Object ID";
                InsertJpnChangelogLine.Insert();
            end;
        end;
    end;

    procedure MessageIfSalesLinesExist(ChangedFieldName: Text[100])
    var
        MessageText: Text;
    begin
        if JapaneseObjectLinesExist() and not GetHideValidationDialog() then begin
            MessageText := StrSubstNo(LinesNotUpdatedMsg, ChangedFieldName);
            MessageText := StrSubstNo(SplitMessageTxt, MessageText, Text019);
            Error(MessageText);
        end;
    end;

    procedure JapaneseObjectLinesExist(): Boolean
    begin
        JapaneseObjectsLine.Reset();
        JapaneseObjectsLine.SetRange("Entry No.", Rec."Entry No.");
        exit(not JapaneseObjectsLine.IsEmpty());
    end;

    procedure GetHideValidationDialog(): Boolean
    begin
        exit(HideValidationDialog);
    end;

    var
        JapaneseObjectsLine: Record "Japanese Objects Line";
        HideValidationDialog: Boolean;
        LinesNotUpdatedMsg: Label 'You have changed %1 on the objects header, but it has not been changed on the existing objects lines.', Comment = 'You have changed apptype/objecttype/objectid but it has not been changed on the existing object lines.';
        SplitMessageTxt: Label '%1\%2', Comment = 'Some message text 1.\Some message text 2.', Locked = true;
        Text019: Label 'You must delete/update the existing object lines manually.';
}