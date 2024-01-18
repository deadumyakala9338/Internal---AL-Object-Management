page 99101 "Object Information Card TJP"
{
    ApplicationArea = All;
    Caption = 'Object Information';
    PageType = Card;
    SourceTable = "Object Information TJP";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Object Type"; Rec."Object Type") { }
                field("Object ID"; Rec."Object ID") { }
                field("Object Name"; Rec."Object Name") { }
                field("Object Caption (ENG)"; Rec."Object Caption (ENG)") { }
                field("Object Caption (JPN)"; Rec."Object Caption (JPN)") { }
            }
        }
    }
}
