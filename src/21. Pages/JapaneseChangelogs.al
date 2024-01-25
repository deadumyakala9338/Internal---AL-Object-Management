page 99102 "Japanese Changelog List"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Japanese Changelogs';
    CardPageId = "Japanese Changelog";
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Japanese Changelog Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.") { }
                field("App Name"; Rec."App Name") { }
                field("Change Remarks"; Rec."Change Remarks") { }
            }
        }
    }
}
