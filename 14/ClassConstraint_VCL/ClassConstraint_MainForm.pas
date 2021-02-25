unit ClassConstraint_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm30 = class(TForm)
    Memo1: TMemo;
    Create: TButton;
    Wrong: TButton;
    Button1: TButton;
    procedure CreateClick(Sender: TObject);
    procedure WrongClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Log(const StrMsg: string);
  end;

var
  Form30: TForm30;

implementation

{$R *.dfm}

type
  TSampleClass<T: class> = class
  private
    FData: T;
  public
    procedure One;
    function ReadT: T;
    procedure SetT(T1: T);
  end;

{ TSampleClass<T> }

procedure TSampleClass<T>.One;
begin
  if Assigned(FData) then
  begin
    Form30.Log('ClassName: ' + FData.ClassName);
    Form30.Log('Size: ' + IntToStr(FData.InstanceSize));
    Form30.Log('ToString: ' + FData.ToString);
  end;
end;

function TSampleClass<T>.ReadT: T;
begin
  Result := FData;
end;

procedure TSampleClass<T>.SetT(T1: T);
begin
  FData := T1;
end;

{ TForm30 }

type
  TMyButton = class(TButton)
  public
    function ToString: string; override;
  end;

procedure TForm30.Button1Click(Sender: TObject);
var
  Sample1: TSampleClass<TButton>;
  Sample2: TSampleClass<TMyButton>;
  MB: TMybutton;
begin
  MB := TMyButton.Create(self);
  MB.Caption := 'Hello';

  Sample1 := TSampleClass<TButton>.Create;
  try
    Sample1.SetT(MB);
    Sample1.One;
  finally
    Sample1.Free;
  end;

  Sample2 := TSampleClass<TMyButton>.Create;
  try
    Sample2.SetT(MB);
    Sample2.One;
  finally
    Sample2.Free;
  end;

end;

procedure TForm30.createClick(Sender: TObject);
var
  Sample1: TSampleClass<TButton>;
  Sample2: TSampleClass<TStrings>;
begin
  Sample1 := TSampleClass<TButton>.Create;
  try
    Sample1.SetT(Sender as TButton);
    Sample1.One;
  finally
    Sample1.Free;
  end;

  Sample2 := TSampleClass<TStrings>.Create;
  try
    Sample2.SetT(Memo1.Lines);
    Sample2.One;
  finally
    Sample2.Free;
  end;
end;

procedure TForm30.Log(const StrMsg: string);
begin
  Memo1.Lines.Add(StrMsg);
end;

procedure TForm30.wrongClick(Sender: TObject);
//var
//  Sample3: TSampleClass<Integer>;
//  // E2511 Type parameter 'T' must be a class type
begin
  // Nothing do to
end;

{ TMyButton }

function TMyButton.ToString: string;
begin
  Result := Caption;
end;

end.
