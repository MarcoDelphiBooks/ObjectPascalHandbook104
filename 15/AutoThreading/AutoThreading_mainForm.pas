unit AutoThreading_mainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP;

type
  TThreadingForm = class(TForm)
    btnAutoThread: TButton;
    Button2: TButton;
    btnPlain: TButton;
    btnBlockingHttp: TButton;
    btnThreadedHttp: TButton;
    Memo1: TMemo;
    IdHTTP1: TIdHTTP;
    procedure btnAutoThreadClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnPlainClick(Sender: TObject);
    procedure btnBlockingHttpClick(Sender: TObject);
    procedure btnThreadedHttpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ThreadingForm: TThreadingForm;

implementation

{$R *.dfm}

uses
  Math, SyncObjs;

const
  mil20 = 20000000; // 20 million (change it to slow down code)

procedure TThreadingForm.btnAutoThreadClick(Sender: TObject);
begin
  (Sender as TButton).Caption := 'Computing';
  TThread.CreateAnonymousThread(
    procedure()
    var
      X: Extended;
      I: Integer;
    begin
      X := 100;
      for I := 0 to mil20 do
        x := Sqrt (X) * Sqrt (X);
      TThread.Synchronize (TThread.CurrentThread,
        procedure
        begin
          (Sender as TButton).Caption := FloatToStr (X);
        end);
    end).Start;
end;

procedure TThreadingForm.btnBlockingHttpClick(Sender: TObject);
var
  strHtml: string;
begin
  strHtml := IdHttp1.Get('http://www.marcocantu.com');
  memo1.Lines.Add(Copy (strHtml, 1, 200));
end;

procedure TThreadingForm.btnPlainClick(Sender: TObject);
var
  X: Extended;
  I: Integer;
begin
  (Sender as TButton).Caption := 'Computing';
  X := 100;
  for I := 0 to mil20 do
    x := Sqrt (X) * Sqrt (X);
  (Sender as TButton).Caption := FloatToStr (X);
end;

procedure TThreadingForm.btnThreadedHttpClick(Sender: TObject);
begin
  TThread.CreateAnonymousThread(
    procedure ()
    var
      strHtml: string;
    begin
       strHtml := IdHttp1.Get('http://www.marcocantu.com');
       TThread.Synchronize(TThread.CurrentThread,
       procedure ()
       begin
         memo1.Lines.Add(Copy (strHtml, 1, 200));
       end);
    end).Start;
end;

procedure TThreadingForm.Button2Click(Sender: TObject);
var
  X: Extended;
begin
  //////////// NOT A GOOD EXAMPLE OF A SPIN LOCK //////

  (Sender as TButton).Caption := 'Computing';
  X := 0;
  TThread.CreateAnonymousThread(
    procedure()
    var
      I: Integer;
      x1: Extended;
    begin
      X1 := 100;
      for I := 0 to mil20 do
        x1 := Sqrt (X1) * Sqrt (X1);
      x := x1;
    end).Start;

  // wait!
  TSpinWait.SpinUntil(
    function: Boolean
    begin
      Application.ProcessMessages;
      Result := (x <> 0);
    end
  );

  (Sender as TButton).Caption := FloatToStr (X);
end;

end.
