program SmartPointersMR;

uses
  Forms,
  SmartPointers_MainForm in 'SmartPointers_MainForm.pas' {FormSmartPointers},
  SmartPointerMRecord in 'SmartPointerMRecord.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormSmartPointers, FormSmartPointers);
  Application.Run;
end.
