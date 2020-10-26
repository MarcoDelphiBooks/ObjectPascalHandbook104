unit CharsTestForm;

interface

// running this program raises an exception by design

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

uses
  Character;

procedure TForm1.Button1Click(Sender: TObject);
var
  Ch: Char;
begin
  Ch := 'a';
  Show (BoolToStr(Ch.IsLetter, True));
  Show (Ch.ToUpper);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Ch: Char;
  Str1: string;
begin
  Ch := 'a';
  Show (Ch);
  Inc (Ch, 100);
  Show (Ch);

  Str1 := '';
  for Ch := #32 to #1024 do
    Str1 := Str1 + Ch;
  Show (Str1)
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
