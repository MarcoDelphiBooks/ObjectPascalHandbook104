unit TestClass;

interface

type
  TTest = class
  protected
    FProtectedData: Integer;
  public
    FPublicData: Integer;
    function GetValue: string;
  end;

implementation

uses
  SysUtils;

function TTest.GetValue: string;
begin
  Result := Format('Public: %d, Protected: %d',
    [FPublicData, FProtectedData]);
end;

end.
 