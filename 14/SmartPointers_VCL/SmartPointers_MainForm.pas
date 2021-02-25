unit SmartPointers_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormSmartPointers = class(TForm)
    BtnLeak: TButton;
    BtnSmart: TButton;
    BtnSmartShort: TButton;
    BtnImplicitCreate: TButton;
    Memo1: TMemo;
    procedure BtnLeakClick(Sender: TObject);
    procedure BtnSmartClick(Sender: TObject);
    procedure BtnSmartShortClick(Sender: TObject);
    procedure BtnImplicitCreateClick(Sender: TObject);
    procedure Log(const StrMsg: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSmartPointers: TFormSmartPointers;

implementation

uses
  SmartPointerClass;

{$R *.dfm}

procedure TFormSmartPointers.BtnImplicitCreateClick(Sender: TObject);
var
  SmartP: TSmartPointer<TStringList>;
begin
//  SmartP.Create;
  SmartP.Value.Add('Foo');
  Log('Count: ' + IntToStr(SmartP.Value.Count));
end;

procedure TFormSmartPointers.BtnLeakClick(Sender: TObject);
var
  SL: TStringList;
begin
  // Memory leak
  SL := TStringList.Create;
  SL.Add('Foo');
  Log('Count: ' + IntToStr(SL.Count));
end;

procedure TFormSmartPointers.BtnSmartClick(Sender: TObject);
var
  SL: TStringList;
  SmartP: TSmartPointer<TStringList>;
begin
  SL := TStringList.Create;
  SmartP := SL;
  SL.Add('Foo');
  Log('Count: ' + IntToStr(SL.Count));
end;

procedure TFormSmartPointers.BtnSmartShortClick(Sender: TObject);
var
  SmartP: TSmartPointer<TStringList>;
begin
  SmartP := TStringList.Create;
  SmartP.Value.Add('Foo');
  TStringList(SmartP).Add('Foo2');
  Log('Count: ' + IntToStr(TStringList(SmartP).Count));
end;

procedure TFormSmartPointers.Log(const StrMsg: string);
begin
  Memo1.Lines.Add(StrMsg);
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.
