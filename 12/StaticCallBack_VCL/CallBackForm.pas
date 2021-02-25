unit CallBackForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormCallBack = class(TForm)
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
  private
    class var
      NTimerCount: Integer;
  public
    procedure AddToList(const AMessage: string);
    class procedure TimerCallBack(hwnd: THandle;
      uMsg, idEvent, dwTime: Cardinal); static; stdcall;
  end;

var
  FormCallBack: TFormCallBack;

implementation

{$R *.dfm}

const
  TIMERID = 100;

procedure TFormCallBack.AddToList(const AMessage: string);
begin
  ListBox1.Items.Add(AMessage);
end;

procedure TFormCallBack.FormCreate(Sender: TObject);
var
  Callback: TFNTimerProc;
begin
  NTimerCount := 0;
  Callback := TFNTimerProc(@TFormCallBack.TimerCallBack);
  SetTimer(Handle, TIMERID, 1000, Callback);
end;

class procedure TFormCallBack.TimerCallBack(hwnd: THandle; uMsg, idEvent,
  dwTime: Cardinal);
begin
  try
    Inc(NTimerCount);
    FormCallBack.AddToList(
      IntToStr(NTimerCount) + ' at ' + TimeToStr(Now));
  except on E: Exception do
    Application.HandleException(nil);
  end;
end;

end.
