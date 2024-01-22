page 99105 "TJP Change Log Setup"
{
    ApplicationArea = Basic, Suite;
    Caption = 'TJP Change Log Setup';
    PageType = Card;
    SourceTable = "TJP Change Log Setup";
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
