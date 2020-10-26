program mr_101;

uses
  Vcl.Forms,
  mr_101_form in 'mr_101_form.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
