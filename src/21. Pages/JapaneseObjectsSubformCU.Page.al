page 99100 "Japanese Objects Subform CU"
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
                field("Event Object Type"; Rec."Event Object Type") { }
                field("Event Object Name"; Rec."Event Object Name") { }
                field("Event Name"; Rec."Event Name") { }
                field("Event Element Name"; Rec."Event Element Name") { }
                field("Procedure Name"; Rec."Procedure Name") { }
                field(Brief; Rec.Brief) { }
            }
        }
    }
}