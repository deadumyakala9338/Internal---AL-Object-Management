page 99103 "Japanese Objects Subform Enum"
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
                field("Element ID"; Rec."Element ID") { }
                field("Element Name"; Rec."Element Name") { }
                field("Field Caption"; Rec."Field Caption") { }
                field("Field Caption (Japanese)"; Rec."Field Caption (Japanese)") { }
            }
        }
    }
}