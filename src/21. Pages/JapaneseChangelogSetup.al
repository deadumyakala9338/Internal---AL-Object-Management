page 99105 "Japanese Changelog Setup"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Japanese Changelog Setup';
    PageType = Card;
    SourceTable = "Japanese Changelog Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Enhancement Nos."; Rec."Enhancement Nos.") { }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
