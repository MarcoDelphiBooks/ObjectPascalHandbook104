unit NestedClass;

interface

type
  TOne = class
  private
    FSomeData: Integer;
  public
    // Nested constant
    const Foo = 12;
    // Nested type
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
    Ins.FMsg := 'Hi';
    Ins.InsideHello;
    Show('Constant is ' + IntToStr (foo));
  finally
    Ins.Free;
  end;
end;

{ TOne.TInside }

procedure TOne.TInside.InsideHello;
begin
   FMsg := 'New msg';
   Show('Internal call');
   if not Assigned (FInsIns) then
     FInsIns := TInsideInside.Create;
   FInsIns.Two;
end;

{ TOne.TInside.TInsideInside }

procedure TOne.TInside.TInsideInside.Two;
begin
  Show('This is a method of a nested/nested class');
end;

end.
