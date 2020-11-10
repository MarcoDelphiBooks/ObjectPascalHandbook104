unit SmartPointerMRecord;

interface

uses
  Generics.Defaults, System.SysUtils;

type
  TSmartPointer<T: class, constructor> = record
  strict private
    FValue: T;
    function GetValue: T;
  public
    class operator Initialize(out ARec: TSmartPointer <T>);
    class operator Finalize(var ARec: TSmartPointer <T>);
    class operator Assign(var ADest: TSmartPointer <T>;
      const [ref] ASrc: TSmartPointer <T>);
    constructor Create (AValue: T);
    property Value: T read GetValue;
  end;

implementation

{ TSmartPointer<T> }

constructor TSmartPointer<T>.Create(AValue: T);
begin
  FValue := AValue;
end;

class operator TSmartPointer<T>.Initialize(out ARec: TSmartPointer <T>);
begin
  ARec.FValue := nil;
end;

class operator TSmartPointer<T>.Finalize(var ARec: TSmartPointer<T>);
begin
  ARec.FValue.Free;
end;

class operator TSmartPointer<T>.Assign(var ADest: TSmartPointer <T>;
  const [ref] ASrc: TSmartPointer <T>);
begin
  raise Exception.Create('Cannot copy or assign a TSmartPointer<T>');
end;

function TSmartPointer<T>.GetValue: T;
begin
  if not Assigned(FValue) then
    FValue := T.Create;
  Result := FValue;
end;

end.
