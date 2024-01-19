page 99101 "Object Information Card TJP"
{
    ApplicationArea = All;
    Caption = 'Object Information';
    PageType = Card;
    SourceTable = "Object Information TJP";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.") { }
                field("Entry Type"; Rec."Entry Type") { }
                field("App Category"; Rec."App Category") { }
                field("App Subcategory"; Rec."App Subcategory") { }
                field("Object Type"; Rec."Object Type")
                {
                    trigger OnValidate()
                    begin
                        InitializeVisibleVariables();
                    end;
                }
            }
            group("Table&TableExtension")
            {
                Caption = 'Table & Table Extension';
                Visible = TableTabVisible;

                field(TableObjectID; Rec."Object ID") { }
                field(TableObjectName; Rec."Object Name") { }
                field(TableObjectCaption; Rec."Object Caption") { }
                field(TableObjectCaptionJpn; Rec."Object Caption (Japanese)") { }
                field(TableExtendsObjectID; Rec."Extends Object ID") { }
                field(TableExtendsObjectName; Rec."Extends Object Name") { }
                field(TableObjectElement; Rec."Object Element") { }
                field(TableFieldID; Rec."Field ID") { }
                field(TableFieldName; Rec."Field Name") { }
                field(TableFieldCaption; Rec."Field Caption") { }
                field(TableFieldCaptionJpn; Rec."Field Caption (Japanese)") { }
                field(TableFieldDataType; Rec."Field Data Type") { }
                field(TableFieldLength; Rec."Field Length") { }
            }
            group("Page&TableExtension")
            {
                Caption = 'Page & Page Extension';
                Visible = PageTabVisible;

                field(PageObjectType; Rec."Page Type") { }
                field(PageObjectID; Rec."Object ID") { }
                field(PageObjectName; Rec."Object Name") { }
                field(PageObjectCaption; Rec."Object Caption") { }
                field(PageObjectCaptionJpn; Rec."Object Caption (Japanese)") { }
                field(PageSourceObjectID; Rec."Source Object ID") { }
                field(PageSourceObjectName; Rec."Source Object Name") { }
                field(PageExtendsObjectID; Rec."Extends Object ID") { }
                field(PageExtendsObjectName; Rec."Extends Object Name") { }
                field(PageObjectElement; Rec."Object Element") { }
                field(PageFieldName; Rec."Field Name") { }
                field(PageFieldCaption; Rec."Field Caption") { }
                field(PageFieldCaptionJpn; Rec."Field Caption (Japanese)") { }
                field(PageToolTip; Rec.ToolTip) { }
                field(PageToolTipJpn; Rec."ToolTip (Japanese)") { }
            }
        }
    }
    trigger OnOpenPage()
    begin
        InitializeVisibleVariables();
    end;

    trigger OnAfterGetRecord()
    begin
        InitializeVisibleVariables();
    end;

    var
        TableTabVisible, PageTabVisible, ReportTabVisible, CodeunitTabVisible, PermSetTabVisible, ProfileTabVisible : Boolean;

    local procedure InitializeVisibleVariables()
    begin
        TableTabVisible := false;
        PageTabVisible := false;
        ReportTabVisible := false;
        CodeunitTabVisible := false;
        PermSetTabVisible := false;
        ProfileTabVisible := false;

        case Rec."Object Type" of
            Rec."Object Type"::"TableData":
                SetTabsVisible(true, false, false, false, false, false);
            Rec."Object Type"::"Table":
                SetTabsVisible(true, false, false, false, false, false);
            Rec."Object Type"::"TableExtension":
                SetTabsVisible(true, false, false, false, false, false);
            Rec."Object Type"::"Page":
                SetTabsVisible(false, true, false, false, false, false);
            Rec."Object Type"::"PageExtension":
                SetTabsVisible(false, true, false, false, false, false);
        end;
    end;

    local procedure SetTabsVisible(NewTableTabVisible: Boolean; NewPageTabVisible: Boolean; NewReportTabVisible: Boolean;
                                   NewCodeunitTabVisible: Boolean; NewPermSetTabVisible: Boolean; NewProfileTabVisible: Boolean)
    begin
        TableTabVisible := NewTableTabVisible;
        PageTabVisible := NewPageTabVisible;
        ReportTabVisible := NewReportTabVisible;
        CodeunitTabVisible := NewCodeunitTabVisible;
        PermSetTabVisible := NewPermSetTabVisible;
        ProfileTabVisible := NewProfileTabVisible;
    end;
}
