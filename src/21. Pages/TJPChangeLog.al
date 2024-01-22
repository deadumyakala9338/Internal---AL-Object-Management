page 99103 "TJP Change Log"
{
    ApplicationArea = All;
    Caption = 'TJP Change Log';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "TJP Change Log Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("App Category"; Rec."App Category")
                {
                }
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
            part(ChangeLogLines; "TJP Change Log Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "App Category" = field("App Category"), "Document No." = field("No.");
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
                RunObject = page "TJP Change Log List";
            }
        }
    }
}
