unit Arc_MoreClasses;

interface

uses
  System.Classes;

type
  IMySimpleInterface = interface
    ['{B6AB548A-55A1-4D0F-A2C5-726733C33708}']
    procedure DoSomething(BRaise: Boolean = False);
    function RefCount: Integer;
  end;

  IMyComplexInterface = interface
    ['{5E8F7B29-3270-44FC-B0FC-A69498DA4C20}']
    function GetSimple: IMySimpleInterface;
    function RefCount: Integer;
  end;

  TMyComplexClass = class;

  TMySimpleClass = class(TInterfacedObject, IMySimpleInterface)
  private
    [Weak] FOwnedBy: IMyComplexInterface;
  public
    constructor Create(Owner: IMyComplexInterface);
    destructor Destroy; override;
    procedure DoSomething(BRaise: Boolean = False);
    function RefCount: Integer;
  end;

  TMyComplexClass = class(TInterfacedObject, IMyComplexInterface)
  private
    FSimple: IMySimpleInterface;
  public
    constructor Create;
    destructor Destroy; override;
    function GetSimple: IMySimpleInterface;
    function RefCount: Integer;
  end;

implementation

uses
  ARcExperiments_MainForm, SysUtils;

{ TMyLittleClass }

constructor TMySimpleClass.Create(Owner: IMyComplexInterface);
begin
  TheForm.Log('Simple class created');
  FOwnedBy := Owner;
end;

destructor TMySimpleClass.Destroy;
begin
  TheForm.Log('Simple class destroyed');
  inherited;
end;

procedure TMySimpleClass.DoSomething(BRaise: Boolean);
begin
  TheForm.Log('Simple class doing something');
  if bRaise then
    raise Exception.Create('Error Message');
end;

function TMySimpleClass.RefCount: Integer;
begin
  Result := inherited RefCount;
end;

{ TMyComplexClass }

constructor TMyComplexClass.Create;
begin
  inherited Create;
  TheForm.Log('Complex class created');
  FSimple := TMySimpleClass.Create (self);
end;

destructor TMyComplexClass.Destroy;
begin
  TheForm.Log('Complex class destroyed');
  inherited;
end;

function TMyComplexClass.GetSimple: IMySimpleInterface;
begin
  Result := FSimple;
end;

function TMyComplexClass.RefCount: Integer;
begin
  Result := inherited RefCount;
end;

end.
