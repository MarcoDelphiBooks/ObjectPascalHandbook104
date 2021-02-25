unit ListForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Generics.Collections, Dates;

type
  TForm1 = class(TForm)
    ButtonAdd: TButton;
    ButtonList: TButton;
    ListBox1: TListBox;
    ButtonWrong: TButton;
    ButtonEnum: TButton;
    ButtonSort: TButton;
    ButtonAnonSort: TButton;
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonListClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonWrongClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonEnumClick(Sender: TObject);
    procedure ButtonSortClick(Sender: TObject);
    procedure ButtonAnonSortClick(Sender: TObject);
  private
    ListDate: TList<TDate>;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Generics.Defaults, Contnrs;

{$R *.DFM}

procedure TForm1.ButtonAddClick(Sender: TObject);
begin
  // OK, quite ugly, but I've decided to keep it as it was
  ListDate.Add(TDate.Create(
    1900 + Random(200), 1 + Random(12), 1 + Random(30)));
end;

function DoCompare (const Left, Right: TDate): Integer;
var
  LDate, RDate: TDateTime;
begin
  LDate := EncodeDate(Left.Year, Left.Month, Left.Day);
  RDate := EncodeDate(Right.Year, Right.Month, Right.Day);
  if LDate = RDate then
    Result := 0
  else if LDate < RDate then
    Result := -1
  else
    Result := 1;
end;

procedure TForm1.ButtonAnonSortClick(Sender: TObject);
begin
  // passes method as parameter
  ListDate.Sort(TComparer<TDate>.Construct (DoCompare));

// in line version
//  ListDate.Sort(TComparer<TDate>.Construct (
//    function(const Left, Right: TDate): Integer
//    var
//      LDate, RDate: TDateTime;
//    begin
//      LDate := EncodeDate(Left.Year, Left.Month, Left.Day);
//      RDate := EncodeDate(Right.Year, Right.Month, Right.Day);
//      if LDate = RDate then
//        Result := 0
//      else if LDate < RDate then
//        Result := -1
//      else
//        Result := 1;
//    end));
end;

procedure TForm1.ButtonEnumClick(Sender: TObject);
var
  ADate: TDate;
begin
  for ADate in ListDate do
  begin
    Listbox1.Items.Add(ADate.Text);
  end;
end;

procedure TForm1.ButtonListClick(Sender: TObject);
var
  I: Integer;
begin
  ListBox1.Clear;
  for I := 0 to ListDate.Count - 1 do
    // Originally was:
    // Listbox1.Items.Add((TObject(ListDate[I]) as TDate).Text);
    // improved version
    Listbox1.Items.Add(ListDate[I].Text);
end;

type
  TDateComparer = class(TComparer<TDate>)
    function Compare(const Left, Right: TDate): Integer; override;
  end;

type
  TAnyDateComparer = TComparer<TDate>;
  TMyDateComparer = class(TAnyDateComparer)
    function Compare(const Left, Right: TDate): Integer; override;
  end;

procedure TForm1.ButtonSortClick(Sender: TObject);
begin
  // ListDate.Sort;
  ListDate.Sort(TDateComparer.Create);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  ListDate := TList<TDate>.Create;
end;

procedure TForm1.ButtonWrongClick(Sender: TObject);
begin
  // Add a button to the list
  // ListDate.Add(Sender); // E2010 Incompatible types: 'TDate' and 'TObject'
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to ListDate.Count - 1 do
    TObject(ListDate[I]).Free;
  ListDate.Free;
end;

{ TDateComparer }

function TDateComparer.Compare(const Left, Right: TDate): Integer;
var
  LDate, RDate: TDateTime;
begin
  LDate := EncodeDate(Left.Year, Left.Month, Left.Day);
  RDate := EncodeDate(Right.Year, Right.Month, Right.Day);
  if LDate = RDate then
    Result := 0
  else if LDate < RDate then
    Result := -1
  else
    Result := 1;
end;

{ TMyDateComparer }

// duplicate code from above...
function TMyDateComparer.Compare(const Left, Right: TDate): Integer;
var
  LDate, RDate: TDateTime;
begin
  LDate := EncodeDate(Left.Year, Left.Month, Left.Day);
  RDate := EncodeDate(Right.Year, Right.Month, Right.Day);
  if LDate = RDate then
    Result := 0
  else if LDate < RDate then
    Result := -1
  else
    Result := 1;
end;

end.
