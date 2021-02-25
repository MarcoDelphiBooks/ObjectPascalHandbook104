unit ObjFromIntfMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm39 = class(TForm)
    BtnSimpleTest: TButton;
    BtnRefCountIssue: TButton;
    procedure BtnSimpleTestClick(Sender: TObject);
    procedure BtnRefCountIssueClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form39: TForm39;

implementation

{$R *.dfm}

type
  ITestIntf = interface(IInterface)
    ['{2A77A244-DC85-46BE-B98E-A9392EF2A7A7}']
    procedure DoSomething;
  end;

  TTestImpl = class(TInterfacedObject, ITestIntf)
  public
    procedure DoSomething;
    procedure DoSomethingElse; // not in interface
    destructor Destroy; override;
  end;

procedure TForm39.BtnRefCountIssueClick(Sender: TObject);
var
  Intf: ITestIntf;
  Original: TObject;
begin
  Original := nil;
  Intf := TTestImpl.Create;
  Intf.DoSomething;
  if Intf is TObject then
    Original := TObject(Intf);
  Intf := nil;
  if Assigned(Original) then
    (Original as TTestImpl).DoSomethingElse;
end;

procedure TForm39.BtnSimpleTestClick(Sender: TObject);
var
  Intf: ITestIntf;
begin
  Intf := TTestImpl.Create;
  Intf.DoSomething;
  (Intf as TTestImpl).DoSomethingElse;
end;

{ ITestImpl }

destructor TTestImpl.Destroy;
begin
  ShowMessage('Freeing object');
  inherited;
end;

procedure TTestImpl.DoSomething;
begin
  ShowMessage('Doing something');
end;

procedure TTestImpl.DoSomethingElse;
begin
  ShowMessage('Doing something else');
end;

end.
