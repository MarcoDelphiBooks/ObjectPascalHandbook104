unit IntegersTestForm;

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
    procedure Show(const Msg: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  N: Integer;
begin
  N := 10;
  Show(N.ToString);

  // display a constant
  Show(33.ToString);

  // type operation, show the bytes required to store the type
  Show(Integer.Size.ToString);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  N: UInt16;
begin
  N := Low(UInt16);
  Inc(N);
  Show(N.ToString);
  Inc(N, 10);
  Show(N.ToString);
  if Odd(N) then
    Show(N.ToString + ' is odd');

  // N := 100 + High(N);
  Inc(N, High (N));
  Show(N.ToString);
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
