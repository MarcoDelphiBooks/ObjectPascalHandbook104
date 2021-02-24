unit StringHelperForm;

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

procedure TForm1.Button1Click(Sender: TObject);
var
  Str1, Str2: string;
  I, NCount: Integer;
begin
  Str1 := '';

  // create string
  for I := 1 to 10 do
    Str1 := Str1 + 'Object ';

  Str2:= string.Copy(Str1);
  Str1 := Str2 + 'Pascal ' + Str2.Substring(10, 30);
  Show(Str1);

  // find substring
  Show('Pascal at: ' +
    Str1.IndexOf('Pascal').ToString);

  // count occurrences
  I := -1;
  NCount := 0;
  repeat
    I := Str1.IndexOf('O', I + 1); // search from next element
    if I >= 0 then
      Inc(NCount); // found one
  until I < 0;

  Show('O found: ' + NCount.ToString + ' times');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Str1, Str2: string;
  I, NIndex: Integer;
begin
  Str1 := '';

  // Create string
  for I := 1 to 10 do
    Str1 := Str1 + 'Object ';

  Str2:= string.Copy(Str1);
  Str1 := Str2 + 'Pascal ' + Str2.Substring(10, 30);
  Show(Str1);

  // Single replace
  NIndex := Str1.IndexOf('Pascal');
  Str1 := Str1.Substring(0, NIndex) + 'Object' +
    Str1.Substring(NIndex + ('Pascal').Length);
  Show(Str1);

  // Multi-replace
  Str1 := Str1.Replace('O', 'o', [rfReplaceAll]);
  Show(Str1);
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
