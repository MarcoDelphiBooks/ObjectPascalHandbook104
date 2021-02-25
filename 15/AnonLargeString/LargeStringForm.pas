unit LargeStringForm;

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
    procedure Show(const Msg: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  System.Diagnostics;

const
  MaxLoop = 2000000; // Two million

function TimeCode(NLoops: Integer; Proc: TProc): string;
var
  T1: TStopwatch;
  I: Integer;
begin
  T1 := TStopwatch.StartNew;
  for I := 1 to NLoops do
    Proc;
  T1.Stop;
  Result := T1.ElapsedMilliseconds.ToString;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Str1, Str2: string;
begin
  Str1 := 'Marco ';
  Str2 := 'Cantu ';
  Show('Concatenation: ' +
    TimeCode(MaxLoop, procedure
      begin
        Str1 := Str1 + Str2;
      end));
  Show('Length: ' + Str1.Length.ToString);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Str1, Str2: string;
  SBuilder: TStringBuilder;
begin
  Str1 := 'Marco ';
  Str2 := 'Cantu ';
  SBuilder := TStringBuilder.Create (Str1);
  try
    Show('StringBuilder: ' +
      TimeCode(MaxLoop, procedure
        begin
          SBuilder.Append(Str2);
        end));
    Str1 := SBuilder.ToString;
  finally
    SBuilder.Free;
  end;
  Show('Length: ' + IntToStr(Str1.Length));
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
