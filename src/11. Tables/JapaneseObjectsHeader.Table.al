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
                    ErrorIfSalesLinesExist(FieldCaption("App Name"), Rec);

                JapaneseAppInformation.Reset();
                JapaneseAppInformation.SetRange("App Name", Rec."App Name");
                if JapaneseAppInformation.FindFirst() then;
                Rec."App ID" := JapaneseAppInformation."App ID";
                Rec."App Package ID" := JapaneseAppInformation."App Package ID";

                if (Rec."App Name" <> xRec."App Name") or (Rec."App Name" = '') then begin
                    "Object Type" := "Object Type"::" ";
                    "Object ID" := 0;
                    ClearFieldValues();
                end;
            end;
        }
        field(11; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = " ","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = ' ,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
            trigger OnValidate()
            begin
                if not JapaneseObjectLinesExist(Rec) then
                    ClearFieldValues();

                if Rec."Object Type" <> xRec."Object Type" then begin
                    ErrorIfSalesLinesExist(FieldCaption("Object Type"), Rec);
                    "Object ID" := 0;
                end;
            end;
        }
        field(12; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            TableRelation = AllObjWithCaption;

            trigger OnLookup()
            begin
                LookupAndValidateObjectFields();
                if Rec."Object ID" <> xRec."Object ID" then
                    ErrorIfSalesLinesExist(FieldCaption("Object ID"), Rec);
            end;

            trigger OnValidate()
            begin
                if Rec."Object ID" <> xRec."Object ID" then
                    ErrorIfSalesLinesExist(FieldCaption("Object ID"), Rec);

                if not JapaneseObjectLinesExist(Rec) then
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
            OptionMembers = " ","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = ' ,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
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
        field(50; "Source Object ID"; Integer)
        {
            Caption = 'Source Object ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = filter("Object Type"::"Table"));
            ValidateTableRelation = true;

            trigger OnValidate()
            begin
                CheckAndValidateSourceObjectFields();
            end;
        }
        field(51; "Source Object Name"; Text[100])
        {
            Caption = 'Source Object Name';
            Editable = false;
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
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "App Name", "Object Type", "Object ID") { }
    }

    trigger OnInsert()
    begin
        InsertEntryNo();
        "Creation By" := UserId;
        "Creation Date" := WorkDate();
    end;

    trigger OnModify()
    begin
        "Last Modified By" := UserId;
        "Last Modified Date" := WorkDate();
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
        TranslationHelper: Codeunit "Translation Helper";
    begin
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
                if GlobalLanguage <> 1041 then
                    Rec."Object Caption (Japanese)" := '';
                //Rec."Object Caption (Japanese)" := TranslationHelper.GetTranslatedFieldCaption('JPN', Rec."Object ID", Rec.FieldNo("Object Caption"));
                if (Rec."Object Type" = Rec."Object Type"::"TableExtension") then begin
                    Rec."Extends Object Type" := Rec."Extends Object Type"::"Table";
                    Evaluate(Rec."Extends Object ID", AllObjWithCaption."Object Subtype");
                end;
                if (Rec."Object Type" = Rec."Object Type"::"PageExtension") then begin
                    Rec."Extends Object Type" := Rec."Extends Object Type"::"Page";
                    Evaluate(Rec."Extends Object ID", AllObjWithCaption."Object Subtype");
                end;
                if (Rec."Object Type" = Rec."Object Type"::"ReportExtension") then begin
                    Rec."Extends Object Type" := Rec."Extends Object Type"::"Report";
                    Evaluate(Rec."Extends Object ID", AllObjWithCaption."Object Subtype");
                end;
                if (Rec."Object Type" = Rec."Object Type"::"EnumExtension") then begin
                    Rec."Extends Object Type" := Rec."Extends Object Type"::"Enum";
                    Evaluate(Rec."Extends Object ID", AllObjWithCaption."Object Subtype");
                end;
                if (Rec."Object Type" = Rec."Object Type"::"Page") then
                    Rec."Page Type" := AllObjWithCaption."Object Subtype";
            end;
        end;
    end;

    procedure UpdateJapaneseObjectLineDetails(JapaneseObjectsHeader: Record "Japanese Objects Header")
    var
        JapaneseObjectsLine: Record "Japanese Objects Line";
        FieldInfo: Record Field;
        TranslationHelper: Codeunit "Translation Helper";
    begin
        if JapaneseObjectLinesExist(JapaneseObjectsHeader) then
            Error(LinesNotUpdatedMsg);

        FieldInfo.Reset();
        FieldInfo.SetCurrentKey(TableNo);
        FieldInfo.SetRange(TableNo, JapaneseObjectsHeader."Object ID");
        FieldInfo.SetFilter("No.", '<%1', 2000000000);
        if FieldInfo.FindFirst() then
            repeat
                JapaneseObjectsLine.Init();
                JapaneseObjectsLine."Entry No." := JapaneseObjectsHeader."Entry No.";
                JapaneseObjectsLine."Line No." := JapaneseObjectsLine."Line No." + 10000;
                JapaneseObjectsLine."App Name" := JapaneseObjectsHeader."App Name";
                JapaneseObjectsLine."Object Type" := JapaneseObjectsHeader."Object Type";
                JapaneseObjectsLine."Object ID" := JapaneseObjectsHeader."Object ID";
                JapaneseObjectsLine."Object Element" := JapaneseObjectsLine."Object Element"::Field;
                JapaneseObjectsLine."Field ID" := FieldInfo."No.";
                JapaneseObjectsLine."Field Name" := FieldInfo.FieldName;
                JapaneseObjectsLine."Field Caption" := FieldInfo."Field Caption";
                JapaneseObjectsLine."Field Caption (Japanese)" := TranslationHelper.GetTranslatedFieldCaption('JPN', JapaneseObjectsLine."Object ID", JapaneseObjectsLine."Field ID");
                JapaneseObjectsLine."Field Data Type" := Format(FieldInfo.Type);
                JapaneseObjectsLine."Field Length" := Format(FieldInfo.Len);
                JapaneseObjectsLine."Field Class" := Format(FieldInfo.Class);
                JapaneseObjectsLine."Relation Table No." := FieldInfo.RelationTableNo;
                JapaneseObjectsLine."Relation Field No." := FieldInfo.RelationFieldNo;
                JapaneseObjectsLine."Option String" := FieldInfo.OptionString;
                JapaneseObjectsLine.IsPartOfPrimaryKey := FieldInfo.IsPartOfPrimaryKey;
                JapaneseObjectsLine."App Package ID" := FieldInfo."App Package ID";
                JapaneseObjectsLine."App Runtime Package ID" := FieldInfo."App Runtime Package ID";
                JapaneseObjectsLine.Insert();
            until FieldInfo.Next() = 0;
    end;

    procedure UpdateJapaneseCaptionHeader(JapaneseObjectsHeader: Record "Japanese Objects Header")
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        if GlobalLanguage = 1041 then begin
            AllObjWithCaption.Reset();
            AllObjWithCaption.SetCurrentKey("Object Type", "Object ID");
            AllObjWithCaption.SetRange("Object Type", JapaneseObjectsHeader."Object Type");
            AllObjWithCaption.SetRange("Object ID", JapaneseObjectsHeader."Object ID");
            if AllObjWithCaption.FindFirst() then begin
                JapaneseObjectsHeader."Object Caption (Japanese)" := AllObjWithCaption."Object Caption";
                JapaneseObjectsHeader.Modify();
            end;
        end else
            Message(JpnCaptionLbl);
    end;

    procedure UpdateJapaneseCaptionLines(JapaneseObjectsHeader: Record "Japanese Objects Header")
    var
        JapaneseObjectsLine: Record "Japanese Objects Line";
        FieldInfo: Record Field;

    begin
        if GlobalLanguage = 1041 then begin
            JapaneseObjectsLine.Reset();
            JapaneseObjectsLine.SetRange("Entry No.", JapaneseObjectsHeader."Entry No.");
            JapaneseObjectsLine.SetRange("App Name", JapaneseObjectsHeader."App Name");
            JapaneseObjectsLine.SetRange("Object Type", JapaneseObjectsHeader."Object Type");
            JapaneseObjectsLine.SetRange("Object ID", JapaneseObjectsHeader."Object ID");
            if JapaneseObjectsLine.FindSet() then
                repeat
                    FieldInfo.Reset();
                    FieldInfo.SetCurrentKey(TableNo, "No.");
                    FieldInfo.SetRange(TableNo, JapaneseObjectsLine."Object ID");
                    FieldInfo.SetRange("No.", JapaneseObjectsLine."Field ID");
                    if FieldInfo.FindFirst() then;
                    if JapaneseObjectsLine."Object Element" = JapaneseObjectsLine."Object Element"::Field then
                        JapaneseObjectsLine."Field Caption (Japanese)" := FieldInfo."Field Caption";
                    JapaneseObjectsLine.Modify();
                until JapaneseObjectsLine.Next() = 0;
        end else
            Message(JpnCaptionLbl);
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
        Clear("Page Type");
        Clear("Object Name");
        Clear("Object Caption");
        Clear("Object Caption (Japanese)");
        Clear("Source Object ID");
        Clear("Source Object Name");
        Clear("Extends Object Type");
        Clear("Extends Object ID");
        Clear("Extends Object Name");
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
                //InsertJpnChangelogLine."Object ID" := Rec."Object ID";
                InsertJpnChangelogLine.Insert();
            end;
        end;
    end;

    procedure ErrorIfSalesLinesExist(ChangedFieldName: Text[100]; JapaneseObjectsHeader: Record "Japanese Objects Header")
    var
        MessageText: Text;
    begin
        if JapaneseObjectLinesExist(JapaneseObjectsHeader) then begin
            MessageText := StrSubstNo(LinesNotUpdatedMsg, ChangedFieldName);
            Error(MessageText);
        end;
    end;

    procedure JapaneseObjectLinesExist(JapaneseObjectsHeader: Record "Japanese Objects Header"): Boolean
    var
        JapaneseObjectsLine: Record "Japanese Objects Line";
    begin
        JapaneseObjectsLine.Reset();
        JapaneseObjectsLine.SetRange("Entry No.", JapaneseObjectsHeader."Entry No.");
        exit(not JapaneseObjectsLine.IsEmpty());
    end;

    var

        LinesNotUpdatedMsg: Label 'There is already object lines existing. you can not change anything at this time. Please delete object lines and update again.';
        JpnCaptionLbl: Label 'No Japanese captions updated. To update Japanese captions, please choose Japanese language from my settings and update.';
}