program Adapter_Demo;

uses
  Forms,
  mainform in 'mainform.pas' {FormAdapter},
  AdapterIntf in 'AdapterIntf.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormAdapter, FormAdapter);
  Application.Run;
end.
