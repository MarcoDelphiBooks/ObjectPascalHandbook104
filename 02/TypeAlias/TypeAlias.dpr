program TypeAlias;

uses
  Vcl.Forms,
  TypeAliasForm in 'TypeAliasForm.pas' {TAliasForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTAliasForm, TAliasForm);
  Application.Run;
end.
