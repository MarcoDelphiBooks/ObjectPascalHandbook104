unit StringMetaTestForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo.Types;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

{$ZEROBASEDSTRINGS ON}

var
  MyStr1, MyStr2: string;

procedure TForm1.Button1Click(Sender: TObject);
var
  Str1: string;
begin
  Str1 := 'F' + string.Create('o', 2);

  Show('SizeOf: ' + SizeOf (Str1).ToString);
  Show('Length: ' + Str1.Length.ToString);
  Show('StringElementSize: ' +
    StringElementSize(Str1).ToString);
  Show('StringRefCount: ' +
    StringRefCount(Str1).ToString);
  Show('StringCodePage: ' +
    StringCodePage(Str1).ToString);
  if StringCodePage(Str1) = DefaultUnicodeCodePage then
    Show('Is Unicode');
  Show('Size in bytes: ' +
    (Length (Str1) * StringElementSize(Str1)).ToString);
  Show('ByteLength: ' +
    ByteLength(Str1).ToString);
end;

function StringStatus(const Str: string): string;
begin
  Result := 'Addr: ' + IntToStr(Integer(Str)) +
    ', Len: ' + IntToStr(Length(Str)) +
    ', Ref: ' + IntToStr(PInteger(Integer(Str) - 8)^) +
    ', Val: ' + Str;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Show('MyStr1 - ' + StringStatus(MyStr1));
  Show('MyStr2 - ' + StringStatus(MyStr2));
  MyStr1[1] := 'a';
  Show('Change 2nd char');
  Show('MyStr1 - ' + StringStatus(MyStr1));
  Show('MyStr2 - ' + StringStatus(MyStr2));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  MyStr1 := string.Create(['H', 'e', 'l', 'l', 'o']);
  MyStr2 := MyStr1;
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
