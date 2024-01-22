page 99104 "TJP Change Log Subform"
{
    AutoSplitKey = true;
    ApplicationArea = All;
    Caption = 'TJP Change Log Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "TJP Change Log Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("App Category"; Rec."App Category")
                {
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("Object Type"; Rec."Object Type") { }
                field("Object ID"; Rec."Object ID") { }
                field("Line Change Log"; Rec."Line Change Log") { }
            }
        }
    }
}
