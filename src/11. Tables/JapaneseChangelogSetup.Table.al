table 99103 "Japanese Changelog Setup"
{
    Caption = 'Japanese Changelog Setup';
    DrillDownPageID = "Japanese Changelog Setup";
    LookupPageID = "Japanese Changelog Setup";

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