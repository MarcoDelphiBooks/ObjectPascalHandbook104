unit HelperForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.ListBox, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Show(const Text: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

type
  MyInt = type Integer;

  TMyIntHelper = record helper for MyInt
    function AsString: string;
  end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Mi: MyInt;
begin
  Mi := 10;
  Show(Mi.asString);
  //Show(Mi.toString);
  Show(Integer(Mi).ToString)
end;

procedure TForm1.Show(const Text: string);
begin
  Memo1.Lines.Add(Text);
end;

{ TMyIntHelper }

function TMyIntHelper.AsString: string;
begin
  Result := IntToStr(self);
end;

end.
