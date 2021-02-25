unit RttiIntro_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormRttiIntro = class(TForm)
    BtnInfo: TButton;
    Memo1: TMemo;
    BtnChange: TButton;
    Edit1: TEdit;
    procedure BtnInfoClick(Sender: TObject);
    procedure BtnChangeClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Log(const StrMsg: string);
  end;

var
  FormRttiIntro: TFormRttiIntro;

implementation

{$R *.dfm}

uses
  Rtti;


procedure TFormRttiIntro.BtnChangeClick(Sender: TObject);
var
  Context: TRttiContext;
  AProp: TRttiProperty;
begin
  AProp := Context.GetType(TButton).GetProperty('Caption');
  if Assigned(AProp) then
    AProp.SetValue(BtnChange, StringOfChar('*', Random (10) + 1));
end;

procedure TFormRttiIntro.BtnInfoClick(Sender: TObject);
var
  Context: TRttiContext;
begin
  Log(Context.
    GetType(TButton).
    GetProperty(Edit1.Text).
    GetValue(Sender).ToString);
end;

procedure TFormRttiIntro.Log(const StrMsg: string);
begin
  Memo1.Lines.Add(StrMsg);
end;

end.
