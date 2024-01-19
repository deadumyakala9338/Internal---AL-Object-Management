page 99100 "Object Information List TJP"
{
    ApplicationArea = All;
    Caption = 'Object Information (Japanese)';
    CardPageId = "Object Information Card TJP";
    PageType = List;
    SourceTable = "Object Information TJP";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Style = Strong;
                }
                field("Object Type"; Rec."Object Type")
                {
                    ApplicationArea = Basic, Suite;
                    Style = Strong;
                }
                field("Object ID"; Rec."Object ID")
                {
                    ApplicationArea = Basic, Suite;
                    Style = Strong;
                }
                field("Object Name"; Rec."Object Name")
                {
                    ApplicationArea = Basic, Suite;
                    Style = Strong;
                }
                field("Object Caption"; Rec."Object Caption")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Object Caption (Japanese)"; Rec."Object Caption (Japanese)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Extends Object ID"; Rec."Extends Object ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Extends Object Name"; Rec."Extends Object Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Field ID"; Rec."Field ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Field Caption (Japanese)"; Rec."Field Caption (Japanese)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Field Data Type"; Rec."Field Data Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Field Length"; Rec."Field Length")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("App Category"; Rec."App Category")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("App Subcategory"; Rec."App Subcategory")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}

