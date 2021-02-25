unit GenericTypeFunc_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm30 = class(TForm)
    BtnShowInfo: TButton;
    Memo1: TMemo;
    BtnExperiments: TButton;
    procedure BtnShowInfoClick(Sender: TObject);
    procedure BtnExperimentsClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Log(const StrMsg: string);
  end;

var
  Form30: TForm30;

implementation

uses
  TypInfo;

{$R *.dfm}

type
  TSampleClass<T> = class
  private
    FData: T;
  public
    procedure Zero;
    function GetDataSize: Integer;
    function GetDataName: string;
  end;

procedure TForm30.BtnShowInfoClick(Sender: TObject);
var
  T1: TSampleClass<Integer>;
  T2: TSampleClass<string>;
  T3: TSampleClass<double>;
begin
  T1 := TSampleClass<Integer>.Create;
  T1.Zero;
  Log('TSampleClass<Integer>');
  Log('data: ' + IntToStr(T1.FData));
  Log('type: ' + T1.GetDataName);
  Log('size: ' + IntToStr(T1.GetDataSize));

  T2 := TSampleClass<string>.Create;
  T2.Zero;
  Log('TSampleClass<string>');
  Log('data: ' + T2.FData);
  Log('type: ' + T2.GetDataName);
  Log('size: ' + IntToStr(T2.GetDataSize));

  T3 := TSampleClass<double>.Create;
  T3.Zero;
  Log('TSampleClass<double>');
  Log('data: ' + FloatToStr(T3.FData));
  Log('type: ' + T3.GetDataName);
  Log('size: ' + IntToStr(T3.GetDataSize));
end;

procedure TForm30.BtnExperimentsClick(Sender: TObject);
var
  I: Integer;
  S: string;
begin
  I := Default(Integer);
  Log('Default Integer: ' + IntToStr(I));

  S := Default(string);
  Log('Default String: ' + S);

  Log('TypeInfo String: ' + GetTypeName(TypeInfo(string)));
end;

procedure TForm30.Log(const StrMsg: string);
begin
  Memo1.Lines.Add(StrMsg);
end;

{ TSampleClass<T> }

function TSampleClass<T>.GetDataSize: Integer;
begin
  Result := SizeOf(T);
end;

function TSampleClass<T>.GetDataName: string;
begin
  Result := GetTypeName(TypeInfo(T));
end;

procedure TSampleClass<T>.Zero;
begin
  FData := Default(T);
end;

end.
