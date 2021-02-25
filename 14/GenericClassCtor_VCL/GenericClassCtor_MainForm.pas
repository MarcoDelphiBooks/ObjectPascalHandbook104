unit GenericClassCtor_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormGenericClassCtor = class(TForm)
    BtnInt: TButton;
    Memo1: TMemo;
    BtnString: TButton;
    BtnSequence: TButton;
    procedure BtnIntClick(Sender: TObject);
    procedure BtnSequenceClick(Sender: TObject);
    procedure BtnStringClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Log(const StrMsg: string);
  end;

var
  FormGenericClassCtor: TFormGenericClassCtor;

implementation

{$R *.dfm}

uses GenericClassCtor_Classes;

type
  TGenDouble = TGenericWithClassCtor<Double>;

procedure TFormGenericClassCtor.BtnIntClick(Sender: TObject);
var
  GenInt: TGenericWithClassCtor<SmallInt>;
begin
  GenInt := TGenericWithClassCtor<SmallInt>.Create;
  GenInt.Data := 100;
  Log('Size: ' + IntToStr(GenInt.DataSize));
  GenInt.Free;
end;

procedure TFormGenericClassCtor.BtnSequenceClick(Sender: TObject);
begin
  Log(Trim(ListSequence.Text));
end;

procedure TFormGenericClassCtor.BtnStringClick(Sender: TObject);
var
  GenStr: TGenericWithClassCtor<string>;
begin
  GenStr := TGenericWithClassCtor<string>.Create;
  GenStr.Data := '100';
  Log('Size: ' + IntToStr(GenStr.DataSize));
  GenStr.Free;
end;

procedure TFormGenericClassCtor.Log(const StrMsg: string);
begin
  Memo1.Lines.Add(StrMsg)
end;

end.
