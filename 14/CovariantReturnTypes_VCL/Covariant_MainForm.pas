unit Covariant_MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

type
  TAnimal = class
  private
    FName: string;
    procedure SetName(const Value: string);
  public
    property Name: string read FName write SetName;
  public
    class function Get(const aName: string): TAnimal;
    class function GetAs<T: class>(const AName: string): T;
    function ToString: string; override;
  end;

  TDog = class(TAnimal)

  end;

  TCat = class(TAnimal)

  end;

  TAnimalShop = class
    class function GetAs<T: TAnimal, constructor>(const AName: string): T;
  end;

procedure TForm1.Button1Click(Sender: TObject);
var
  ACat: TCat;
  ADog: TDog;
begin
  ACat := TCat.Get('Matisse') as TCat;
  Memo1.Lines.Add(ACat.ToString);
  ACat.Free;

  ADog := TDog.GetAs<TDog>('Pluto');
  Memo1.Lines.Add(ADog.ToString);
  ADog.Free;

  ADog := TAnimalShop.GetAs<TDog>('Pluto');
  Memo1.Lines.Add(ADog.ToString);
  ADog.Free;
end;

{ TAnimal }

class function TAnimal.Get(const AName: string): TAnimal;
begin
  Result := Create;
  Result.fName := aName;
end;

class function TAnimal.GetAs<T>(const AName: string): T;
var
  Res: TAnimal;
begin
  Res := Get(AName);
  if Res.inheritsFrom(T) then
    Result := T(Res)
  else
    Result := nil;
end;

procedure TAnimal.SetName(const Value: string);
begin
  FName := Value;
end;

function TAnimal.ToString: string;
begin
  Result := 'This ' + Copy(ClassName, 2, MaxInt) +
    ' is called ' + FName;
end;

{ TAnimalShop }

// we can actually simplify this code (I wrote earlier), as shown below
//class function TAnimalShop.GetAs<T>(const AName: string): T;
//var
//  Res: TAnimal;
//begin
//  Res := T.Create;
//  Res.Name := aName;
//  if Res.InheritsFrom(T) then
//    Result := T(Res)
//  else
//    Result := nil;
//end;

class function TAnimalShop.GetAs<T>(const AName: string): T;
begin
  Result := T.Create;
  Result.Name := AName;
end;


end.
