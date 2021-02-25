unit SafeCodeMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    BtnConstructor: TButton;
    BtnMixed: TButton;
    BtnRelease: TButton;
    BtnCast: TButton;
    BtnTryF: TButton;
    procedure BtnConstructorClick(Sender: TObject);
    procedure BtnMixedClick(Sender: TObject);
    procedure BtnReleaseClick(Sender: TObject);
    procedure BtnCastClick(Sender: TObject);
    procedure BtnTryFClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  CantuMemTest;

{$R *.dfm}

type
  TUnsafeDesctructor = class
  private
    FList: TList;
  public
    constructor Create(PositiveNumber: Integer);
    destructor Destroy; override;
    procedure Show;
  end;

  IMyInterface = interface
    procedure Show;
    function GetAnother: IMyInterface;
    procedure SetAnother(value: IMyInterface);
    property Another: IMyInterface read GetAnother write SetAnother;
  end;

  TMyIntfObject = class(TInterfacedObject, IMyInterface)
  private
    FAnother: IMyInterface;
  public
    procedure Show;
    function GetAnother: IMyInterface;
    procedure SetAnother(Value: IMyInterface);
    destructor Destroy; override;
  end;

  procedure ShowThat(AnIntf: IMyInterface);
  begin
    AnIntf.Show;
  end;

procedure TForm1.BtnCastClick(Sender: TObject);
var
  list: TList;
begin
  list := TList.Create;
  try
    list.Add(Pointer(Sender));
    list.Add(Pointer (23422));
//    (TObject(list[1]) as TButton).Caption := 'ouch';
//    if TObject(list[1]) is TButton then
//      TButton(list[1]).Caption := 'ouch';
    if IsPointerToObject(list[1]) then
      (TObject(list[1]) as TButton).Caption := 'ouch';
    if IsPointerToObject(list[0]) then
      (TObject(list[0]) as TButton).Caption := 'ouch';
  finally
    list.Free;
  end;
end;

procedure TForm1.BtnConstructorClick(Sender: TObject);
var
  anObj: TUnsafeDesctructor;
begin
  anObj := TUnsafeDesctructor.Create(-10);
  try

  finally
    anObj.Free;
  end;
end;

{ TUnsafeDesctructor }

constructor TUnsafeDesctructor.Create(PositiveNumber: Integer);
begin
  inherited Create;

  if PositiveNumber <= 0 then
    raise Exception.Create('Not a positive number');
  FList := TList.Create;
  FList.Add(Pointer(PositiveNumber)); // Don't do this!
end;

destructor TUnsafeDesctructor.Destroy;
begin
  // Uncomment to fix the program
  // if Assigned(FList) then
    FList.Clear;
  FList.Free;
  inherited;
end;

procedure TUnsafeDesctructor.Show;
begin
  ShowMessage('Show');
  FList.Add(Self);
end;

{ TMyIntfObject }

destructor TMyIntfObject.Destroy;
begin
  ShowMessage('TMyIntfObject.Destroy');
  inherited;
end;

function TMyIntfObject.GetAnother: IMyInterface;
begin
  Result := FAnother;
end;

procedure TMyIntfObject.SetAnother(Value: IMyInterface);
begin
  FAnother := Value;
end;

procedure TMyIntfObject.Show;
begin
  ShowMessage('Whatever...');
end;

procedure TForm1.BtnMixedClick(Sender: TObject);
var
  AnIntf: IMyInterface;
  // AnObj: TMyIntfObject;
begin
//  AnObj := TMyIntfObject.Create;
  AnIntf := TMyIntfObject.Create;
//  try
    ShowThat(AnIntf);
//  finally
//    AnObj.Free;
//  end;
end;

procedure TForm1.BtnReleaseClick(Sender: TObject);
var
  AnIntf, AnIntf2: IMyInterface;
begin
  AnIntf := TMyIntfObject.Create;
  AnIntf2 := TMyIntfObject.Create;

  AnIntf.Another := AnIntf2;
  AnIntf2.Another := AnIntf;
  AnIntf.Show;

  AnIntf2.Another := nil;
  AnIntf := nil;
end;

type
  TAClass = class
    FWhatever: string;
  public
    constructor Create;
  end;

procedure TForm1.BtnTryFClick(Sender: TObject);
var
  A1, A2: TAClass;
begin
  A1 := TAClass.Create;
  try
    A2 := TAClass.Create;
    try
      A1.FWhatever := 'One';
      A2.FWhatever := 'Two';
    finally
     A2.Free;
    end;
  finally
     A1.Free;
  end;
end;

{ TAClass }

constructor TAClass.Create;
begin
  inherited Create;

end;

end.
