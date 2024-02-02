page 99112 "Japanese Objects Subform Rep."
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
                field("Object Name"; Rec."Object Name") { }
                field(Brief; Rec.Brief) { }
            }
        }
    }
}