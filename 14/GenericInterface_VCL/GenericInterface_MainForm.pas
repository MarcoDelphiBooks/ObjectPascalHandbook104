unit GenericInterface_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormGenericInterface = class(TForm)
    BtnValue: TButton;
    Memo1: TMemo;
    BtnValueButton: TButton;
    BtnIValue: TButton;
    ScrollBox1: TScrollBox;
    procedure BtnValueClick(Sender: TObject);
    procedure BtnIValueClick(Sender: TObject);
    procedure BtnValueButtonClick(Sender: TObject);
  private
    procedure Log(const StrMsg: string);
  public
    { Public declarations }
  end;

var
  FormGenericInterface: TFormGenericInterface;

implementation

{$R *.dfm}

uses
  Math, Generics.Defaults;

type
  IGetValue<T> = interface
    function GetValue: T;
    procedure SetValue (Value: T);
  end;

  TGetValue<T> = class(TInterfacedObject, IGetValue<T>)
  private
    FValue: T;
  public
    constructor Create(Value: T);
    destructor Destroy; override;
    function GetValue: T;
    procedure SetValue(Value: T);
  end;

  TButtonValue = class(TButton, IGetValue<Integer>)
  public
    function GetValue: Integer;
    procedure SetValue(Value: Integer);
    class function MakeTButtonValue(
      Owner: TComponent; Parent: TWinControl): TButtonValue;
  end;

{ TGetValue }

constructor TGetValue<T>.Create(Value: T);
begin
  FValue := Value;
end;

destructor TGetValue<T>.Destroy;
begin
  FormGenericInterface.Log('Destroyed');
end;

function TGetValue<T>.GetValue: T;
begin
  Result := FValue;
end;

procedure TGetValue<T>.SetValue(Value: T);
begin
  FValue := Value;
end;

{ TButtonValue }

function TButtonValue.GetValue: Integer;
begin
  Result := Left;
end;

class function TButtonValue.MakeTButtonValue(Owner: TComponent;
  Parent: TWinControl): TButtonValue;
begin
  Result := TButtonValue.Create(Owner);
  Result.Parent := Parent;
  Result.SetBounds(
    Random(Parent.Width), Random(Parent.Height),
    Result.Width, Result.Height);
  Result.Caption := 'btnv';
end;

procedure TButtonValue.SetValue(Value: Integer);
begin
  Left := Value;
end;

procedure TFormGenericInterface.BtnValueButtonClick(Sender: TObject);
var
  IVal: IGetValue<Integer>;
begin
  IVal := TButtonValue.MakeTButtonValue(self, ScrollBox1);
  Log('Button value: ' + IntToStr(IVal.GetValue));
end;

procedure TFormGenericInterface.BtnValueClick(Sender: TObject);
var
  AVal: TGetValue<string>;
begin
  AVal := TGetValue<string>.Create(Caption);
  try
    Log('TGetValue value: ' + AVal.GetValue);
  finally
    AVal.Free;
  end;
end;

procedure TFormGenericInterface.BtnIValueClick(Sender: TObject);
var
  AVal: IGetValue<string>;
begin
  AVal := TGetValue<string>.Create(Caption);
  Log('IGetValue value: ' + AVal.GetValue);
  // Freed automatically, as it is reference counted
end;

procedure TFormGenericInterface.Log(const StrMsg: string);
begin
  Memo1.Lines.Add(StrMsg);
end;

initialization
  Randomize;

end.
