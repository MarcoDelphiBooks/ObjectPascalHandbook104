unit GenericClassCtor_Classes;

interface

uses
  Classes;

type
  TGenericWithClassCtor<T> = class
  private
    FData: T;
    procedure SetData(const Value: T);
  public
    class constructor Create;
    property Data: T read FData write SetData;
    class var
      DataSize: Integer;
  end;

  function ListSequence: TStringList;

//  procedure Useless; // not really needed

implementation

var // one for the unit (shared by all geenrics)
  SListSequence: TStringList;

function ListSequence: TStringList;
begin
  if not Assigned(SListSequence) then
    SListSequence := TStringList.Create;
  Result := SListSequence;
end;

// uncomment to show a double initialization
//procedure Useless;
//var
//  GenStr: TGenericWithClassCtor<string>;
//begin
//  GenStr := TGenericWithClassCtor<string>.Create;
//  GenStr.Data := '100';
//  GenStr.Free;
//end;

{ TGenericWithClassCtor<T> }

class constructor TGenericWithClassCtor<T>.Create;
begin
  DataSize := SizeOf(T);
  ListSequence.Add(ClassName);
end;

procedure TGenericWithClassCtor<T>.SetData(const Value: T);
begin
  FData := Value;
end;

end.
