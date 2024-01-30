page 99110 "Japanese Objects Subform"
{
    AutoSplitKey = true;
    ApplicationArea = All;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Japanese Objects Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Object Element"; Rec."Object Element") { }
                field("Field ID"; Rec."Field ID")
                {
                    Editable = Rec."Object Type" = Rec."Object Type"::"Table";
                }
                field("Field Name"; Rec."Field Name")
                {
                }
                field("Field Caption"; Rec."Field Caption")
                {
                }
                field("Field Caption (Japanese)"; Rec."Field Caption (Japanese)")
                {
                }
                field("Field Data Type"; Rec."Field Data Type")
                {
                }
                field("Field Length"; Rec."Field Length")
                {
                }
                field(IsPartOfPrimaryKey; Rec.IsPartOfPrimaryKey)
                {
                }
                field("Procedure Name"; Rec."Procedure Name")
                {
                }
                field("Event Name"; Rec."Event Name")
                {
                }
                field("Event Element Name"; Rec."Event Element Name")
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(DeleteData)
            {
                Caption = 'Delete Data';
                ApplicationArea = Basic, Suite;
                Image = Delete;
                Visible = false;

                trigger OnAction()
                var
                    JapaneseObjectsLine: Record "Japanese Objects Line";
                begin
                    JapaneseObjectsLine.Reset();
                    JapaneseObjectsLine.DeleteAll();
                end;
            }
        }
    }
    /*trigger OnOpenPage()
    begin
        InitializeVisibleVariables();
    end;

    trigger OnAfterGetRecord()
    begin
        InitializeVisibleVariables();
    end;

    var
        TableFieldVisible, PageFieldVisible, ReportFieldVisible, CodeunitFieldVisible, PermSetFieldVisible, ProfileFieldVisible : Boolean;

    local procedure InitializeVisibleVariables()
    begin
        TableFieldVisible := false;
        PageFieldVisible := false;
        ReportFieldVisible := false;
        CodeunitFieldVisible := false;
        PermSetFieldVisible := false;
        ProfileFieldVisible := false;

        case Rec."Object Type" of
            Rec."Object Type"::"Table":
                SetJpnLineFieldsVisible(true, false, false, false, false, false);
            Rec."Object Type"::"TableExtension":
                SetJpnLineFieldsVisible(true, false, false, false, false, false);
            Rec."Object Type"::"Page":
                SetJpnLineFieldsVisible(false, true, false, false, false, false);
            Rec."Object Type"::"PageExtension":
                SetJpnLineFieldsVisible(false, true, false, false, false, false);
        end;
    end;

    local procedure SetJpnLineFieldsVisible(NewTableFieldVisible: Boolean; NewPPageFieldVisible: Boolean; NewReportFieldVisible: Boolean;
                                   NewCodeunitFieldVisible: Boolean; NewPermSetFieldVisible: Boolean; NewProfileFieldVisible: Boolean)
    begin
        TableFieldVisible := NewTableFieldVisible;
        PageFieldVisible := NewPPageFieldVisible;
        ReportFieldVisible := NewReportFieldVisible;
        CodeunitFieldVisible := NewCodeunitFieldVisible;
        PermSetFieldVisible := NewPermSetFieldVisible;
        ProfileFieldVisible := NewProfileFieldVisible;
    end;
    */
}