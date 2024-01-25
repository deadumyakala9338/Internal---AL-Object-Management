page 99106 "Japanese App Information List"
{
    ApplicationArea = All;
    Caption = 'Japanese App Information';
    CardPageId = "Japanese App Information";
    PageType = List;
    SourceTable = "Japanese App Information";
    UsageCategory = Lists;
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("App ID"; Rec."App ID") { }
                field("App Name"; Rec."App Name") { }
                field("App Publisher"; Rec."App Publisher") { }
                field("App Package ID"; Rec."App Package ID") { }
            }
        }
    }
}
