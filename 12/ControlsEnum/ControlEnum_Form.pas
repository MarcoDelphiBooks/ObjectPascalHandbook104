unit ControlEnum_Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus;

type
  TControlEnumForm = class(TForm)
    Memo1: TMemo;
    BtnFormChild: TButton;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    Panel1: TPanel;
    BtnPanelChild: TButton;
    ComboBox1: TComboBox;
    BtnFormComps: TButton;
    BtnButtonChild: TButton;
    MainMenu1: TMainMenu;
    procedure BtnFormChildClick(Sender: TObject);
    procedure BtnFormCompsClick(Sender: TObject);
    procedure BtnPanelChildClick(Sender: TObject);
    procedure BtnButtonChildClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ControlEnumForm: TControlEnumForm;

type
  TControlsEnumHelper = class helper for TWinControl
  type
    TControlsEnum = class
    private
      NPos: Integer;
      FControl: TWinControl;
    public
      constructor Create(AControl: TWinControl);
      function MoveNext: Boolean;
      function GetCurrent: TControl;
      property Current: TControl read GetCurrent;
    end;
  public
    function GetEnumerator: TControlsEnum;
  end;


implementation

{$R *.dfm}

{ TControlsEnumHelper }

function TControlsEnumHelper.GetEnumerator: TControlsEnum;
begin
  Result := TControlsEnum.Create(self);
end;

{ TControlsEnumHelper.TControlsEnum }

constructor TControlsEnumHelper.TControlsEnum.Create(AControl: TWinControl);
begin
  FControl := AControl;
  NPos := -1;
end;

function TControlsEnumHelper.TControlsEnum.GetCurrent: TControl;
begin
  Result := FControl.Controls[NPos];
end;

function TControlsEnumHelper.TControlsEnum.MoveNext: Boolean;
begin
  Inc (NPos);
  Result := NPos < FControl.ControlCount;
end;

procedure TControlEnumForm.BtnButtonChildClick(Sender: TObject);
begin
  Memo1.Lines.Add('Button Child');
  for var ACtrl in BtnButtonChild do
    Memo1.Lines.Add(ACtrl.Name);
  Memo1.Lines.Add('');
end;

procedure TControlEnumForm.BtnFormChildClick(Sender: TObject);
begin
  Memo1.Lines.Add ('Form Child');
  for var ACtrl in self do
    Memo1.Lines.Add (ACtrl.Name);
  Memo1.Lines.Add ('');
end;

procedure TControlEnumForm.BtnFormCompsClick(Sender: TObject);
begin
  Memo1.Lines.Add('Form Components');
  for var AComp in TComponent(self) do
    Memo1.Lines.Add(AComp.Name);
  Memo1.Lines.Add('');
end;

procedure TControlEnumForm.BtnPanelChildClick(Sender: TObject);
begin
  Memo1.Lines.Add('Panel Child');
  for var ACtrl in Panel1 do
    Memo1.Lines.Add(ACtrl.Name);
  Memo1.Lines.Add('');
end;

end.
