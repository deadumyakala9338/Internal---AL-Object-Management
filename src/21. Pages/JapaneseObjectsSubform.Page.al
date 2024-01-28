page 99110 "Japanese Objects Subform"
{
    AutoSplitKey = true;
    ApplicationArea = All;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Japanese Objects Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Object Element"; Rec."Object Element") { }
                field("Object Type"; Rec."Object Type") { }
                field("Object ID"; Rec."Object ID") { }
                field("Field ID"; Rec."Field ID")
                {
                    Editable = Rec."Object Type" = Rec."Object Type"::"Table";
                }
                field("Field Name"; Rec."Field Name") { }
                field("Field Caption"; Rec."Field Caption") { }
                field("Field Caption (Japanese)"; Rec."Field Caption (Japanese)") { }
                field("Field Data Type"; Rec."Field Data Type") { }
                field("Field Length"; Rec."Field Length") { }
                field("Field Class"; Rec."Field Class") { }
                field(IsPartOfPrimaryKey; Rec.IsPartOfPrimaryKey) { }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(DeleteData)
            {
                Caption = 'Delete Data';
                ApplicationArea = Basic, Suite;
                Image = Delete;

                trigger OnAction()
                var
                    JapaneseObjectsLine: Record "Japanese Objects Line";
                begin
                    JapaneseObjectsLine.Reset();
                    JapaneseObjectsLine.DeleteAll();
                end;
            }
        }
    }
}