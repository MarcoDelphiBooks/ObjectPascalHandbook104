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
    Person1: TPerson;
    Vmi: TVirtualMethodInterceptor;
  public
    procedure Log (const StrMsg: string);
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
  Vmi.Unproxify(Person1); // xe2 only
end;

procedure TFormIntercept.BtnInterceptClick(Sender: TObject);
begin
  Vmi := TVirtualMethodInterceptor.Create(TPerson);
  Vmi.OnBefore := procedure(Instance: TObject; Method: TRttiMethod;
      const Args: TArray<TValue>; out DoInvoke: Boolean; out Result: TValue)
    begin
      Log('Before calling ' + Method.Name);
      if Method.Name = 'Age' then
      begin
        Result := 33;
        DoInvoke := False;
      end;
    end;
  Vmi.OnAfter := procedure(Instance: TObject; Method: TRttiMethod;
      const Args: TArray<TValue>; var Result: TValue)
    begin
      Log('After calling ' + Method.Name);
    end;
  Vmi.Proxify(Person1);
end;

procedure TFormIntercept.BtnUseClick(Sender: TObject);
begin
  // use object
  Log ('Age: ' + IntToStr (Person1.Age));
  Log ('Person: ' + Person1.ToString);
  Log ('Class: ' + Person1.ClassName);
  Log ('Base Class: ' + Person1.ClassParent.ClassName);
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
  Result := FName + ' is ' + IntToStr (Age) + ' years old';
end;

procedure TFormIntercept.FormCreate(Sender: TObject);
begin
  Person1 := TPerson.Create;
  Person1.Name := 'Mark';
  Person1.BirthDate := EncodeDate (1984, 5, 14);
end;

procedure TFormIntercept.Log(const StrMsg: string);
begin
  Memo1.Lines.Add (StrMsg);
end;

end.
