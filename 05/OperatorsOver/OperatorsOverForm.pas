unit OperatorsOverForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo.Types;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Show (const Msg: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  OperatorsTypes;

procedure TForm1.Button1Click(Sender: TObject);
var
  A, B, C: TPointRecord;
begin
  A.SetValue(10, 10);
  B := 30;
  C := A + B;
  Show (string(C));
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  A: TPointRecord2;
begin
  A.SetValue(10, 20);
  A := A + 10;
  A := 30 + A;
  Show (string(A));
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  A, C: TPointRecord;
begin
  A := 50;

  C := A + 30;
  Show (string(C));

  C := 50 + 30;
  Show (string(C));

  C := 50 + TPointRecord(30);
  Show (string(C));

end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
