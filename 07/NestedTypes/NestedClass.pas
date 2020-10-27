unit NestedClass;

interface

type
  TOne = class
  private
    FSomeData: Integer;
  public
    // nested constant
    const Foo = 12;
    // nested type
    type TInside = class
      type TInsideInside = class
        procedure Two;
      end;
    public
      procedure InsideHello;
    private
      FMsg: string;
      FInsIns: TInsideInside;
    end;
  public
    procedure Hello;
    constructor Create;
  end;

implementation

uses
  SysUtils, NestedTypesForm;

{ TOne }

constructor TOne.Create;
begin
  inherited Create;
end;

procedure TOne.Hello;
var
  Ins: TInside;
begin
  Ins := TInside.Create;
  try
    Ins.FMsg := 'hi';
    Ins.InsideHello;
    Show ('constant is ' + IntToStr (foo));
  finally
    Ins.Free;
  end;
end;

{ TOne.TInside }

procedure TOne.TInside.InsideHello;
begin
   FMsg := 'new msg';
   Show ('internal call');
   if not Assigned (FInsIns) then
     FInsIns := TInsideInside.Create;
   FInsIns.Two;
end;

{ TOne.TInside.TInsideInside }

procedure TOne.TInside.TInsideInside.Two;
begin
  Show ('this is a method of a nested/nested class');
end;

end.
