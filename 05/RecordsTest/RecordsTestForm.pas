unit RecordsTestForm;

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
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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
  TMyDate = packed record
    FYear: Integer;
    FMonth: Byte;
    FDay: Byte;
  end;

function MyDateToString (MyDate: TMyDate): string;
begin
  Result := MyDate.FYear.ToString + '.' +
    MyDate.FMonth.ToString + '.' +
    MyDate.FDay.ToString;
end;

procedure IncreaseYear (var MyDate: TMyDate);
begin
  Inc (MyDate.FYear);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  BirthDay: TMyDate;
begin
  BirthDay.FYear := 1997;
  BirthDay.FMonth := 2;
  BirthDay.FDay := 14;

  Show ('Born in year ' + BirthDay.FYear.ToString);
  Show ('Record size is ' + SizeOf (BirthDay).ToString);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  BirthDay: TMyDate;
  ADay: TMyDate;
begin
  BirthDay.FYear := 1997;
  BirthDay.FMonth := 2;
  BirthDay.FDay := 14;

  ADay := Birthday;
  ADay.FYear := 2008;

  Show (MyDateToString (BirthDay));
  Show (MyDateToString (ADay));
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  ADay: TMyDate;
begin
  ADay.FYear := 2016;
  ADay.FMonth := 3;
  ADay.FDay := 18;

  Increaseyear (ADay);
  Show (MyDateToString (ADay));
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  DatesList: array of TMyDate;
  I: Integer;
begin
  // allocate array elements
  SetLength (DatesList, 5);

  // assign random values
  for I := Low(DatesList) to High(DatesList) do
  begin
    DatesList[I].FYear := 2000 + Random (50);
    DatesList[I].FMonth := 1 + Random (12);
    DatesList[I].FDay := 1 + Random (27);
  end;

  // display the values
  for I := Low(DatesList) to High(DatesList) do
    Show (I.ToString + ': ' +
      MyDateToString (DatesList[I]));
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

initialization
  Randomize;

end.
