unit ExceptionForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.Memo.Types, FMX.Controls.Presentation,
  FMX.ScrollBox;

type
  TFormExceptions = class(TForm)
    Memo1: TMemo;
    BtnTraditional: TButton;
    BtnCallNested: TButton;
    BtnTwoNested: TButton;
    BtnRaising: TButton;
    procedure BtnTraditionalClick(Sender: TObject);
    procedure BtnCallNestedClick(Sender: TObject);
    procedure BtnTwoNestedClick(Sender: TObject);
    procedure BtnRaisingClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Show(const Msg: string);

    procedure ClassicReraise;
    procedure MethodWithNestedException;
    procedure MethodWithTwoNestedExceptions;
  end;

var
  FormExceptions: TFormExceptions;

implementation

{$R *.fmx}

type
  ECustomException = class(Exception)
  protected
    procedure RaisingException(P: PExceptionRecord); override;
  end;

procedure TFormExceptions.BtnCallNestedClick(Sender: TObject);
begin
  try
    MethodWithNestedException;
  except
    on E: Exception do
    begin
      Show('Message: ' + E.Message);
      Show('ToString: ' + E.ToString);
      if Assigned(E.BaseException) then
        Show('BaseException Message: ' + E.BaseException.Message);
      if Assigned(E.InnerException) then
        Show('InnerException Message: ' + E.InnerException.Message);
    end;
  end;
end;

procedure TFormExceptions.BtnRaisingClick(Sender: TObject);
begin
  raise ECustomException.Create('A message');
end;

procedure TFormExceptions.BtnTraditionalClick(Sender: TObject);
begin
  try
    ClassicReraise;
  except
    on E: Exception do
      Show('Message: ' + E.Message);
  end;
end;

procedure TFormExceptions.BtnTwoNestedClick(Sender: TObject);
begin
  try
    MethodWithTwoNestedExceptions;
  except
    on E: Exception do
    begin
      Show('Message: ' + E.Message);
      Show('ToString: ' + E.ToString);
      if Assigned (E.BaseException) then
        Show('BaseException Message: ' + E.BaseException.Message);
      if Assigned (E.InnerException) then
        Show('InnerException Message: ' + E.InnerException.Message);
    end;
  end;
end;

procedure TFormExceptions.ClassicReraise;
begin
  try
    // Do something...
    raise Exception.Create('Hello');
  except on E: Exception do
    // Try some fix...
    raise Exception.Create('Another: ' + E.Message);
  end;
end;

procedure TFormExceptions.MethodWithNestedException;
begin
  try
    raise Exception.Create('Hello');
  except
    Exception.RaiseOuterException(Exception.Create('Another'));
  end;
end;

procedure TFormExceptions.MethodWithTwoNestedExceptions;
begin
  try
    raise Exception.Create('Hello');
  except
    begin
      try
        Exception.RaiseOuterException(Exception.Create('Another'));
      except
        Exception.RaiseOuterException(Exception.Create('A third'));
      end;
    end;
  end;
end;

procedure TFormExceptions.Show(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

{ ECustomException }

procedure ECustomException.RaisingException(P: PExceptionRecord);
begin
  // Show exception information (to file would be smarter!)
  FormExceptions.Show('Exception Addr: ' + IntToHex(
    Integer(P.ExceptionAddress), 8));
  FormExceptions.Show('Exception Mess: ' + Message);

  // Modify the message
  Message := Message + ' (filtered)';

  // Standard processing
  inherited;
end;


end.
