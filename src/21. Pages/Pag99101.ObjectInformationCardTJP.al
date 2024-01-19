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

                field("Object ID"; Rec."Object ID") { }
                field("Object Name"; Rec."Object Name") { }
                field("Object Caption"; Rec."Object Caption") { }
                field("Object Caption (Japanese)"; Rec."Object Caption (Japanese)") { }
                field("Extends Object ID"; Rec."Extends Object ID") { }
                field("Extends Object Name"; Rec."Extends Object Name") { }
                field("Field ID"; Rec."Field ID") { }
                field("Field Name"; Rec."Field Name") { }
                field("Field Caption"; Rec."Field Caption") { }
                field("Field Caption (Japanese)"; Rec."Field Caption (Japanese)") { }
                field("Field Data Type"; Rec."Field Data Type") { }
                field("Field Length"; Rec."Field Length") { }
            }
            group("Page&TableExtension")
            {
                Caption = 'Page & Page Extension';
                Visible = PageTabVisible;

                field(PageObjectType; Rec."Object ID") { }
                field(PageObjectName; Rec."Object Name") { }
                field(PageObjectCaption; Rec."Object Caption") { }
                field(PageObjectCaptionJpn; Rec."Object Caption (Japanese)") { }
                field(PageExtendsObjectID; Rec."Extends Object ID") { }
                field(PageExtendsObjectName; Rec."Extends Object Name") { }
                field(PageFieldName; Rec."Field Name") { }
                field(PageFieldCaption; Rec."Field Caption") { }
                field(PageFieldCaptionJpn; Rec."Field Caption (Japanese)") { }
                field(ToolTip; Rec.ToolTip) { }
                field("ToolTip (Japanese)"; Rec."ToolTip (Japanese)") { }
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
