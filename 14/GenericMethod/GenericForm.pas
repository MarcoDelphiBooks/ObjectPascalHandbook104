unit GenericForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.Memo.Types, FMX.Controls.Presentation,
  FMX.ScrollBox;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Show(const msg: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  TypInfo;

type
  TGenericFunction = class
  public
    function WithParam<T>(T1: T): string;
  end;

procedure TForm1.Button1Click(Sender: TObject);
var
  GF: TGenericFunction;
begin
  GF := TGenericFunction.Create;
  try
    Show(GF.WithParam<string>('foo'));
    Show(GF.WithParam<Integer> (122));
    Show(GF.WithParam('hello'));
    Show(GF.WithParam(122));
    Show(GF.WithParam(Button1));
    Show(GF.WithParam<TObject>(Button1));
  finally
    GF.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  GF: TGenericFunction;
begin
  GF := TGenericFunction.Create;
  try
    // these 3 are all wrong
    // Show(GF.WithParam<Integer>('foo'));
    // Show(GF.WithParam<string>(122));
    // Show GF.WithParam<TButton>(self));
  finally
    GF.Free;
  end;
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

{ TGenericFunction }

function TGenericFunction.WithParam<T>(T1: T): string;
begin
  Result := GetTypeName(TypeInfo(T));
  // if IsManagedType(T) then
  //   Result := Result + ' managed';
end;

end.
