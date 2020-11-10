unit TypeCompRules_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm30 = class(TForm)
    BtnArrays: TButton;
    BtnGenerics: TButton;
    BtnGlobal: TButton;
    Memo1: TMemo;
    BtnOtherUnit: TButton;
    BtnTypeCheck: TButton;
    procedure BtnArraysClick(Sender: TObject);
    procedure BtnGenericsClick(Sender: TObject);
    procedure BtnGlobalClick(Sender: TObject);
    procedure BtnOtherUnitClick(Sender: TObject);
    procedure BtnTypeCheckClick(Sender: TObject);
  private
    procedure Log (const StrMsg: string);
  public
    { Public declarations }
  end;

var
  Form30: TForm30;

type
  TArrayOf10 = array [1..10] of Integer;

type
  TGenericArray<T> = class
    anArray: array [1..10] of T;
  end;

  TIntGenericArray = TGenericArray<Integer>;

implementation

uses
  TypInfo, TypeCompRules_OtherUnit;

{$R *.dfm}


procedure TForm30.BtnOtherUnitClick(Sender: TObject);
var
  Array1: TIntGenericArray;
  Array2: TypeCompRules_OtherUnit.TAntoherIntGenericArray;
begin
  Array1 := TIntGenericArray.Create;
  Array1 := Array2;
end;

procedure TForm30.BtnArraysClick(Sender: TObject);
var
  Array1: TArrayOf10;
  Array2: TArrayOf10;
  Array3, array4: array [1..10] of Integer;
begin
  Array1 := Array2;
  // Array2 := Array3; // E2010 Incompatible types: 'TArrayOf10' and 'Array'
  Array3 := array4;
  // array4 := Array1; // E2010 Incompatible types: 'Array' and 'TArrayOf10'
end;

procedure TForm30.BtnGenericsClick(Sender: TObject);
var
  Array1: TIntGenericArray;
  Array2: TIntGenericArray;
  Array3, array4: TGenericArray<Integer>;
begin
  Array1 := TIntGenericArray.Create;
  Array1.anArray[1] := 10; // assignment used... to avoid a warning
  Array2 := Array1;
  Array2.anArray[2] := 10;
  Array3 := Array2;
  Array3.anArray[3] := 10;
  array4 := Array3;
  array4.anArray[4] := 10;
  Array1 := array4;
  Array1.anArray[5] := 10;
end;

type
  TSimpleGeneric<T> = class
    FValue: T;
  end;

procedure TForm30.BtnTypeCheckClick(Sender: TObject);
var
  Sg1: TSimpleGeneric<string>;
  Sg2: TSimpleGeneric<Integer>;
begin
  Sg1 := TSimpleGeneric<string>.Create;
  Sg2 := TSimpleGeneric<Integer>.Create;

  Sg1.FValue := 'foo';
//  Sg1.FValue := 10; // E2010 Incompatible types: 'string' and 'Integer'

//  Sg2.FValue := 'foo';  // E2010 Incompatible types: 'Integer' and 'string'
  Sg2.FValue := 10;

  Sg1.Free;
  Sg2.Free;

//  Sg1 := TSimpleGeneric<Integer>.Create; // E2010 Incompatible types: 'TSimpleGeneric<System.string>' and 'TSimpleGeneric<System.Integer>'
end;

type
  TGlobalFunction<T> = class
  public
    class function AlmostGlobal: string;
    class function WithParam (t1: T): string;
  end;

// this is testing code that shoudl have been removed from the demo...
type TFoo = class
  procedure Test (integer: Integer);
end;

procedure TFoo.Test(integer: Integer);
//var
//  I: Integer;
begin
  ShowMessage (IntToStr (integer));
end;

procedure TForm30.BtnGlobalClick(Sender: TObject);
begin
  Log (TGlobalFunction<string>.AlmostGlobal);
  Log (TGlobalFunction<Int64>.AlmostGlobal);
  Log (TGlobalFunction<TButton>.AlmostGlobal);
  Log (TGlobalFunction<TButton>.WithParam (BtnGlobal));
  Log (TGlobalFunction<string>.WithParam ('foo'));
//  Log (TGlobalFunction<Integer>.WithParam (BtnGlobal)); // [DCC Error] TypeCompRules_MainForm.pas(100): E2010 Incompatible types: 'Integer' and 'TButton'
//  Log (TGlobalFunction<string>.WithParam (203)); // [DCC Error] TypeCompRules_MainForm.pas(101): E2010 Incompatible types: 'string' and 'Integer'

  // this is testing code that shoudl have been removed from the demo...
  with TFoo.Create do
  try
    Test (10);
  finally
    Free;
  end;
end;

procedure TForm30.Log(const StrMsg: string);
begin
  Memo1.Lines.Add (StrMsg);
end;

{ TGlobalFunction<T> }

class function TGlobalFunction<T>.AlmostGlobal: string;
begin
  Result := string(PTypeInfo (TypeInfo (T)).Name) + ': ' +
    IntToStr (SizeOf (T));
end;

class function TGlobalFunction<T>.WithParam (t1: T): string;
begin
  // what can I do with t1?
  Result := string(PTypeInfo (TypeInfo (T)).Name) + ': ' +
    IntToStr (SizeOf (T));
end;

{ TFoo }


end.
