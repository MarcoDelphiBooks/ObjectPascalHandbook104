unit RttiAttribMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm39 = class(TForm)
    BtnMethods: TButton;
    Memo1: TMemo;
    BtnClassAttribs: TButton;
    BtnInvokeIfZero: TButton;
    procedure BtnMethodsClick(Sender: TObject);
    procedure BtnClassAttribsClick(Sender: TObject);
    procedure BtnInvokeIfZeroClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Log(const StrMsg: string);
  end;

type
  SimpleAttribute = class(TCustomAttribute)
  end;

  ValueAttribute = class(TCustomAttribute)
  private
    FValue: Integer;
  public
    constructor Create(N: Integer);
    property Value: Integer read FValue write FValue;
  end;

type
  // Uncommenting [More] causes a warning and is ignored
  [Simple][Value(22)]  // [More]
  TMyClass = class(TObject)
  public
    [Simple]
    procedure One;
    [Value(0)]
    procedure Two;

    procedure Three;
  end;

var
  Form39: TForm39;

implementation

{$R *.dfm}

uses
  System.Rtti;

{ FooAttribute }

constructor ValueAttribute.Create(N: Integer);
begin
  FValue := N;
end;

type
  TCustomAttributeClass = class of TCustomAttribute;

function HasAttribute(AMethod: TRttiMethod; AttribClass: TCustomAttributeClass): Boolean;
var
  Attributes: TArray<TCustomAttribute>;
  Attrib: TCustomAttribute;
begin
  Result := False;
  Attributes := AMethod.GetAttributes;
  for Attrib in Attributes do
     if Attrib.InheritsFrom(AttribClass) then
       Exit (True);
end;

procedure TForm39.BtnInvokeIfZeroClick(Sender: TObject);
var
  Context: TRttiContext;
  AType: TRttiType;
  AMethod: TRttiMethod;
  ATarget: TMyClass;
  ZeroParams: array of TValue;
begin
  ATarget := TMyClass.Create;
  try
    AType := Context.GetType(ATarget.ClassType);
    for AMethod in AType.GetMethods do
      if HasAttribute(AMethod, SimpleAttribute) then
        AMethod.Invoke(ATarget, ZeroParams);
  finally
    ATarget.Free;
  end;
end;

procedure TForm39.BtnMethodsClick(Sender: TObject);
var
  Context: TRttiContext;
  AType: TRttiType;
  AMethod: TRttiMethod;
begin
  AType := Context.GetType(TMyClass);

  Log('Methods marked with [Simple] attribute');
  for AMethod in AType.GetMethods do
    if HasAttribute(AMethod, SimpleAttribute) then
      Log (AMethod.name);

  Log('');
  Log('Methods marked with any attribute');
  for AMethod in AType.GetMethods do
    if HasAttribute(AMethod, TCustomAttribute) then
      Log (AMethod.name);
end;

{ TMyClass }

procedure TMyClass.One;
var
  Context: TRttiContext;
  Attributes: TArray<TCustomAttribute>;
  Attrib: TCustomAttribute;
begin
  Attributes := Context.GetType(ClassType).GetAttributes;
  for Attrib in Attributes do
  begin
    Form39.Log(Attrib.ClassName);
    if Attrib is ValueAttribute then
      Form39.Log(' -' + IntToStr(ValueAttribute(Attrib).Value));
  end;
end;

procedure TMyClass.Three;
begin
  ShowMessage('Three');
end;

procedure TMyClass.Two;
begin
  //
end;

procedure TForm39.BtnClassAttribsClick(Sender: TObject);
begin
  with TMyClass.Create do
  begin
    One;
  end;
end;

procedure TForm39.Log(const StrMsg: string);
begin
  Memo1.Lines.Add(StrMsg);
end;

end.
