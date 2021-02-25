unit VarPropForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.Memo.Types, FMX.Controls.Presentation,
  FMX.ScrollBox;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    BtnTest: TButton;
    procedure BtnTestClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Show(const Msg: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

{$VARPROPSETTER ON}

type
  TMyIntegerClass = class
  private
    FNumber: Integer;
    function GetNumber: Integer;
    procedure SetNumber(var Value: Integer);
  public
    property Number: Integer
      read GetNumber write SetNumber;
  end;

procedure TForm1.BtnTestClick(Sender: TObject);
var
  Mic: TMyIntegerClass;
  N: Integer;
begin
  Mic := TMyIntegerClass.Create;
  try
    // Mic.Number := 10; // Error: E2036 Variable required

    N := 10;
    Mic.Number := N;
    Mic.Number := N;

    Show(Mic.Number.ToString);
  finally
    Mic.Free;
  end;
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

{ TMyIntegerClass }

function TMyIntegerClass.GetNumber: Integer;
begin
  Result := FNumber;
end;

procedure TMyIntegerClass.SetNumber(var Value: Integer);
begin
  Inc(Value); // side effect
  FNumber := Value;
end;

end.
