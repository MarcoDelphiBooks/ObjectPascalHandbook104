unit RestoreCursorVCL_MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm42 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form42: TForm42;

implementation

{$R *.dfm}

type
  THourglassCursor = record
  private
    FCurrCur: TCursor;
  public
    class operator Initialize (out ADest: THourglassCursor);
    class operator Finalize (var ADest: THourglassCursor);
  end;

class operator THourglassCursor.Initialize (out ADest: THourglassCursor);
begin
  ADest.FCurrCur := Screen.Cursor;
  Screen.Cursor := crHourGlass;
end;

class operator THourglassCursor.Finalize (var ADest: THourglassCursor);
begin
  Screen.Cursor := ADest.FCurrCur;
end;


procedure TForm42.Button1Click(Sender: TObject);
begin
  var CurrCur := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    // some slow operation
    Sleep (5000);
  finally
    Screen.Cursor := CurrCur;
  end;
end;

procedure TForm42.Button2Click(Sender: TObject);
begin
  var HC: THourglassCursor;
  // some slow operation
  Sleep (5000);
end;

end.
