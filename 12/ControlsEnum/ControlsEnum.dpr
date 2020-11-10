program ControlsEnum;

uses
  Vcl.Forms,
  ControlEnum_Form in 'ControlEnum_Form.pas' {ControlEnumForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TControlEnumForm, ControlEnumForm);
  Application.Run;
end.
