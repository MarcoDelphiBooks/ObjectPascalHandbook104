program AutoThreading;

uses
  Forms,
  AutoThreading_mainForm in 'AutoThreading_mainForm.pas' {ThreadingForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TThreadingForm, ThreadingForm);
  Application.Run;
end.
