unit SmartPointers_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormSmartPointers = class(TForm)
    BtnLeak: TButton;
    Btnmanage: TButton;
    BtnAutoSmart: TButton;
    Memo1: TMemo;
    procedure BtnLeakClick(Sender: TObject);
    procedure BtnmanageClick(Sender: TObject);
    procedure BtnAutoSmartClick(Sender: TObject);
    procedure Log (const StrMsg: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSmartPointers: TFormSmartPointers;

implementation

uses
  SmartPointerMRecord;

{$R *.dfm}

procedure TFormSmartPointers.BtnLeakClick(Sender: TObject);
var
  SL: TStringList;
begin
  // memory leak
  SL := TStringList.Create;
  SL.Add('foo');
  SL.Add('bar');
  Log ('Count: ' + IntToStr (SL.Count));
end;

procedure TFormSmartPointers.BtnmanageClick(Sender: TObject);
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  var SmartP := TSmartPointer<TStringList>.Create (SL);
  SL.Add('foo');
  SmartP.Value.Add('bar');
  Log ('Count: ' + SL.Count.ToString);
end;

procedure TFormSmartPointers.BtnAutoSmartClick(Sender: TObject);
var
  SmartP: TSmartPointer<TStringList>;
begin
  SmartP.Value.Add('foo');
  SmartP.Value.Add('bar');
  Log ('Count: ' + SmartP.Value.Count.ToString);
end;

procedure TFormSmartPointers.Log(const StrMsg: string);
begin
  Memo1.Lines.Add (StrMsg);
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.
