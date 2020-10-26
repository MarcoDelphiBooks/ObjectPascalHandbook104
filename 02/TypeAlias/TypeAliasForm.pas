unit TypeAliasForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, Vcl.StdCtrls,
  VCLTee.TeEngine, VCLTee.Series, Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart;

type
  TTAliasForm = class(TForm)
    BtnTest: TButton;
    Memo2: TMemo;
    procedure BtnTestClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Log (const StrMessage: string);
  end;

var
  TAliasForm: TTAliasForm;

implementation

{$R *.dfm}

type
  TNewInt = Integer;
  TNewInt2 = type Integer;

procedure Test (var N: Integer);
begin

end;

procedure TTAliasForm.BtnTestClick(Sender: TObject);
var
  I: Integer;
  NI: TNewInt;
  NI2: TNewInt2;
begin
  I := 10;
  NI := I;
  NI2 := I;

  Test(I);
  Test (NI);
//  Test (NI2); // error

  ShowMessage (I.ToString);
  ShowMessage (NI.ToString);
//  ShowMessage (NI2.ToString); // error

end;

procedure TTAliasForm.Log(const StrMessage: string);
begin
  Memo2.Lines.Add(StrMessage);
end;

end.
