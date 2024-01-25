page 99100 "Japanese All Objects List"
{
    ApplicationArea = All;
    Caption = 'Japanese All Objects';
    CardPageId = "Japanese All Objects Card";
    PageType = List;
    SourceTable = "Japanese All Objects";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("App Name"; Rec."App Name")
                {
                    ApplicationArea = Basic, Suite;
                    Style = Strong;
                }
                field("Object Category"; Rec."Object Category")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
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
                field("Extends Object ID"; Rec."Extends Object ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Extends Object Name"; Rec."Extends Object Name")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}

