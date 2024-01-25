page 99104 "Japanese Changelog Subform"
{
    AutoSplitKey = true;
    ApplicationArea = All;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Japanese Changelog Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("App Name"; Rec."App Name")
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
