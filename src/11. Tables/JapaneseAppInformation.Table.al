table 99100 "Japanese App Information"
{
    Caption = 'Japanese App Information';
    DataPerCompany = false;
    ReplicateData = false;
    LookupPageId = "Japanese App Information List";
    DrillDownPageId = "Japanese App Information List";

    fields
    {
        field(2; "App Name"; Text[250])
        {
            Caption = 'App Name';
            Editable = false;
        }
        field(3; "App ID"; Text[250])
        {
            Caption = 'App ID';
            TableRelation = "NAV App Installed App" where(Publisher = filter('Tectura Japan K.K.'));
            trigger OnValidate()
            var
                NAVAppInstalledApp: Record "NAV App Installed App";
            begin
                if NAVAppInstalledApp.Get("App ID") then;
                Rec."App Name" := NAVAppInstalledApp.Name;
                Rec."App Publisher" := NAVAppInstalledApp.Publisher;
                Rec."App Package ID" := DelChr(NAVAppInstalledApp."Package ID", '<>', '{}');
            end;
        }
        field(5; "App Package ID"; Guid)
        {
            Caption = 'App Package ID';
            Editable = false;
        }
        field(6; "App Runtime Package ID"; Text[250])
        {
            Caption = 'App Runtime Package ID';
            Editable = false;
        }
        field(7; "App Publisher"; Text[250])
        {
            Caption = 'App Publisher';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "App Name", "App ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "App Name", "App Publisher", "App ID")
        {
        }
    }
}

