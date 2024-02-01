page 99107 "Japanese App Information"
{
    ApplicationArea = All;
    Caption = 'Japanese App Information';
    PageType = Card;
    SourceTable = "Japanese App Information";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("App ID"; Rec."App ID") { }
                field("App Name"; Rec."App Name") { }
                field("App Publisher"; Rec."App Publisher") { }
                field("App Runtime Package ID"; Rec."App Runtime Package ID") { }
                field("App Package ID"; Rec."App Package ID") { }
            }
        }
    }
}