page 99108 "Japanese Objects List"
{
    ApplicationArea = All;
    Caption = 'Japanese Objects';
    CardPageId = "Japanese Objects Card";
    PageType = List;
    SourceTable = "Japanese Objects Header";
    UsageCategory = Lists;
    ModifyAllowed = false;

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

