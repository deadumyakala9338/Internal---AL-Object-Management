page 99111 "Japanese Objects Subform Page"
{
    AutoSplitKey = true;
    ApplicationArea = All;
    Caption = 'Object Lines';
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
                field("Field Name"; Rec."Field Name") { }
                field("Field Caption"; Rec."Field Caption") { }
                field("Field Caption (Japanese)"; Rec."Field Caption (Japanese)") { }
                field(ToolTip; Rec.ToolTip) { }
                field("ToolTip (Japanese)"; Rec."ToolTip (Japanese)") { }
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
}