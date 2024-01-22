table 99101 "TJP Change Log Header"
{
    Caption = 'TJP - Change Log Header';
    fields
    {
        field(1; "App Category"; Enum "App Category TJP")
        {
            Caption = 'App Category';
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    GetTJPChangeLogSetup();
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
        key(Key1; "App Category", "No.")
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

    local procedure GetTJPChangeLogSetup()
    begin
        TJPChangeLogSetup.Get();
    end;

    procedure GetNoSeriesCode(): Code[20]
    var
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
    begin
        GetTJPChangeLogSetup();
        NoSeriesCode := TJPChangeLogSetup."Enhancement Nos.";
    end;

    procedure TestNoSeries()
    begin
        GetTJPChangeLogSetup();
        TJPChangeLogSetup.TestField("Enhancement Nos.");
    end;

    procedure AssistEdit(OldTJPChangeLogHeader: Record "TJP Change Log Header") Result: Boolean
    var
        TJPChangeLogHeader2: Record "TJP Change Log Header";
        IsHandled: Boolean;
    begin
        Copy(Rec);
        GetTJPChangeLogSetup();
        TestNoSeries();
        if NoSeriesMgt.SelectSeries(GetNoSeriesCode(), OldTJPChangeLogHeader."No. Series", "No. Series") then begin
        end;
        NoSeriesMgt.SetSeries("No.");
        if TJPChangeLogHeader2.Get("App Category", "No.") then
            Error(Text051, LowerCase(Format("App Category")), "No.");
        Rec := TJPChangeLogHeader;
        exit(true);
    end;

    var
        TJPChangeLogSetup: Record "TJP Change Log Setup";
        TJPChangeLogHeader: Record "TJP Change Log Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text051: Label 'The change log header %1 %2 already exists.';
}