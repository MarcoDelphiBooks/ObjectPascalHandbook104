unit AnonButtonForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo.Types;

type
  TAnonNotif = reference to procedure (Sender: TObject);

  // interceptor class
  TButton = class (FMX.StdCtrls.TButton)
  private
    FAnonClick: TAnonNotif;
    procedure SetAnonClick(const Value: TAnonNotif);
  public
    procedure Click; override;
  public
    property AnonClick: TAnonNotif read FAnonClick write SetAnonClick;
  end;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    BtnAssign: TButton;
    BtnInvoke: TButton;
    BtnKeepRef: TButton;
    procedure BtnAssignClick(Sender: TObject);
    procedure BtnKeepRefClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Show(const Msg: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TButton.SetAnonClick(const Value: TAnonNotif);
begin
  FAnonClick := Value;
end;

procedure TButton.Click;
begin
  if Assigned(FAnonClick) then
    FAnonClick(self);
  inherited;
end;

procedure TForm1.BtnAssignClick(Sender: TObject);
begin
  btnInvoke.AnonClick :=
    procedure(Sender: TObject)
    begin
      ShowMessage((Sender as TButton).Text);
    end;
end;

procedure TForm1.BtnKeepRefClick(Sender: TObject);
var
  ACompRef: TComponent;
begin
  ACompRef := Sender as TComponent;
  btnInvoke.AnonClick := procedure(Sender: TObject)
    begin
      ShowMessage((Sender as TButton).Text +
        ' assigned by ' + ACompRef.Name);
    end;
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
