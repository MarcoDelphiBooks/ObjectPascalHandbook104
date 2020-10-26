unit InliningTestForm;

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
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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
  System.Math, System.Diagnostics;

procedure Show (const Msg: string);
begin
  Form1.Show(Msg)
end;

const
  LoopCount = 20000000; // twenty millions

procedure TForm1.Button1Click(Sender: TObject);
var
  SW: TStopWatch;
  I, J: Integer;
begin
  J := 0;
  SW := TStopWatch.StartNew;
  for I := 0 to LoopCount do
    J := Max (I, J);
  SW.Stop;
  Show ('Max on ' + J.ToString +
      ' [' + SW.ElapsedMilliseconds.ToString + '] ');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  SW: TStopWatch;
  I, J: Integer;
  Ssample: string;
begin
  J := 0;
  Ssample:= 'sample string';
  SW := TStopWatch.StartNew;
  for I := 0 to LoopCount do
    Inc (J, Length(Ssample));
  SW.Stop;
  Show ('Length inlined ' + IntToStr (J) +
      ' [' + IntToStr (SW.ElapsedMilliseconds) + '] ');
end;

{$INLINE OFF}
procedure TForm1.Button2Click(Sender: TObject);
var
  SW: TStopWatch;
  I, J: Integer;
begin
  J := 0;
  SW := TStopWatch.StartNew;
  for I := 0 to LoopCount do
    J := Max (I, J);
  SW.Stop;
  Show ('Max off ' + J.ToString +
      ' [' + SW.ElapsedMilliseconds.ToString + '] ');
end;
{$INLINE ON}


{$INLINE OFF}
procedure TForm1.Button4Click(Sender: TObject);
var
  SW: TStopWatch;
  I, J: Integer;
  Sample: string;
begin
  J := 0;
  Sample:= 'sample string';
  SW := TStopWatch.StartNew;
  for I := 0 to LoopCount do
    Inc (J, Length(Sample));
  SW.Stop;
  Show ('Length not inlined ' + IntToStr (J) +
      ' [' + IntToStr (SW.ElapsedMilliseconds) + '] ');
end;
{$INLINE ON}

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
