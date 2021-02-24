unit Dates;

interface

uses
  System.SysUtils;

type
  TDate = class
  private
    FDate: TDateTime;
    function GetDay: Integer;
    function GetMonth: Integer;
    function GetYear: Integer;
    procedure SetDay(const Value: Integer);
    procedure SetMonth(const Value: Integer);
    procedure SetYear(const Value: Integer);
  public
    constructor Create; overload;
    constructor Create (Month, Day, Year: Integer); overload;
    procedure SetValue (Month, Day, Year: Integer); overload;
    procedure SetValue (NewDate: TDateTime); overload;
    function LeapYear: Boolean;
    procedure Increase (NumberOfDays: Integer = 1);
    procedure Decrease (NumberOfDays: Integer = 1);
    function GetText: string;
    property Day: Integer read GetDay write SetDay;
    property Month: Integer read GetMonth write SetMonth;
    property Year: Integer read GetYear write SetYear;
    property Text: string read GetText;
  end;

type
  EDateOutOfRange = class (Exception);

implementation

uses
  System.DateUtils;

constructor TDate.Create;
begin
  FDate := Today;
end;

constructor TDate.Create (Month, Day, Year: Integer);
begin
  FDate := EncodeDate (Year, Month, Day);
end;

procedure TDate.Decrease(NumberOfDays: Integer);
begin
  FDate := FDate - NumberOfDays;
end;

procedure TDate.SetValue (Month, Day, Year: Integer);
begin
  FDate := EncodeDate (Year, Month, Day);
end;

function TDate.GetDay: Integer;
var
  Y, M, D: Word;
begin
  DecodeDate (FDate, Y, M, D);
  Result := D;
end;

function TDate.GetMonth: Integer;
var
  Y, M, D: Word;
begin
  DecodeDate (FDate, Y, M, D);
  Result := M;
end;

function TDate.GetText: string;
begin
  Result := DateToStr (FDate);
end;

function TDate.GetYear: Integer;
var
  Y, M, D: Word;
begin
  DecodeDate (FDate, Y, M, D);
  Result := Y;
end;

procedure TDate.Increase (NumberOfDays: Integer);
begin
  FDate := FDate + NumberOfDays;
end;

function TDate.LeapYear: Boolean;
begin
  // call IsLeapYear in SysUtils and YearOf in DateUtils
  Result := IsLeapYear (YearOf (FDate));
end;

procedure TDate.SetDay(const Value: Integer);
begin
  if (Value < 1) or (Value > 31) then
    raise EDateOutOfRange.Create ('Invalid day');
  SetValue (Month, Value, Year);
end;

procedure TDate.SetMonth(const Value: Integer);
begin
  if (Value < 1) or (Value > 12) then
    raise EDateOutOfRange.Create ('Invalid month');
  SetValue (Value, Day, Year);
end;

procedure TDate.SetValue(NewDate: TDateTime);
begin
  FDate := NewDate;
end;


procedure TDate.SetYear(const Value: Integer);
begin
  SetValue (Month, Day, Value);
end;

end.
