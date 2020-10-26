unit VariantTestForm;

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
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Show (const Msg: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  V: Variant;
  S: string;
begin
  V := 10;
  S := v;
  V := V + S;
  Show (V);

  V := 'Hello, World';
  V := V + S;
  Show (V);

  V := 45.55;
  V := V + S;
  Show (V);
end;

const
  Maxno = 10000000;  // 10 millions

procedure TForm1.Button2Click(Sender: TObject);
var
  Time1, Time2: TDateTime;
  N1, N2: Variant;
  I1, I2: Int64;
begin
  Time1 := Now;
  N1 := 0;
  N2 := 0;

  while N1 < Maxno do
  begin
    N2 := N2 + N1;
    Inc (N1);
  end;

  // we must use the result
  Time2 := Now;

  Show (N2);
  Show ('Variants: ' + FormatDateTime (
    'ss.zzz', Time2-Time1) + ' seconds');

  /// now use integers
  Time1 := Now;
  I1 := 0;
  I2 := 0;

  while I1 < Maxno do
  begin
    I2 := I2 + I1;
    Inc (I1);
  end;

  // we must use the result
  Time2 := Now;
  Show (I2.ToString);
  Show ('Integers: ' + FormatDateTime (
    'ss.zzz', Time2-Time1) + ' seconds');

end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
