unit AlignTestForm;

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
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Show(const Msg: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

{$ALIGN 16}
type
  TMyRecord16 = record
    C: AnsiChar;
    W: Word;
    B: Boolean;
    I: Integer;
    D: Double;
  end;

{$ALIGN 4}
type
  TMyRecord4 = record
    C: AnsiChar;
    W: Word;
    B: Boolean;
    I: Integer;
    D: Double;
  end;

{$ALIGN 1}
type
  TMyRecord1 = record
    C: AnsiChar;
    W: Word;
    B: Boolean;
    I: Integer;
    D: Double;
  end;

procedure TForm1.Button1Click(Sender: TObject);
var
  MyRec1: TMyRecord1;
  MyRec4: TMyRecord4;
  MyRec16: TMyRecord16;
begin
  Show('ALIGN 1 -- sizeof: ' + IntToStr(sizeof(TMyRecord1)));
  Show('C: ' + IntToStr(Integer(@MyRec1.C) - Integer(@MyRec1)) +
    ' W: ' + IntToStr(Integer(@MyRec1.W) - Integer(@MyRec1)) +
    ' B: ' + IntToStr(Integer(@MyRec1.B) - Integer(@MyRec1)) +
    ' I: ' + IntToStr(Integer(@MyRec1.i) - Integer(@MyRec1)) +
    ' D: ' + IntToStr(Integer(@MyRec1.D) - Integer(@MyRec1)));

  Show('ALIGN 4 -- sizeof: ' + IntToStr (sizeof(TMyRecord4)));
  Show('C: ' + IntToStr(Integer(@MyRec4.C) - Integer(@MyRec4)) +
    ' W: ' + IntToStr(Integer(@MyRec4.W) - Integer(@MyRec4)) +
    ' B: ' + IntToStr(Integer(@MyRec4.B) - Integer(@MyRec4)) +
    ' I: ' + IntToStr(Integer(@MyRec4.i) - Integer(@MyRec4)) +
    ' D: ' + IntToStr(Integer(@MyRec4.D) - Integer(@MyRec4)));

  Show('ALIGN 16 -- sizeof: ' + IntToStr (sizeof(TMyRecord16)));
  Show('C: ' + IntToStr(Integer(@MyRec16.C) - Integer(@MyRec16)) +
    ' W: ' + IntToStr(Integer(@MyRec16.W) - Integer(@MyRec16)) +
    ' B: ' + IntToStr(Integer(@MyRec16.B) - Integer(@MyRec16)) +
    ' I: ' + IntToStr(Integer(@MyRec16.i) - Integer(@MyRec16)) +
    ' D: ' + IntToStr(Integer(@MyRec16.D) - Integer(@MyRec16)));
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
