unit IfTestForm;

interface

// running this program raises an exception by design

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo.Types;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    CheckBox1: TCheckBox;
    Button2: TButton;
    Edit1: TEdit;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
  Character;

procedure TForm1.Button1Click(Sender: TObject);
var
  IsChecked: Boolean;
begin
  IsChecked := CheckBox1.IsChecked;
  if IsChecked then
    Show('Checkbox is checked');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  // If-then-else statement
  if CheckBox1.IsChecked then
    Show('Checkbox is checked')
  else
    Show('Checkbox is not checked');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  AChar: Char;
begin
  /// Multiple nested if statements
  if Edit1.Text.Length > 0 then
  begin
    AChar := Edit1.Text.Chars[0];

    // Checks for a lowercase char (two conditions)
    if (AChar >= 'a') and (AChar <= 'z') then
      Show('Char is lowercase');

    // Follow up conditions
    if AChar <= Char(47) then
      Show('Char is lower symbol')
    else if (AChar >= '0') and (AChar <= '9') then
      Show('Char is a number')
    else
      Show('Char is not a number or lower symbol');
  end;
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
