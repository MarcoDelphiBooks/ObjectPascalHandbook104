unit SystemObject_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TAnyObject = class
  private
    Value: Integer;
    Name: string;
  public
    constructor Create(AName: string; AValue: Integer);
    function Equals(Obj: TObject): Boolean; override;
    function ToString: string; override;
  end;

  TFormSystemObject = class(TForm)
    Memo1: TMemo;
    BtnCompare: TButton;
    BtnTest: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Button1: TButton;
    procedure BtnCompareClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnTestClick(Sender: TObject);
  private
    AO1, AO2, AO3, AO4: TAnyObject;
    procedure Log(const StrMsg: string);
  public
    { Public declarations }
  end;

var
  FormSystemObject: TFormSystemObject;

implementation

uses
  TypInfo;

{$R *.dfm}

procedure TFormSystemObject.BtnCompareClick(Sender: TObject);
begin
  Log('Comparing ' + ComboBox1.Items[ComboBox1.ItemIndex] +
    ' and ' + ComboBox2.Items[ComboBox2.ItemIndex]);
  Log('Equals: ' +
    BoolToStr(ComboBox1.Items.Objects[ComboBox1.ItemIndex].Equals(
      ComboBox2.Items.Objects[ComboBox2.ItemIndex]), True));
  Log('Reference = ' +
    BoolToStr(ComboBox1.Items.Objects[ComboBox1.ItemIndex] =
      ComboBox2.Items.Objects[ComboBox2.ItemIndex], True));
end;

{ TAnyObject }

constructor TAnyObject.Create(AName: string; AValue: Integer);
begin
  inherited Create;
  Name := AName;
  Value := AValue;
end;

function TAnyObject.Equals(Obj: TObject): Boolean;
begin
  Result := (Obj.ClassType = self.ClassType) and
    ((Obj as TAnyObject).Value = self.Value)
end;

function TAnyObject.ToString: string;
begin
  Result := Name;
end;

procedure TFormSystemObject.BtnTestClick(Sender: TObject);
var
  Btn2: TButton;
begin
  Btn2 := BtnTest;
  Log('Equals: ' + BoolToStr(BtnTest.Equals(Btn2), True));
  Log('Reference = ' + BoolToStr(BtnTest = Btn2, True));
  Log('GetHashCode: ' + IntToStr(BtnTest.GetHashCode));
  Log('ToString: ' + BtnTest.ToString);
end;

procedure TFormSystemObject.FormCreate(Sender: TObject);
begin
  AO1 := TAnyObject.Create('AO1', 10);
  AO2 := TAnyObject.Create('AO2 or AO3', 20);
  AO3 := AO2;
  AO4 := TAnyObject.Create('AO4', 20);

  ComboBox1.Items.AddObject(AO1.ToString, AO1);
  ComboBox1.Items.AddObject(AO2.ToString, AO2);
  ComboBox1.Items.AddObject(AO3.ToString, AO3);
  ComboBox1.Items.AddObject(AO4.ToString, AO4);

  ComboBox2.Items.AddObject(AO1.ToString, AO1);
  ComboBox2.Items.AddObject(AO2.ToString, AO2);
  ComboBox2.Items.AddObject(AO3.ToString, AO3);
  ComboBox2.Items.AddObject(AO4.ToString, AO4);
end;


procedure TFormSystemObject.Log(const StrMsg: string);
begin
  Memo1.Lines.Add(StrMsg);
end;

end.
