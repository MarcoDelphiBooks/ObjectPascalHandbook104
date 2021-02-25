unit FindTh;

interface

uses
  Classes, SysUtils, StrUtils;

type
  TFindWebThread = class(TThread)
  protected
    FAddr, FText, FStatus: string;
    procedure Execute; override;
    procedure AddToList;
    procedure ShowStatus;
    procedure GrabHtml;
    procedure HtmlToList;
    procedure HttpWork(const Sender: TObject; AContentLength: Int64;
      AReadCount: Int64; var AAbort: Boolean);
  public
    FStrUrl: string;
    FStrRead: string;
  end;

  TFindWebThreadAnon = class(TThread)
  protected
    procedure Execute; override;
    procedure GrabHtml;
    procedure HtmlToList;
    procedure HttpWork(const Sender: TObject; AContentLength: Int64;
      AReadCount: Int64; var AAbort: Boolean);
  public
    FStrUrl: string;
    FStrRead: string;
  end;

implementation

{ TFindWebThread }

uses
  WebFindF, System.Net.HttpClient, System.NetEncoding;

procedure TFindWebThread.AddToList;
begin
  if Form1.ListBox1.Items.IndexOf(FAddr) < 0 then
  begin
    Form1.ListBox1.Items.Add(FAddr);
    Form1.DetailsList.Add(FText);
  end;
end;

procedure TFindWebThread.Execute;
begin
  GrabHtml;
  HtmlToList;
  FStatus := 'Done with ' + FStrUrl;
  Synchronize(ShowStatus);
end;

procedure TFindWebThread.GrabHtml;
var
  Http1: THTTPClient;
begin
  FStatus := 'Sending query: ' + FStrUrl;
  Synchronize(ShowStatus);
  // encode extended characters
  FStrUrl := TURLEncoding.URL.EncodeQuery(FStrUrl);
  Http1 := THTTPClient.Create;
  try
    Http1.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.183 Safari/537.36)';
    Http1.OnReceiveData := HttpWork;
    FStrRead := Http1.Get(FStrUrl, nil).ContentAsString;
  finally
    Http1.Free;
  end;
end;

procedure TFindWebThread.HtmlToList;
var
  StrAddr, StrText: string;
  NText: Integer;
  NBegin, NEnd: Integer;
begin
  FStatus := 'Extracting data for: ' + FStrUrl;
  Synchronize(ShowStatus);
  FStrRead := LowerCase(FStrRead);
  NBegin := 1;
  repeat
    // Find the initial part HTTP reference
    // Was:     NBegin := PosEx('href=http', strRead, NBegin);
    NBegin := PosEx('href="http', FStrRead, NBegin);
    if NBegin <> 0 then
    begin
      // Find the end of the href tag (closing quotes)
      NBegin := NBegin + 6;
      NEnd := PosEx('"', FStrRead, NBegin);
      StrAddr := Copy(FStrRead, NBegin, NEnd - NBegin);

      // Move on
      NBegin := PosEx('>', FStrRead, NEnd) + 1;
      // Add the URL if 'google' is not in it
      if Pos('google', StrAddr) = 0 then
      begin
        NText := PosEx('</a>', FStrRead, NBegin);
        StrText := Copy(FStrRead, NBegin, NText - NBegin);
        // Remove cached references and duplicates
        if (Pos('cache', StrText) = 0) then
        begin
          FAddr := StrAddr;
          FText := StrText;
          Synchronize(AddToList);
        end;
      end;
    end;
  until NBegin = 0;
end;

procedure TFindWebThread.HttpWork(const Sender: TObject; AContentLength,
  AReadCount: Int64; var AAbort: Boolean);
begin
  FStatus := 'Received ' + IntToStr(AReadCount) + ' for ' + FStrUrl;
  Synchronize(ShowStatus);
end;

procedure TFindWebThread.ShowStatus;
begin
  Form1.StatusBar1.SimpleText := FStatus;
end;

{ TFindWebThreadAnon }

procedure TFindWebThreadAnon.Execute;
begin
  GrabHtml;
  HtmlToList;
  Synchronize(procedure
    begin
      Form1.StatusBar1.SimpleText := 'Done with ' + FStrUrl;
    end);
end;

procedure TFindWebThreadAnon.GrabHtml;
var
  Http1: THTTPClient;
begin
  Synchronize(procedure
    begin
      Form1.StatusBar1.SimpleText := 'Sending query: ' + FStrUrl;
    end);

  // encode extended characters
  FStrUrl := TURLEncoding.URL.EncodeQuery(FStrUrl);
  Http1 := THTTPClient.Create;
  try
    Http1.OnReceiveData := HttpWork;
    Http1.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.183 Safari/537.36)';
    FStrRead := Http1.Get(FStrUrl, nil).ContentAsString;
  finally
    Http1.Free;
  end;
end;

procedure TFindWebThreadAnon.HtmlToList;
var
  StrAddr, StrText: string;
  NText: integer;
  NBegin, NEnd: Integer;
begin
  Synchronize(procedure
    begin
      Form1.StatusBar1.SimpleText := 'Extracting data for: ' + FStrUrl;
    end);

  FStrRead := LowerCase(FStrRead);
  NBegin := 1;
  repeat
    // Find the initial part HTTP reference
    // Was:     NBegin := PosEx ('href=http', strRead, NBegin);
    NBegin := PosEx('href="http', FStrRead, NBegin);
    if NBegin <> 0 then
    begin
      // Find the end of the href tag (closing quotes)
      NBegin := NBegin + 6;
      NEnd := PosEx('"', FStrRead, NBegin);
      StrAddr := Copy(FStrRead, NBegin, NEnd - NBegin);

      // Move on
      NBegin := PosEx('>', FStrRead, NEnd) + 1;
      // Add the URL if 'google' is not in it
      //if Pos('google', StrAddr) = 0 then
      begin
        NText := PosEx('</a>', FStrRead, NBegin);
        StrText := Copy(FStrRead, NBegin, NText - NBegin);
      end;

      // Remove cached references and duplicates
      if (Pos('cache', StrText) = 0) then
      begin
        Synchronize(procedure
          begin
            if Form1.ListBox1.Items.IndexOf(StrAddr) < 0 then
            begin
              Form1.ListBox1.Items.Add(StrAddr);
              Form1.DetailsList.Add(StrText);
            end;
          end);
      end;
    end;
  until NBegin = 0;
end;

procedure TFindWebThreadAnon.HttpWork(const Sender: TObject; AContentLength,
  AReadCount: Int64; var AAbort: Boolean);
begin
  Synchronize(procedure
    begin
      Form1.StatusBar1.SimpleText :=
        'Received ' + IntToStr(AReadCount) + ' for ' + FStrUrl;
    end);
end;

end.
