program ClassStatic;

{$APPTYPE CONSOLE}

uses
  SysUtils, Windows;

type
  TBase = class
  private
    // FTmp: Integer;
    class var
      FMyName: string;
  public
    class procedure One;
    class procedure Two; static;
    class function GetMyName: string; static;
    class procedure SetMyName (Value: string); static;
    class property MyName: string read GetMyName write SetMyName;
    class property DirectName: string read FMyName write FMyName;
  end;

// replace class data with local data
//var
//  FMyName: string;

class procedure TBase.One;
begin
  // Error: Instance member 'FTmp' inaccessible here
  // writeln (FTmp);
  writeln ('one');
  writeln (self.ClassName);
end;

class procedure TBase.Two;
begin
  writeln ('two');
  // error: Undeclared identifier: 'self'
  // writeln (self.ClassName);
  writeln (ClassName);
end;

class function TBase.GetMyName: string;
begin
  Result := FMyName;
end;

class procedure TBase.SetMyName (Value: string);
begin
  FMyName := Value;
end;

var
  Base: TBase;

begin
  // TBase.MyName := 'hi';
  TBase.One;
  TBase.Two;

  Base := TBase.Create;
  Base.One;
  Base.Two;

  // Writeln (Base.MyName);

  Readln;
end.

