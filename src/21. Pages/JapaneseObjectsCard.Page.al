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
                    Editable = Rec."Object Type" = Rec."Object Type"::Page;
                }
                field("Source Object Name"; Rec."Source Object Name") { }
                field(Status; Rec.Status) { }
            }
            part(LinesTable; "Japanese Objects Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Entry No." = field("Entry No.");
                UpdatePropagation = Both;
                Visible = TablePageVisible;
            }
            part(LinesPage; "Japanese Objects Subform Page")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Entry No." = field("Entry No.");
                UpdatePropagation = Both;
                Visible = PagePageVisible;
            }
            part(LinesCU; "Japanese Objects Subform CU")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Entry No." = field("Entry No.");
                UpdatePropagation = Both;
                Visible = CodeunitPageVisible;
            }
            part(LinesRep; "Japanese Objects Subform Rep.")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Entry No." = field("Entry No.");
                UpdatePropagation = Both;
                Visible = ReportPagedVisible;
            }
            part(LinesEnum; "Japanese Objects Subform Enum")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Entry No." = field("Entry No.");
                UpdatePropagation = Both;
                Visible = EnumPageVisible;
            }
            part(LinesOther; "Japanese Objects Subform Other")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Entry No." = field("Entry No.");
                UpdatePropagation = Both;
                Visible = OthersPageVisible;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UpdateObjectDetails)
            {
                Caption = 'Insert Table Linese';
                ApplicationArea = Basic, Suite;
                Image = UpdateDescription;

                trigger OnAction()
                var
                    JapaneseObjectsHeader: Record "Japanese Objects Header";
                begin
                    if Rec.Status <> Rec.Status::Open then
                        Error('Status should be Open');

                    JapaneseObjectsHeader.UpdateJapaneseObjectLineDetails(Rec);
                end;
            }
            action(UpdateJapaneseCaptions)
            {
                Caption = 'Update Japanese Captions.';
                ApplicationArea = Basic, Suite;
                Image = UpdateDescription;
                Visible = false;

                trigger OnAction()
                var
                    JapaneseObjectsHeader: Record "Japanese Objects Header";
                begin
                    if Rec.Status <> Rec.Status::Released then
                        Error('Status should be Released');

                    System.GlobalLanguage(1041);
                    JapaneseObjectsHeader.UpdateJapaneseCaptionHeader(Rec);
                    JapaneseObjectsHeader.UpdateJapaneseCaptionLines(Rec);
                end;
            }
            action(CreateObjectChangeLog)
            {
                Caption = 'Create Object Change Log.';
                ApplicationArea = Basic, Suite;
                Image = InsertFromCheckJournal;

                trigger OnAction()
                var
                    JapaneseObjectChangeLog: Report "Japanese Object Change Log";
                begin
                    if Rec.Status <> Rec.Status::Released then
                        Error('Status should be Released');

                    JapaneseObjectChangeLog.SetObjectInfo(Rec."Entry No.");
                    JapaneseObjectChangeLog.RunModal();
                end;
            }
            action(JapaneseObjectChangeLogEntry)
            {
                Caption = 'Object Changelog Entry';
                ApplicationArea = Basic, Suite;
                Image = LedgerEntries;
                RunObject = page "Japanese Obj. Changelog Entry";
                RunPageLink = "Entry No." = field("Entry No.");
            }
            group(Action21)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;

                    trigger OnAction()
                    var
                        JapaneseObjectsHeader: Record "Japanese Objects Header";
                    begin
                        JapaneseObjectsHeader.Reset();
                        JapaneseObjectsHeader.SetRange("Entry No.", Rec."Entry No.");
                        if JapaneseObjectsHeader.FindFirst() then begin
                            JapaneseObjectsHeader.Status := JapaneseObjectsHeader.Status::Released;
                            JapaneseObjectsHeader.Modify();
                        end;
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re&open';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        JapaneseObjectsHeader: Record "Japanese Objects Header";
                    begin
                        JapaneseObjectsHeader.Reset();
                        JapaneseObjectsHeader.SetRange("Entry No.", Rec."Entry No.");
                        if JapaneseObjectsHeader.FindFirst() then begin
                            JapaneseObjectsHeader.Status := JapaneseObjectsHeader.Status::Open;
                            JapaneseObjectsHeader.Modify();
                        end;
                    end;
                }
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

    trigger OnClosePage()
    var
        JapaneseObjectsHeader: Record "Japanese Objects Header";
    begin
        System.GlobalLanguage(1041);
        JapaneseObjectsHeader.UpdateJapaneseCaptionHeader(Rec);
    end;

    var
        TablePageVisible, PagePageVisible, CodeunitPageVisible, ReportPagedVisible, EnumPageVisible, OthersPageVisible : Boolean;
        UpdateJpnCaption: Boolean;

    local procedure InitializeVisibleVariables()
    begin
        TablePageVisible := false;
        PagePageVisible := false;
        CodeunitPageVisible := false;
        ReportPagedVisible := false;
        EnumPageVisible := false;
        OthersPageVisible := false;

        case Rec."Object Type" of
            Rec."Object Type"::"Table":
                SetJpnLineFieldsVisible(true, false, false, false, false, false);
            Rec."Object Type"::"TableExtension":
                SetJpnLineFieldsVisible(true, false, false, false, false, false);
            Rec."Object Type"::"Page":
                SetJpnLineFieldsVisible(false, true, false, false, false, false);
            Rec."Object Type"::"PageExtension":
                SetJpnLineFieldsVisible(false, true, false, false, false, false);
            Rec."Object Type"::"Codeunit":
                SetJpnLineFieldsVisible(false, false, true, false, false, false);
            Rec."Object Type"::"Report":
                SetJpnLineFieldsVisible(false, false, false, true, false, false);
            Rec."Object Type"::"ReportExtension":
                SetJpnLineFieldsVisible(false, false, false, true, false, false);
            Rec."Object Type"::"Enum":
                SetJpnLineFieldsVisible(false, false, false, false, true, false);
            Rec."Object Type"::"EnumExtension":
                SetJpnLineFieldsVisible(false, false, false, false, true, false);
            Rec."Object Type"::"PermissionSet":
                SetJpnLineFieldsVisible(false, false, false, false, false, true);
            Rec."Object Type"::"PermissionSetExtension":
                SetJpnLineFieldsVisible(false, false, false, false, false, true);
            Rec."Object Type"::"Profile":
                SetJpnLineFieldsVisible(false, false, false, false, false, true);
        end;
    end;

    local procedure SetJpnLineFieldsVisible(NewTablePageVisible: Boolean; NewPagePageVisible: Boolean; NewCodeunitPageVisible: Boolean;
                                            NewReportPagedVisible: Boolean; NewEnumPageVisible: Boolean; NewOthersPageVisible: Boolean)
    begin
        TablePageVisible := NewTablePageVisible;
        PagePageVisible := NewPagePageVisible;
        CodeunitPageVisible := NewCodeunitPageVisible;
        ReportPagedVisible := NewReportPagedVisible;
        EnumPageVisible := NewEnumPageVisible;
        OthersPageVisible := NewOthersPageVisible;
    end;
}
