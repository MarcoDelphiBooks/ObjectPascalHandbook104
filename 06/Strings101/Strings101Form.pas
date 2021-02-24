unit Strings101Form;

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
    procedure Show(const msg: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  System.Diagnostics;

const
  MaxLoop = 5000000; // Five million


procedure TForm1.Button1Click(Sender: TObject);
var
  Str1, Str2, StrFinal: string;
  I: Integer;
  T1: TStopwatch;
begin
  Str1 := 'Marco ';
  Str2 := 'Cantu ';

  T1 := TStopwatch.StartNew;
  for I := 1 to MaxLoop do
    Str1 := Str1 + Str2;
  StrFinal := Str1;

  T1.Stop;
  Show('Length: ' + IntToStr(StrFinal.Length));
  Show('Concatenation: ' + IntToStr(T1.ElapsedMilliseconds));
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Str1, Str2, StrFinal: string;
  I: Integer;
  T1: TStopwatch;
begin
  Str1 := 'Marco ';
  Str2 := 'Cantu ';

  SetLength(Str1, MaxLoop * 6);
  T1 := TStopwatch.StartNew;
  for I := 1 to MaxLoop do
    Str1 := Str1 + Str2;
  StrFinal := Str1;

  T1.Stop;
  Show('Length: ' + IntToStr(StrFinal.Length));
  Show('Concatenation: ' + IntToStr(T1.ElapsedMilliseconds));
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
