page 99109 "Japanese Objects Card"
{
    ApplicationArea = All;
    Caption = 'Japanese Objects';
    PageType = Document;
    SourceTable = "Japanese Objects Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("App Name"; Rec."App Name") { }
                field("Object Type"; Rec."Object Type") { }
                field("Object ID"; Rec."Object ID") { }
                field("Object Name"; Rec."Object Name") { }
                field("Object Caption"; Rec."Object Caption") { }
                field("Object Caption (Japanese)"; Rec."Object Caption (Japanese)") { }
                field("Extends Object Type"; Rec."Extends Object Type") { }
                field("Extends Object ID"; Rec."Extends Object ID") { }
                field("Extends Object Name"; Rec."Extends Object Name") { }
                field("Source Object ID"; Rec."Source Object ID")
                {
                    Editable = Rec."Object Type" = Rec."Object Type"::"Page";
                }
                field("Source Object Name"; Rec."Source Object Name") { }
                field("Creation By"; Rec."Creation By") { }
                field("Creation Date"; Rec."Creation Date") { }
                field("Last Modified By"; Rec."Last Modified By") { }
                field("Last Modified Date"; Rec."Last Modified Date") { }
            }
            part(Lines; "Japanese Objects Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Entry No." = field("Entry No.");
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(UpdateObjectDetails)
            {
                Caption = 'Update Object Details.';
                ApplicationArea = Basic, Suite;
                Image = UpdateDescription;

                trigger OnAction()
                var
                    JapaneseObjectsHeader: Record "Japanese Objects Header";
                begin
                    JapaneseObjectsHeader.UpdateJapaneseObjectLineDetails(Rec);
                end;
            }
            action(UpdateJapaneseCaptions)
            {
                Caption = 'Update Japanese Captions.';
                ApplicationArea = Basic, Suite;
                Image = UpdateDescription;

                trigger OnAction()
                var
                    JapaneseObjectsHeader: Record "Japanese Objects Header";
                begin
                    JapaneseObjectsHeader.UpdateJapaneseCaptionHeader(Rec);
                    JapaneseObjectsHeader.UpdateJapaneseCaptionLines(Rec);
                end;
            }
        }
    }
}
