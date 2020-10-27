unit DatesForm;

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
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Show (const Msg: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

type
  TDate = class
    FMonth, FDay, FYear: Integer;
    procedure SetValue (M, D, Y: Integer);
    function LeapYear: Boolean;
  end;

type
  THusband = class;

  TWife = class
    FHusband: THusband;
  end;

  THusband = class
    FWife: TWife;
  end;

procedure TDate.SetValue(M, D, Y: Integer);
begin
  FMonth := M;
  FDay := D;
  FYear := Y;
end;

function TDate.LeapYear: Boolean;
begin
  // call IsLeapYear in SysUtils.pas
  Result := IsLeapYear (FYear);
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  ADay: TDate;
begin
  // create
  ADay := TDate.Create;

  // use
  ADay.SetValue (1, 1, 2016);
  if ADay.LeapYear then
    Show ('Leap year: ' + IntToStr (ADay.FYear));

  // free the memory (for non ARC platforms)
  ADay.Free;
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
