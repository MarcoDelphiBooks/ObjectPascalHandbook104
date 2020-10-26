unit CaseTestForm;

interface

// running this program raises an exception by design

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.Edit, FMX.EditBox, FMX.NumberBox,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo.Types;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    Button3: TButton;
    NumberBox1: TNumberBox;
    procedure Button1Click(Sender: TObject);
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
  Character;

procedure TForm1.Button1Click(Sender: TObject);
var
  Number: Integer;
  AText: string;
begin
  Number := Trunc(NumberBox1.Value);
  case Number of
    1: AText := 'One';
    2: AText := 'Two';
    3: AText := 'Three';
  end;
  if AText <> '' then
    Show(AText);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  AChar: Char;
  AText: string;
begin
  /// multiple nested if statements
  if Edit1.Text.Length > 0 then
  begin
    AChar := Edit1.Text.Chars[0];

    case AChar of
      '+' : AText := 'Plus sign';
      '-' : AText := 'Minus sign';
      '*', '/': AText := 'Multiplication or division';
      '0'..'9': AText := 'Number';
      'a'..'z': AText := 'Lowercase character';
      'A'..'Z': AText := 'Uppercase character';
      #12032..#12255: AText := 'Kangxi Radical';
    else
      AText := 'Other character: ' + AChar;
    end;

    Show(AText);
  end;
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
