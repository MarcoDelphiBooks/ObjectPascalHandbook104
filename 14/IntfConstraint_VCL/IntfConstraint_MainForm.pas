unit IntfConstraint_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormIntfConstraint = class(TForm)
    BtnValue: TButton;
    Memo1: TMemo;
    BtnValueButton: TButton;
    BtnPlainIntf: TButton;
    BtnConstructor: TButton;
    ScrollBox1: TScrollBox;
    procedure BtnValueClick(Sender: TObject);
    procedure BtnPlainIntfClick(Sender: TObject);
    procedure BtnConstructorClick(Sender: TObject);
    procedure BtnValueButtonClick(Sender: TObject);
  private
    procedure Log(const StrMsg: string);
  public
    { Public declarations }
  end;

var
  FormIntfConstraint: TFormIntfConstraint;

implementation

{$R *.dfm}

uses
  Math, Generics.Defaults;

type
  IGetValue = interface
    ['{60700EC4-2CDA-4CD1-A1A2-07973D9D2444}']
    function GetValue: Integer;
    procedure SetValue(Value: Integer);
  end;

  // preDelphi 11:
  // TGetValue = class(TSingletonImplementation, IGetValue)
  // Delphi 11:
  TGetValue = class(TNoRefCountObject, IGetValue)
  private
    FValue: Integer;
  public
    constructor Create(Value: Integer); // = 0);
    function GetValue: Integer;
    procedure SetValue(Value: Integer);
  end;

  TButtonValue = class(TButton, IGetValue)
  public
    function GetValue: Integer;
    procedure SetValue(Value: Integer);
    class function MakeTButtonValue(
      Owner: TComponent; Parent: TWinControl): TButtonValue;
  end;

  TInftClass<T: IGetValue> = class
  private
    FVal1, FVal2: T; // or IGetValue
  public
    procedure Set1(Val: T);
    procedure Set2(Val: T);
    function GetMin: Integer;
    function GetAverage: Integer;
    procedure IncreaseByTen;
  end;

  TPlainInftClass = class
  private
    FVal1, FVal2: IGetValue;
  public
    procedure Set1(Val: IGetValue);
    procedure Set2(Val: IGetValue);
    function GetMin: Integer;
    function GetAverage: Integer;
    procedure IncreaseByTen;
  end;

  TConstrClass<T: class, constructor> = class
  private
    FVal: T;
  public
    constructor Create;
    function Get: T;
  end;

  // not used, code test only
  TInftComp<T: TComponent, IGetValue> = class
  private
    FVal: T;
  public
    function GetTheValue: Integer;
  end;


{ TGetValue }

constructor TGetValue.Create(Value: Integer);
begin
  FValue := Value;
end;

function TGetValue.GetValue: Integer;
begin
  Result := FValue;
end;

procedure TGetValue.SetValue(Value: Integer);
begin
  FValue := Value;
end;

{ TInftClass<T> }

function TInftClass<T>.GetAverage: Integer;
begin
  if Assigned(FVal1) and Assigned(FVal2) then
    Result := (FVal1.GetValue + FVal2.GetValue) div 2
  else
    Result := 0;
end;

function TInftClass<T>.GetMin: Integer;
begin
  if Assigned(FVal1) and Assigned(FVal2) then
    Result := Min(FVal1.GetValue, FVal2.GetValue)
  else
    Result := 0;
end;

procedure TInftClass<T>.IncreaseByTen;
begin
  if Assigned(FVal1) and Assigned(FVal2) then
  begin
    FVal1.SetValue(FVal1.GetValue + 10);
    FVal2.SetValue(FVal2.GetValue + 10);
  end;
end;

procedure TInftClass<T>.Set1(Val: T);
begin
  FVal1 := Val;
end;

procedure TInftClass<T>.Set2(Val: T);
begin
  FVal2 := Val;
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

procedure TFormIntfConstraint.BtnValueButtonClick(Sender: TObject);
var
  IClass: TInftClass<TButtonValue>;
begin
  IClass := TInftClass<TButtonValue>.Create;
  IClass.Set1(TButtonValue.MakeTButtonValue(self, ScrollBox1));
  IClass.Set2(TButtonValue.MakeTButtonValue(self, ScrollBox1));
  Log('Average: ' + IntToStr(IClass.GetAverage));
  Log('Min: ' + IntToStr(IClass.GetMin));
  IClass.IncreaseByTen;
  Log('New Average: ' + IntToStr(IClass.GetAverage));
end;

procedure TFormIntfConstraint.BtnValueClick(Sender: TObject);
var
  IClass: TInftClass<TGetValue>;
begin
  IClass := TInftClass<TGetValue>.Create;
  IClass.Set1 (TGetValue.Create(5));
  IClass.Set2 (TGetValue.Create(25));
  Log('Average: ' + IntToStr(IClass.GetAverage));
  IClass.IncreaseByTen;
  Log('Min: ' + IntToStr(IClass.GetMin));
end;

procedure TFormIntfConstraint.BtnPlainIntfClick(Sender: TObject);
var
  AClass: TPlainInftClass;
begin
  AClass := TPlainInftClass.Create;
  AClass.Set1 (TGetValue.Create(5));
  AClass.Set2 (TGetValue.Create(25));
  Log('Average: ' + IntToStr(AClass.GetAverage));
  AClass.IncreaseByTen;
  Log('Min: ' + IntToStr(AClass.GetMin));
end;

type
  TSimpleConst = class
  public
    FValue: Integer;
    constructor Create;
  end;

type
  TParamConst = class
  public
    FValue: Integer;
    constructor Create(I: Integer);
  end;


procedure TFormIntfConstraint.BtnConstructorClick(Sender: TObject);
var
  ConstructObj: TConstrClass<TSimpleConst>;
  ParamCostObj: TConstrClass<TParamConst>;
begin
  ConstructObj := TConstrClass<TSimpleConst>.Create;
  Log('Value 1: ' + IntToStr(ConstructObj.Get.FValue));

  ParamCostObj := TConstrClass<TParamConst>.Create;
  Log('Value 2: ' + IntToStr(ParamCostObj.Get.FValue));

//  with TParamConst.Create do
//  begin
//    //
//  end;
end;

procedure TFormIntfConstraint.Log(const StrMsg: string);
begin
  Memo1.Lines.Add(StrMsg);
end;

{ TPlainInftClass }

function TPlainInftClass.GetAverage: Integer;
begin
  Result := (FVal1.GetValue + FVal2.GetValue) div 2;
end;

function TPlainInftClass.GetMin: Integer;
begin
  Result := Min(FVal1.GetValue, FVal2.GetValue);
end;

procedure TPlainInftClass.IncreaseByTen;
begin
  FVal1.SetValue(FVal1.GetValue + 10);
  FVal2.SetValue(FVal2.GetValue + 10);
end;

procedure TPlainInftClass.Set1(Val: IGetValue);
begin
  FVal1 := Val;
end;

procedure TPlainInftClass.Set2(Val: IGetValue);
begin
  FVal2 := Val;
end;

{ TConstrClass<T> }

constructor TConstrClass<T>.Create;
begin
  FVal := T.Create;
end;

function TConstrClass<T>.Get: T;
begin
  Result := FVal;
end;

{ TSimpleCont }

constructor TSimpleConst.Create;
begin
  FValue := 10;
end;

{ TParamCont }

constructor TParamConst.Create(I: Integer);
begin
  FValue := I;
end;

{ TInftComp<T> }

function TInftComp<T>.GetTheValue: Integer;
begin
  Result := FVal.GetValue;
end;

initialization
  Randomize;

end.
