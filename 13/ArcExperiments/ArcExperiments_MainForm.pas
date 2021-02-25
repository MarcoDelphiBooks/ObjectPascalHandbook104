unit ArcExperiments_MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Layouts,
  FMX.Memo, FMX.ScrollBox, FMX.Controls.Presentation, FMX.Memo.Types,
  Arc_MoreClasses;

type
  TForm3 = class(TForm)
    BntCycle: TButton;
    Memo1: TMemo;
    BtnGetWeak: TButton;
    BtnUseWeak: TButton;
    procedure BntCycleClick(Sender: TObject);
    procedure BtnGetWeakClick(Sender: TObject);
    procedure BtnUseWeakClick(Sender: TObject);
  private
    [weak] MySimple: IMySimpleInterface;
  public
    procedure Log(const StrMsg: string);
  end;

var
  Form3: TForm3;

function TheForm: TForm3;

implementation


{$R *.fmx}

function TheForm: TForm3;
begin
  Result := Form3;
end;


{ TForm3 }

procedure TForm3.BntCycleClick(Sender: TObject);
var
  MyComplex: IMyComplexInterface;
begin
  MyComplex := TMyComplexClass.Create;
  Log('Complex = ' + MyComplex.RefCount.ToString);
  MyComplex.GetSimple.DoSomething(False);
end;

procedure TForm3.BtnGetWeakClick(Sender: TObject);
var
  MyComplex: IMyComplexInterface;
begin
  MyComplex := TMyComplexClass.Create;
  MyComplex.GetSimple.DoSomething(False);
  MySimple := MyComplex.GetSimple;
end;

procedure TForm3.BtnUseWeakClick(Sender: TObject);
begin
  if Assigned(MySimple) then
    MySimple.DoSomething(False)
  else
    Log('Nil weak reference');
end;

procedure TForm3.Log(const StrMsg: string);
begin
  Memo1.Lines.Add(StrMsg);
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.
