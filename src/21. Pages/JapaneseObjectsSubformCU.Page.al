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
                field(Name; Rec.Name) { }
                field("Event Name"; Rec."Event Name") { }
                field("Event Element Name"; Rec."Event Element Name") { }
                field(Brief; Rec.Brief) { }
            }
        }
    }
}