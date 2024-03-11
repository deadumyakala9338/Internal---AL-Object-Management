permissionset 99100 "AL OBJECTS TJP"
{
    Assignable = true;
    Caption = 'Barcode Management.';

    Permissions =
        tabledata "Japanese App Information" = RIMD,
        tabledata "Japanese Changelog Line" = RIMD,
        tabledata "Japanese Objects Header" = RIMD,
        tabledata "Japanese Objects Line" = RIMD;
}