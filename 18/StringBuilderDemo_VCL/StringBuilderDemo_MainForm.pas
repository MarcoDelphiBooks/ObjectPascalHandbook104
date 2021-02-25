unit StringBuilderDemo_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm2 = class(TForm)
    BtnSBuilder: TButton;
    GBSize: TGroupBox;
    rbShort: TRadioButton;
    rbLong: TRadioButton;
    ListBox1: TListBox;
    BtnString: TButton;
    procedure BtnSBuilderClick(Sender: TObject);
    procedure BtnStringClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

const
  MaxCount = 1000000; // One million
  StrSampleShort = 'This is a sample string';
  StrSampleLong = 'This is a slightly longer sample string that should be causing some more trouble in .NET when copied over and over so many times in memory, if you use the String class instead of StringBuilder class';

type
  StringBuilder = TStringBuilder;

procedure TForm2.BtnSBuilderClick(Sender: TObject);
var
  ATime: TDateTime;
  I, NPos: Integer;
  StrB: StringBuilder;
begin
  ATime := Now;

  // actual code
  StrB := StringBuilder.Create;
  if RBShort.Checked then
    StrB.Append(StrSampleShort)
  else
    StrB.Append(StrSampleLong);
  for I := 1 to maxCount do
  begin
    NPos := I mod StrB.Length;
    StrB.Remove(NPos, 1);
    StrB.Insert(NPos, StrB[(I*2) mod StrB.Length]);
  end;
  ListBox1.Items.Add(StrB.ToString);
  // end of actual code

  // added
  StrB.Free;

  ATime := Now - ATime;
  ListBox1.Items.Add('BtnSBuilderClick: ' + FormatDateTime ('ss.zzz', ATime));
end;

procedure TForm2.BtnStringClick(Sender: TObject);
var
  ATime: TDateTime;
  I, NPos: Integer;
  Str: string;
begin
  ATime := Now;

  // Actual code
  if RBShort.Checked then
    Str := StrSampleShort
  else
    Str := StrSampleLong;

  for I := 1 to maxCount do
  begin
    NPos := I mod Length(Str);
    Delete(Str, NPos + 1, 1);
    Insert(Str[(I*2) mod Length(Str) + 1], Str, NPos + 1);
  end;
  ListBox1.Items.Add(Str);
  // End of actual code

  ATime := Now - ATime;
  ListBox1.Items.Add('BtnStringClick: ' + FormatDateTime('ss.zzz', ATime));
end;

end.
