program RestoreCursorVCL;

uses
  Vcl.Forms,
  RestoreCursorVCL_MainForm in 'RestoreCursorVCL_MainForm.pas' {Form42};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm42, Form42);
  Application.Run;
end.
