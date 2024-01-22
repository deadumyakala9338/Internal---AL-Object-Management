page 99102 "TJP Change Log List"
{
    ApplicationArea = Basic, Suite;
    Caption = 'TJP - Change Logs';
    CardPageId = "TJP Change Log";
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "TJP Change Log Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.") { }
                field("App Category"; Rec."App Category") { }
                field("Change Remarks"; Rec."Change Remarks") { }
            }
        }
    }
}
