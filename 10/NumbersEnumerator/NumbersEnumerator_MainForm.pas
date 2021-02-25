unit NumbersEnumerator_MainForm;

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

type
  TNumbersRange = class
  public

  type
    TNumbersRangeEnum = class
    private
      NPos: Integer;
      FRange: TNumbersRange;
    public
      constructor Create(ARange: TNumbersRange);
      function MoveNext: Boolean;
      function GetCurrent: Integer;
      property Current: Integer read GetCurrent;
    end;

  private
    FNStart: Integer;
    FNEnd: Integer;

  public
    function GetEnumerator: TNumbersRangeEnum;
    procedure Set_NEnd(const Value: Integer);
    procedure Set_NStart(const Value: Integer);

    property NStart: Integer read FNStart write Set_NStart;
    property NEnd: Integer read FNEnd write Set_NEnd;
  end;

implementation

{$R *.fmx}

procedure TForm1.BtnTestClick(Sender: TObject);
var
  ARange: TNumbersRange;
  I: Integer;
begin
  ARange := TNumbersRange.Create;
  ARange.NStart := 10;
  ARange.NEnd := 23;

  for I in ARange do
    Show (I.ToString);
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

{ TNumbersRange }

function TNumbersRange.GetEnumerator: TNumbersRangeEnum;
begin
  Result := TNumbersRangeEnum.Create(self);
end;

constructor TNumbersRange.TNumbersRangeEnum.Create(
  ARange: TNumbersRange);
begin
  inherited Create;
  FRange := ARange;
  NPos := FRange.NStart - 1;
end;

function TNumbersRange.TNumbersRangeEnum.GetCurrent: Integer;
begin
  Result := NPos;
end;

function TNumbersRange.TNumbersRangeEnum.MoveNext: Boolean;
begin
  Inc(NPos);
  Result := NPos <= FRange.NEnd;
end;

procedure TNumbersRange.Set_NEnd(const Value: Integer);
begin
  FNEnd := Value;
end;

procedure TNumbersRange.Set_NStart(const Value: Integer);
begin
  FNStart := Value;
end;

end.
