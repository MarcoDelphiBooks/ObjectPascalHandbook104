unit FormatStringForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo.Types;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Show(const Msg: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  System.Diagnostics;

const
  MaxLoop = 5000000; // Five million


procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit1.Text := 'Value %d, Align %4d, Fill %4.4d';
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  StrFmt: string;
  N1, N2, N3: Integer;
begin
  StrFmt := Edit1.Text;
  N1 := 8;
  N2 := 16;
  N3 := 256;

  Show(Format('Format string: %s', [StrFmt]));
  Show(Format('Input data: [%d, %d, %d]', [N1, N2, N3]));
  Show(Format('Output: %s', [Format(StrFmt, [N1, N2, N3])]));
  Show(''); // blank line
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
