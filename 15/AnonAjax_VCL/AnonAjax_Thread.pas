unit AnonAjax_Thread;

interface

uses
  Classes, SysUtils, StrUtils, System.Net.HttpClient;

type
  TAjaxCallback = reference to procedure(aResponseContent: TStringStream);
  TLinkCallback = reference to procedure(const strLink: string);

  TAjaxThread = class(TThread)
  private
    FHttp: THTTPClient;
    FURL: string;
    FAjaxCallback: TAjaxCallback;
  protected
    procedure Execute; override;
  public
    constructor Create(const StrUrl: string; AjaxCallback: TAjaxCallback);
    destructor Destroy; override;
  end;

procedure AjaxCall(const StrUrl: string; AjaxCallback: TAjaxCallback);
procedure ExtractLinks(StrData: string; ProcLink: TLinkCallback);
procedure ExtractImages(StrData: string; ProcLink: TLinkCallback);


implementation

procedure AjaxCall(const StrUrl: string; AjaxCallback: TAjaxCallback);
begin
  TAjaxThread.Create(StrUrl, AjaxCallback);
end;

{ TAjaxThread }

constructor TAjaxThread.Create(const StrUrl: string; AjaxCallback: TAjaxCallback);
begin
  FHttp := THTTPClient.Create;
  FURL := StrUrl;
  FAjaxCallback := AjaxCallBack;
  inherited Create(False);
  FreeOnTerminate := True;
end;

destructor TAjaxThread.Destroy;
begin
  FHttp.Free;
  inherited;
end;

procedure TAjaxThread.Execute;
var
  AResponseContent: TStringStream;
begin
  AResponseContent := TStringStream.Create;
  try
    FHttp.Get(FURL, AResponseContent);
    AResponseContent.Position := 0;
    FAjaxCallback(AResponseContent);
  finally
    AResponseContent.Free;
  end;
end;

procedure ExtractLinks(StrData: string; ProcLink: TLinkCallback);
var
  StrAddr: string;
  NBegin, NEnd: Integer;
begin
  StrData := LowerCase(StrData);
  NBegin := 1;
  repeat
    NBegin := PosEx('href="http', StrData, NBegin);
    if NBegin <> 0 then
    begin
      // Find the end of the reference
      NBegin := NBegin + 6;
      NEnd := PosEx('"', StrData, NBegin);
      StrAddr := Copy(StrData, NBegin, NEnd - NBegin);
      // Move on
      NBegin := NEnd + 1;
      // Execute anon method
      ProcLink(StrAddr)
    end;
  until NBegin = 0;
end;

procedure ExtractImages(StrData: string; ProcLink: TLinkCallback);
var
  StrAddr: string;
  NBegin, NEnd: Integer;
begin
  StrData := LowerCase(StrData);
  NBegin := 1;
  repeat
    NBegin := PosEx('<img src="', StrData, NBegin);
    if NBegin <> 0 then
    begin
      // Find the end of the reference
      NBegin := NBegin + 10;
      NEnd := PosEx('"', StrData, NBegin);
      StrAddr := Copy(StrData, NBegin, NEnd - NBegin);
      // Move on
      NBegin := NEnd + 1;
      // Execute anon method
      ProcLink(StrAddr)
    end;
  until NBegin = 0;
end;


end.
