unit InterceptBaseClass_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RTTI;

type
  TPerson = class
  private
    FBirthDate: TDate;
    FName: string;
    procedure SetBirthDate(const Value: TDate);
    procedure SetName(const Value: string);
  public
    property Name: string read FName write SetName;
    property BirthDate: TDate read FBirthDate write SetBirthDate;
    function Age: Integer; virtual;
    function ToString: string; override;
  end;

  TFormIntercept = class(TForm)
    BtnUse: TButton;
    BtnIntercept: TButton;
    BtnDisconnect: TButton;
    Memo1: TMemo;
    procedure BtnUseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnInterceptClick(Sender: TObject);
    procedure BtnDisconnectClick(Sender: TObject);
  private
    FPerson1: TPerson;
    FVmi: TVirtualMethodInterceptor;
  public
    procedure Log(const StrMsg: string);
  end;

var
  FormIntercept: TFormIntercept;

implementation

uses
  System.DateUtils;

{$R *.dfm}

procedure TFormIntercept.BtnDisconnectClick(Sender: TObject);
begin
  // PPointer(Person1)^ := vmi.OriginalClass;
  FVmi.Unproxify(FPerson1);
end;

procedure TFormIntercept.BtnInterceptClick(Sender: TObject);
begin
  FVmi := TVirtualMethodInterceptor.Create(TPerson);
  FVmi.OnBefore := procedure(Instance: TObject; Method: TRttiMethod;
      const Args: TArray<TValue>; out DoInvoke: Boolean; out Result: TValue)
    begin
      Log('Before calling ' + Method.Name);
      if Method.Name = 'Age' then
      begin
        Result := 33;
        DoInvoke := False;
      end;
    end;
  FVmi.OnAfter := procedure(Instance: TObject; Method: TRttiMethod;
      const Args: TArray<TValue>; var Result: TValue)
    begin
      Log('After calling ' + Method.Name);
    end;
  FVmi.Proxify(FPerson1);
end;

procedure TFormIntercept.BtnUseClick(Sender: TObject);
begin
  // use object
  Log('Age: ' + IntToStr(FPerson1.Age));
  Log('Person: ' + FPerson1.ToString);
  Log('Class: ' + FPerson1.ClassName);
  Log('Base Class: ' + FPerson1.ClassParent.ClassName);
end;

{ TPerson }

function TPerson.Age: Integer;
begin
  Result := YearsBetween (Date, FBirthDate);
end;

procedure TPerson.SetBirthDate(const Value: TDate);
begin
  FBirthDate := Value;
end;

procedure TPerson.SetName(const Value: string);
begin
  FName := Value;
end;

function TPerson.ToString: string;
begin
  Result := FName + ' is ' + IntToStr(Age) + ' years old';
end;

procedure TFormIntercept.FormCreate(Sender: TObject);
begin
  FPerson1 := TPerson.Create;
  FPerson1.Name := 'Mark';
  FPerson1.BirthDate := EncodeDate(1984, 5, 14);
end;

procedure TFormIntercept.Log(const StrMsg: string);
begin
  Memo1.Lines.Add(StrMsg);
end;

end.
