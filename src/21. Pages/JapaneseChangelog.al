page 99103 "Japanese Changelog"
{
    ApplicationArea = All;
    Caption = 'Japanese ChangeLog';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Japanese Changelog Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("App Name"; Rec."App Name") { }
                field("No."; Rec."No.")
                {
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Change Remarks"; Rec."Change Remarks")
                {
                }
            }
            part("JapaneseChangelogLinese"; "Japanese Changelog Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "App Name" = field("App Name"), "Document No." = field("No.");
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ExportTemplate)
            {
                ApplicationArea = All;
                Caption = 'Open Change Log Document.';
                Image = Open;
                RunObject = page "Japanese Changelog List";
            }
        }
    }
}
