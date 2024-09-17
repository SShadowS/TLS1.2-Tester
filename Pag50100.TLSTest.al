page 50100 TLSTest
{
    ApplicationArea = All;
    Caption = 'TLSTest';
    PageType = Card;
    SourceTable = Integer;
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(Result; Result)
                {
                    ApplicationArea = All;
                    Caption = 'Test result';
                    Editable = false;
                    Enabled = false;
                    ToolTip = 'The result from the TLS test';

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(TestTLSAction)
            {
                ApplicationArea = All;
                Caption = 'Test TLS';
                Image = TestReport;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Result := TestTLS('https://tlstest.continiaonline.com/api/testendpoint');
                end;
            }
        }
    }

    var
        Result: Text;

    procedure TestTLS(URL: Text): Text
    var
        HttpClient: HttpClient;
        Response: HttpResponseMessage;
        ResponseBody: Text;
        StatusCode: Integer;
    begin
        if HttpClient.Get(URL, Response) then begin
            if Response.IsSuccessStatusCode then
                Response.Content.ReadAs(ResponseBody)
            else
                ResponseBody := 'HTTP error: ' + Response.ReasonPhrase;
        end else
            ResponseBody := 'Failed to connect to the server';
        exit(ResponseBody);
    end;

}
