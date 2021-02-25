unit AnonymFirst_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;


// Anonymous method type declaration
type
  TIntProc = reference to procedure(N: Integer);

// Method reference type declaration (not used, only to compare syntax)
type
  TIntMethod = procedure(N: Integer) of object;

type
  TFormAnonymFirst = class(TForm)
    BtnSimpleVar: TButton;
    Memo1: TMemo;
    BtnProcParam: TButton;
    BtnLocalVal: TButton;
    BtnStore: TButton;
    BtnCall: TButton;
    BtnNoParen: TButton;
    BtnReturn: TButton;
    procedure BtnSimpleVarClick(Sender: TObject);
    procedure BtnProcParamClick(Sender: TObject);
    procedure BtnLocalValClick(Sender: TObject);
    procedure BtnStoreClick(Sender: TObject);
    procedure BtnCallClick(Sender: TObject);
    procedure BtnReturnClick(Sender: TObject);
  private
    FAnonMeth: TIntProc;
    procedure SetAnonMeth(const Value: TIntProc);
    function GetShowMethod: TIntProc;
  public
    property AnonMeth: TIntProc read FAnonMeth write SetAnonMeth;
  end;

var
  FormAnonymFirst: TFormAnonymFirst;

implementation

{$R *.dfm}

procedure CallTwice(value: Integer; AnIntProc: TIntProc);
begin
  AnIntProc (value);
  Inc (value);
  AnIntProc (value);
end;

procedure TFormAnonymFirst.BtnCallClick(Sender: TObject);
begin
  if Assigned(AnonMeth) then
  begin
    AnonMeth(5);
  end;
end;

procedure TFormAnonymFirst.BtnLocalValClick(Sender: TObject);
var
  ANumber: Integer;
begin
  ANumber := 0;
  CallTwice(10, procedure(n: Integer)
    begin
      Inc (ANumber, n);
    end);
  Memo1.Lines.Add(IntToStr(ANumber));
end;

procedure TFormAnonymFirst.BtnProcParamClick(Sender: TObject);
begin
  CallTwice(48,
    procedure(N: Integer)
    begin
      Memo1.Lines.Add(IntToHex (N, 4));
    end);
  CallTwice(100,
    procedure(N: Integer)
    begin
      Memo1.Lines.Add(FloatToStr(Sqrt(N)));
    end);
end;

procedure TFormAnonymFirst.BtnSimpleVarClick(Sender: TObject);
var
  AnIntProc: TIntProc;
begin
  AnIntProc := procedure(N: Integer)
  begin
    Memo1.Lines.Add(IntToStr(N));
  end;
  AnIntProc(22);
  AnIntProc(22);
end;

procedure TFormAnonymFirst.BtnStoreClick(Sender: TObject);
var
  ANumber: Integer;
begin
  ANumber := 3;
  AnonMeth := procedure(N: Integer)
    begin
      Inc(ANumber, N);
      Memo1.Lines.Add(IntToStr(ANumber));
    end;
end;

function TFormAnonymFirst.GetShowMethod: TIntProc;
var
  X: Integer;
begin
  X := Random(100);
  Memo1.Lines.Add('New X is ' + IntToStr(X));
  Result := procedure (N: Integer)
  begin
    X := X + N;
    Memo1.Lines.Add(IntToStr(X));
  end;
end;

procedure TFormAnonymFirst.BtnReturnClick(Sender: TObject);
var
  Ip: TIntProc;
begin
  GetShowMethod; // compiles, but probably not what you want

  // call using a te
  // ip := GetShowMethod; // E2010 Incompatible types: 'TIntProc' and 'Procedure of object'
  Ip := GetShowMethod();
  Ip(3);

  //GetShowMethod(3); // E2034 Too many actual parameters
  GetShowMethod()(3);
end;

procedure TFormAnonymFirst.SetAnonMeth(const Value: TIntProc);
begin
  FAnonMeth := Value;
end;

initialization
  Randomize;

end.
