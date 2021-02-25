unit TValueTestMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm39 = class(TForm)
    BtnNoConvert: TButton;
    Memo1: TMemo;
    procedure BtnNoConvertClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Log(const StrMsg: string);
  end;

var
  Form39: TForm39;

implementation

{$R *.dfm}

uses
  System.Rtti;

procedure TForm39.BtnNoConvertClick(Sender: TObject);
var
  V1: TValue;
begin
  //V1 := 100;
  V1 := TValue.From<Integer>(100);
  if V1.IsOrdinal then
    Log(IntToStr(V1.AsInteger));
  if V1.IsType<string> then
    Log(V1.AsString);
  Log(V1.ToString);
end;

procedure TForm39.Log(const StrMsg: string);
begin
  Memo1.Lines.Add(StrMsg);
end;

end.
