unit OperatorsTypes;

interface

uses
  SysUtils;

type
  TPointRecord = record
  private
    FX, FY: Integer;
  public
    procedure SetValue (X1, Y1: Integer);
    class operator Add (A, B: TPointRecord): TPointRecord;
    class operator Explicit (A: TPointRecord) : string;
    class operator Implicit (X1: Integer): TPointRecord;
  end;

type
  TPointRecord2 = record
  private
    FX, FY: Integer;
  public
    class operator Explicit (A: TPointRecord2) : string;
    procedure SetValue (X1, Y1: Integer);
    // commutativity
    class operator Add (A: TPointRecord2; B: Integer): TPointRecord2;
    class operator Add (B: Integer; A: TPointRecord2): TPointRecord2;
  end;


implementation

{ TPointRecord }

class operator TPointRecord.Add(A, B: TPointRecord): TPointRecord;
begin
  Result.FX := A.FX + B.FX;
  Result.FY := A.FY + B.FY;
end;

class operator TPointRecord.Explicit(A: TPointRecord): string;
begin
  Result := Format('(%d:%d)', [A.FX, A.FY]);
end;

class operator TPointRecord.Implicit(X1: Integer): TPointRecord;
begin
  Result.FX := X1;
  Result.FY := 10;
end;

procedure TPointRecord.SetValue(X1, Y1: Integer);
begin
  FX := X1;
  FY := Y1;
end;

{ TPointRecord2 }

procedure TPointRecord2.SetValue(X1, Y1: Integer);
begin
  FX := X1;
  FY := Y1;
end;

class operator TPointRecord2.Add(A: TPointRecord2; B: Integer): TPointRecord2;
begin
  Result.FX := A.FX + B;
  Result.FY := A.FY + B;
end;

class operator TPointRecord2.Add(B: Integer; A: TPointRecord2): TPointRecord2;
begin
  Result := A + B; // implement commutativity
end;

class operator TPointRecord2.Explicit(A: TPointRecord2): string;
begin
  Result := Format('(%d:%d)', [A.FX, A.FY]);
end;

end.
