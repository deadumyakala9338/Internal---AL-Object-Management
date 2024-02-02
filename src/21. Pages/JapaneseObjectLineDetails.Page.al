page 99105 "Japanese Object Lines"
{
    ApplicationArea = All;
    Caption = 'Japanese Object Lines';
    PageType = List;
    SourceTable = "Japanese Objects Line";
    DeleteAllowed = false;
    ModifyAllowed = false;
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
                field("Object Element"; Rec."Object Element") { }
                field("Field ID"; Rec."Field ID") { }
                field("Field Name"; Rec."Field Name") { }
                field("Field Caption"; Rec."Field Caption") { }
                field("Field Caption (Japanese)"; Rec."Field Caption (Japanese)") { }
                field("Field Data Type"; Rec."Field Data Type") { }
                field("Field Length"; Rec."Field Length") { }
                field(ToolTip; Rec.ToolTip) { }
                field("ToolTip (Japanese)"; Rec."ToolTip (Japanese)") { }
                field("Event Object Type"; Rec."Event Object Type") { }
                field("Event Object Name"; Rec."Event Object Name") { }
                field("Event Name"; Rec."Event Name") { }
                field("Event Element Name"; Rec."Event Element Name") { }
                field("Procedure Name"; Rec."Procedure Name") { }
                field("Element ID"; Rec."Element ID") { }
                field("Element Name"; Rec."Element Name") { }
                field(Brief; Rec.Brief) { }
            }
        }
    }
}