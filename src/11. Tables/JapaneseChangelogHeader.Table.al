table 99102 "Japanese Changelog Header"
{
    Caption = 'Japanese Changelog Header';
    fields
    {
        field(1; "App Name"; Text[250])
        {
            Caption = 'App Name';
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    GetJpnChangeLogSetup();
                    NoSeriesMgt.TestManual(GetNoSeriesCode());
                    "No. Series" := '';
                end;
            end;
        }
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(11; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(12; "Change Remarks"; Text[500])
        {
            Caption = 'Change Remarks';
        }
    }

    keys
    {
        key(Key1; "App Name", "No.")
        {
            Clustered = true;
        }
    }

    procedure InitInsert()
    begin
        if "No." = '' then begin
            TestNoSeries();
            NoSeriesMgt.InitSeries(GetNoSeriesCode(), xRec."No. Series", "Posting Date", "No.", "No. Series");
        end;
    end;

    local procedure GetJpnChangeLogSetup()
    begin
        JpnChangelogSetup.Get();
    end;

    procedure GetNoSeriesCode(): Code[20]
    var
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
    begin
        GetJpnChangeLogSetup();
        NoSeriesCode := JpnChangelogSetup."Enhancement Nos.";
    end;

    procedure TestNoSeries()
    begin
        GetJpnChangeLogSetup();
        JpnChangelogSetup.TestField("Enhancement Nos.");
    end;

    procedure AssistEdit(OldJapaneseChangelogHeader: Record "Japanese Changelog Header") Result: Boolean
    var
        JapaneseChangelogHeader2: Record "Japanese Changelog Header";
    begin
        Copy(Rec);
        GetJpnChangeLogSetup();
        TestNoSeries();
        if NoSeriesMgt.SelectSeries(GetNoSeriesCode(), OldJapaneseChangelogHeader."No. Series", "No. Series") then begin
        end;
        NoSeriesMgt.SetSeries("No.");
        if JapaneseChangelogHeader2.Get("App Name", "No.") then
            Error(Text051, LowerCase(Format("App Name")), "No.");
        Rec := JpnChangelogHeader;
        exit(true);
    end;

    var
        JpnChangelogSetup: Record "Japanese Changelog Setup";
        JpnChangelogHeader: Record "Japanese Changelog Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text051: Label 'The change log header %1 %2 already exists.';
}