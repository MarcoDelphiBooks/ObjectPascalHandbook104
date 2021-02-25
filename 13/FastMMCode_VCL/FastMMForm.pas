unit FastMMForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  TButton.Create(nil);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Pch1: PChar;
begin
  GetMem(Pch1, 5);
  GetWindowText(Handle, Pch1, Length(Caption));
  ShowMessage(Pch1);
  FreeMem(Pch1);
end;

initialization
  // ReportMemoryLeaksOnShutdown := True;

end.
