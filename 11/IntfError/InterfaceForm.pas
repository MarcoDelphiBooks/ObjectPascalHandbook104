unit InterfaceForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.Memo.Types, FMX.Controls.Presentation,
  FMX.ScrollBox;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    BtnMix: TButton;
    BtnIntfOnly: TButton;
    procedure BtnMixClick(Sender: TObject);
    procedure BtnIntfOnlyClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Show(const Msg: string);
  end;

var
  Form1: TForm1;

type
  IMyInterface = interface
    ['{F7BEADFD-ED10-4048-BB0C-5B232CF3F272}']
    procedure Show;
  end;

  TMyIntfObject = class(TInterfacedObject, IMyInterface)
  public
    procedure Show;
  end;

implementation

{$R *.fmx}

procedure ShowThat(AnIntf: IMyInterface);
begin
  AnIntf.Show;
end;

procedure TForm1.BtnMixClick(Sender: TObject);
var
  AnObj: TMyIntfObject;
begin
  AnObj := TMyIntfObject.Create;
  try
    ShowThat(AnObj);
  finally
    AnObj.Free;
  end;
end;

procedure TForm1.BtnIntfOnlyClick(Sender: TObject);
var
  AnObj: IMyInterface;
begin
  AnObj := TMyIntfObject.Create;
  ShowThat(AnObj);
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

{ TMyIntfObject }

procedure TMyIntfObject.Show;
begin
  Form1.Show('Showing');
end;

initialization
  // Check we are not leaking objects
  ReportMemoryLeaksOnShutdown := True;

end.
