table 99102 "TJP Change Log Setup"
{
    Caption = 'TJP - Change Log Setup';
    DrillDownPageID = "TJP Change Log Setup";
    LookupPageID = "TJP Change Log Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(5; "Enhancement Nos."; Code[20])
        {
            Caption = 'Enhancement Nos.';
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}