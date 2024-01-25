page 99109 "Japanese Objects Card"
{
    ApplicationArea = All;
    Caption = 'Japanese Objects';
    PageType = Document;
    SourceTable = "Japanese Objects Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("App Name"; Rec."App Name") { }
                field("Object Type"; Rec."Object Type")
                {
                    trigger OnValidate()
                    begin
                        InitializeVisibleVariables();
                    end;
                }
                field("Object ID"; Rec."Object ID") { }
                field("Object Category"; Rec."Object Category") { }
            }
            group("Table&TableExtension")
            {
                Caption = 'Table & Table Extension';
                Visible = TableTabVisible;

                group(TableRelated)
                {
                    ShowCaption = false;
                    Visible = Rec."Object Type" = Rec."Object Type"::"Table";
                    field(TableObjectName; Rec."Object Name") { }
                    field(TableObjectCaption; Rec."Object Caption") { }
                    field(TableObjectCaptionJpn; Rec."Object Caption (Japanese)") { }
                }
                group(TableExtensionRelated)
                {
                    ShowCaption = false;
                    Visible = Rec."Object Type" = Rec."Object Type"::"TableExtension";
                    field(TableExtendsObjectType; Rec."Extends Object Type") { }
                    field(TableExtendsObjectID; Rec."Extends Object ID") { }
                    field(TableExtendsObjectName; Rec."Extends Object Name") { }
                }
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
                field(PageObjectName; Rec."Object Name") { }
                field(PageObjectCaption; Rec."Object Caption") { }
                field(PageObjectCaptionJpn; Rec."Object Caption (Japanese)") { }
                group(PageExtensionRelatedPage)
                {
                    ShowCaption = false;
                    Visible = Rec."Object Type" = Rec."Object Type"::"Page";
                    field(PageSourceObjectID; Rec."Source Object ID") { }
                    field(PageSourceObjectName; Rec."Source Object Name") { }
                }
                group(PageExtensionRelated)
                {
                    ShowCaption = false;
                    Visible = Rec."Object Type" = Rec."Object Type"::"PageExtension";
                    field(PageExtendsObjectType; Rec."Extends Object Type") { }
                    field(PageExtendsObjectID; Rec."Extends Object ID") { }
                    field(PageExtendsObjectName; Rec."Extends Object Name") { }
                }
                field(PageObjectElement; Rec."Object Element") { }
                field(PageFieldName; Rec."Field Name") { }
                field(PageFieldCaption; Rec."Field Caption") { }
                field(PageFieldCaptionJpn; Rec."Field Caption (Japanese)") { }
                field(PageToolTip; Rec.ToolTip) { }
                field(PageToolTipJpn; Rec."ToolTip (Japanese)") { }
            }
            part(Lines; "Japanese Objects Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "App Name" = field("App Name"), "Object Type" = field("Object Type"), "Object ID" = field("Object ID");
                UpdatePropagation = Both;
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
        InsertRecord: Boolean;

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
