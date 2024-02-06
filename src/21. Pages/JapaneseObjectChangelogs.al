page 99104 "Japanese Object Changelogs"
{
    ApplicationArea = All;
    Caption = 'Japanese Object Changelogs';
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Japanese Changelog Line";
    //DeleteAllowed = false;
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
                field("Object Name"; Rec."Object Name") { }
                field("Change Log Reason"; Rec."Change Log Reason") { }
                field("Log Creation By"; Rec."Log Creation By") { }
                field("Log Creation Date"; Rec."Log Creation Date") { }
                field("Last Modified By"; Rec."Last Modified By") { }
                field("Last Modified Date"; Rec."Last Modified Date") { }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CreateObjectChangeLog)
            {
                Caption = 'Export Object Change Log.';
                ApplicationArea = Basic, Suite;
                Image = ExportFile;

                RunObject = report "Export Japanese Change Log";
            }
        }
    }
}
