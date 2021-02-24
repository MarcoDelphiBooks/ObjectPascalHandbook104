unit ViewDatesForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, Dates, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo.Types, FMX.Edit;

type
  TDateForm = class(TForm)
    Memo1: TMemo;
    BtnToday: TButton;
    BtnIncrease: TButton;
    BtnDecrease: TButton;
    LabelDate: TLabel;
    BtnAdd10: TButton;
    BtnSubtract10: TButton;
    BtnLeapyear: TButton;
    GridPanelLayout1: TGridPanelLayout;
    Label1: TLabel;
    EditDay: TEdit;
    Label2: TLabel;
    EditMonth: TEdit;
    Label3: TLabel;
    EditYear: TEdit;
    BtnWrite: TButton;
    BtnRead: TButton;
    procedure BtnTodayClick(Sender: TObject);
    procedure BtnIncreaseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnLeapyearClick(Sender: TObject);
    procedure BtnDecreaseClick(Sender: TObject);
    procedure BtnAdd10Click(Sender: TObject);
    procedure BtnSubtract10Click(Sender: TObject);
    procedure BtnReadClick(Sender: TObject);
    procedure BtnWriteClick(Sender: TObject);
  private
    FDay: TDate;
  public
    procedure Show (const Msg: string);
  end;

var
  DateForm: TDateForm;

implementation

{$R *.fmx}

uses
  DateUtils;

procedure TDateForm.BtnLeapyearClick(Sender: TObject);
begin
  if FDay.LeapYear then
    Show ('Leap year: ' + FDay.GetText)
  else
    Show ('Not a leap year: ' + FDay.GetText);
end;

procedure TDateForm.BtnSubtract10Click(Sender: TObject);
begin
  FDay.Decrease (10);
  LabelDate.Text := FDay.GetText;
end;

procedure TDateForm.BtnTodayClick(Sender: TObject);
begin
  FDay.SetValue(Today);
  LabelDate.Text := FDay.GetText;
end;

procedure TDateForm.BtnWriteClick(Sender: TObject);
begin
  // direct use of properties
  FDay.Year := EditYear.Text.ToInteger;
  FDay.Month := EditMonth.Text.ToInteger;
  FDay.Day := EditDay.Text.ToInteger;

  // update all values at once
  FDay.SetValue (EditMonth.Text.ToInteger,
    EditDay.Text.ToInteger,
    EditYear.Text.ToInteger);

  LabelDate.Text := FDay.GetText;
end;

procedure TDateForm.FormCreate(Sender: TObject);
begin
  // create
  FDay := TDate.Create; // today
  LabelDate.Text := FDay.GetText;
end;

procedure TDateForm.FormDestroy(Sender: TObject);
begin
  FDay.Free;
end;

procedure TDateForm.BtnAdd10Click(Sender: TObject);
begin
  FDay.Increase (10);
  LabelDate.Text := FDay.GetText;
end;

procedure TDateForm.BtnDecreaseClick(Sender: TObject);
begin
  FDay.Decrease;
  LabelDate.Text := FDay.GetText;
end;

procedure TDateForm.BtnReadClick(Sender: TObject);
begin
  EditYear.Text := FDay.Year.ToString;
  EditMonth.Text := FDay.Month.ToString;
  EditDay.Text := FDay.Day.ToString;
end;

procedure TDateForm.BtnIncreaseClick(Sender: TObject);
begin
  FDay.Increase;
  LabelDate.Text := FDay.GetText;
end;

procedure TDateForm.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
