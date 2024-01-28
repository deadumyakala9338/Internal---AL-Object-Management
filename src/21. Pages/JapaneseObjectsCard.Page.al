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
                field("Object Name"; Rec."Object Name") { }
                field("Object Caption"; Rec."Object Caption") { }
                field("Object Caption (Japanese)"; Rec."Object Caption (Japanese)") { }

                field("Extends Object Type"; Rec."Extends Object Type") { }
                field("Extends Object ID"; Rec."Extends Object ID") { }
                field("Extends Object Name"; Rec."Extends Object Name") { }
                field("Source Object ID"; Rec."Source Object ID")
                {
                    Editable = Rec."Object Type" = Rec."Object Type"::"Page";
                }
                field("Source Object Name"; Rec."Source Object Name") { }
                field("Object Category"; Rec."Object Category") { }
            }
            part(Lines; "Japanese Objects Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Entry No." = field("Entry No.");
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
