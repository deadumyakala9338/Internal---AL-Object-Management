page 99100 "Object Information List TJP"
{
    ApplicationArea = All;
    Caption = 'Object Information List';
    CardPageId = "Object Information Card TJP";
    PageType = List;
    SourceTable = "Object Information TJP";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Object Type"; Rec."Object Type") { }
                field("Object ID"; Rec."Object ID") { }
                field("Object Name"; Rec."Object Name") { }
                field("Object Caption (ENG)"; Rec."Object Caption (ENG)") { }
                field("Object Caption (JPN)"; Rec."Object Caption (JPN)") { }
            }
        }
    }
}
