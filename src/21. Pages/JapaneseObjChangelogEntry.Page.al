page 99102 "Japanese Obj. Changelog Entry"
{
    ApplicationArea = All;
    Caption = 'Object Changelog Entry';
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Japanese Changelog Line";
    Editable = false;
    InsertAllowed = false;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("App Name"; Rec."App Name") { }
                field("Object Type"; Rec."Object Type") { }
                field("Object ID"; Rec."Object ID") { }
                field("Change Log Reason"; Rec."Change Log Reason") { }
                field("Log Creation By"; Rec."Log Creation By") { }
                field("Log Creation Date"; Rec."Log Creation Date") { }
                field("Last Modified By"; Rec."Last Modified By") { }
                field("Last Modified Date"; Rec."Last Modified Date") { }
            }
        }
    }
}
