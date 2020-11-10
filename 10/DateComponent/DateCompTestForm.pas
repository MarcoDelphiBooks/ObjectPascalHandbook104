unit DateCompTestForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, DateComponent, FMX.Controls.Presentation;

type
  TFormDate = class(TForm)
    BtnInc: TButton;
    Date1: TDate;
    Label1: TLabel;
    procedure Date1Change(Sender: TObject);
    procedure BtnIncClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  FormDate: TFormDate;

implementation

{$R *.fmx}


procedure TFormDate.BtnIncClick(Sender: TObject);
begin
  Date1.Increase;
end;

procedure TFormDate.Date1Change(Sender: TObject);
begin
  Label1.Text := Date1.GetText;
end;

procedure TFormDate.FormCreate(Sender: TObject);
begin
  Label1.Text := Date1.GetText;
end;

end.
