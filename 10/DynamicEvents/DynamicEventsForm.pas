unit DynamicEventsForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.Controls.Presentation;

type
  TFormDynamic = class(TForm)
    BtnTest: TButton;
    procedure BtnTestClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    FCounter: Integer;
  public
    procedure BtnTest2Click(Sender: TObject);
    procedure BtnNewClick(Sender: TObject);
  end;

var
  FormDynamic: TFormDynamic;

implementation

{$R *.fmx}

procedure TFormDynamic.BtnNewClick(Sender: TObject);
begin
  ShowMessage('You selected ' + (Sender as TButton).Text)
end;

procedure TFormDynamic.BtnTest2Click(Sender: TObject);
begin
  ShowMessage('Test message, again');
end;

procedure TFormDynamic.BtnTestClick(Sender: TObject);
begin
  ShowMessage('Test message');
  BtnTest.OnClick := BtnTest2Click;
end;

procedure TFormDynamic.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  AButton: TButton;
begin
  AButton := TButton.Create(self);
  AButton.Parent := self;
  AButton.SetBounds(X, Y, 100, 40);
  Inc(FCounter);
  AButton.Text := 'Button' + FCounter.ToString;
  AButton.OnClick := BtnNewClick;
end;

end.
