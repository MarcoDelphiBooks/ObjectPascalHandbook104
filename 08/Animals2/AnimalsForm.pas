unit AnimalsForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, AnimalsClasses, FMX.Media, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo.Types;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button2: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Panel1: TPanel;
    MediaPlayer1: TMediaPlayer;
    procedure Button2Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FMyAnimal: TAnimal;
  public
    procedure Show(const Msg: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

const
  SoundsFolder = '..\..\'; // Windows only

procedure TForm1.Button2Click(Sender: TObject);
begin
  Show(FMyAnimal.Voice);
  MediaPlayer1.FileName := SoundsFolder + FMyAnimal.Voice + '.wav';
  MediaPlayer1.Play;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FMyAnimal := TAnimal.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FMyAnimal.Free;
end;

procedure TForm1.RadioButton1Change(Sender: TObject);
begin
  FMyAnimal.Free;
  FMyAnimal := TAnimal.Create;
end;

procedure TForm1.RadioButton2Change(Sender: TObject);
begin
  FMyAnimal.Free;
  FMyAnimal := TDog.Create;
end;

procedure TForm1.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
