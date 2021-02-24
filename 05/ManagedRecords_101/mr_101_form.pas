unit mr_101_form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Rtti;

type
  TForm5 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  Form5: TForm5;

procedure Log(const StrMessage: string);

implementation

{$R *.dfm}

var
  RecNo: Integer = 0;

type
  TMyRecord = record
  private
    FNumber: Integer;
  public
    Value: Integer;
    class operator Initialize(out Dest: TMyRecord);
    class operator Finalize(var Dest: TMyRecord);
    class operator Assign (var Dest: TMyRecord;
 		  const [ref] Src: TMyRecord);
  end;

{ TMyRecord record}

class operator TMyRecord.Initialize (out Dest: TMyRecord);
begin
  Inc (RecNo);
  Dest.FNumber := RecNo;
  Dest.Value := 10;
  Log('Created ' + Dest.FNumber.ToString + ' ' + IntToHex(Integer(Pointer(@Dest))));
end;

class operator TMyRecord.Assign (var Dest: TMyRecord; const [ref] Src: TMyRecord);
begin
  Dest.Value := Src.Value;
  // do not copy recNo!
  Log(Src.FNumber.ToString + ' copied to ' + Dest.FNumber.ToString);
end;

class operator TMyRecord.Finalize(var Dest: TMyRecord);
begin
  Log('Destroyed ' + Dest.FNumber.ToString + ' ' + IntToHex(Integer(Pointer(@Dest))));
end;


procedure LocalVarTest;
var
  T: TMyRecord;
begin
  Log(T.Value.ToString);
end;

procedure InlineVarTest;
begin
  var T: TMyRecord;
  Log(T.Value.ToString);
end;

procedure InlineVarTest2;
var
  My1: TMyRecord;
begin
  var T := My1;
  Log(T.Value.ToString);

  var S: TMyRecord;
  Log(S.Value.ToString);
end;

procedure SimpleAssign;
var
  My1, My2: TMyRecord;
begin
  My1.Value := 22;
  My2 := My1;
end;

procedure ParByValue (rec: TMyRecord);
begin
  Log('ParByValue');
 //  Rec.Value := 100;
end;

procedure ParByConstValue (const Rec: TMyRecord);
begin
  Log('ParByConstValue');
  // Rec.Value := 100; // Cannot assign to const
end;

procedure ParByRef (var Rec: TMyRecord);
begin
  Log('ParByRef');
  Rec.Value := 100;
end;

procedure ParByConstRef (const Rec: TMyRecord);
begin
  Log('ParByConstRef');
  // Rec.Value := 100; // Cannot assign to const
end;

function ParReturned: TMyRecord;
begin
  Log('ParReturned');
  Result.Value := 42;
end;


procedure TForm5.Button1Click(Sender: TObject);
begin
  Log('LocalVarTest');
  LocalVarTest;
  Log('');

  Log('InlineVarTest');
  InlineVarTest;
  Log('');

  Log('SimpleAssign');
  SimpleAssign;
  Log('');

  Log('InlineVarTest2');
  InlineVarTest2;
  Log('');
end;


procedure Log(const StrMessage: string);
begin
  Form5.Memo1.Lines.Add (StrMessage);
end;

procedure TForm5.Button2Click(Sender: TObject);
var
  My1: TMyRecord;
begin
  Log(My1.Value.ToString);
  ParByValue(My1);
  Log(My1.Value.ToString);
  ParByConstValue(My1);
  Log(My1.Value.ToString);
  ParByRef(My1);
  Log(My1.Value.ToString);
  ParByConstRef(My1);
  Log(My1.Value.ToString);
  My1 := ParReturned;
  Log(My1.Value.ToString);
end;

var
  FRaise: Boolean = False;

type
  TMRException = record
    x: Integer;
    class operator Initialize(out Dest: TMRException);
    class operator Finalize(var Dest: TMRException);
  end;

  class operator TMRException.Initialize(out Dest: TMRException);
  begin
    Log('Created ' + IntToHex(Integer(Pointer(@Dest))));
    if fRaise then
      raise Exception.Create('Error Message');
  end;

  class operator TMRException.Finalize(var Dest: TMRException);
  begin
    Log('Destroyed ' + IntToHex(Integer(Pointer(@Dest))));
  end;

procedure ExceptionTest;
begin
  FRaise := False;
  var A: TMRException;
  var B: TMRException;

  raise Exception.Create('Error Message');
end;

procedure ExceptionInConstructor;
begin
  Log('ExceptionInConstructor');
  FRaise := True;
  var D: TMRException;
end;

procedure TForm5.Button4Click(Sender: TObject);
begin
  try
    ExceptionTest;
  except
    ;
  end;

  try
    ExceptionInConstructor;
  except
    ;
  end;

end;

procedure ArrOfRec;
var
  A1: array [1..5] of TMyRecord;
begin
  Log('ArrOfRec');
  // Use array
  for var I := Low(A1) to High(A1) do
    Log(A1[I].Value.ToString);
end;

procedure ArrOfDyn;
var
  A2: array of TMyRecord;
begin
  Log('ArrOfDyn');
  SetLength(A2, 5);
  for var I := Low(A2) to High(A2) do
    Log (A2[I].Value.ToString);

end;

procedure TForm5.Button5Click(Sender: TObject);
begin
  ArrOfRec;
  ArrOfDyn;
end;

type
  TMyRec4 = record
    FX: Integer;
    constructor Create(const Recc: TMyRec4);
  end;

  constructor TMyRec4.Create(const Recc: TMyRec4);
  begin
    Log ('Copy Constructor');
  end;

type
  TMyRec5 = record
    FX: Integer;
    class operator Initialize(out Dest: TMyRec5);
    constructor Create (const Recc: TMyRec5);
  end;

  class operator TMyRec5.Initialize(out Dest: TMyRec5);
  begin
    Log('regular 5 constructor');
  end;

  constructor TMyRec5.Create (const Recc: TMyRec5);
  begin
    Log('MR 5 copy constructor');
  end;



procedure TForm5.Button6Click(Sender: TObject);
var
  RC: TRttiContext;
  Mr2: TMyRec4;
  Mrc2: TMyRec5;
begin
  // copy constructor called twice
  var Mr1 := TMyRec4.Create(Mr2);

  if RC.GetType(TypeInfo(TMyRec4)).TypeKind = tkMRecord then
    Log('Managed record')
  else if RC.GetType(TypeInfo(TMyRec4)).TypeKind = tkRecord then
    Log('Regular record');

  var mrc55 :=  TMyRec5.Create(Mrc2);
  if RC.GetType(TypeInfo(TMyRec5)).TypeKind = tkMRecord then
    Log('Managed record')
  else if RC.GetType(TypeInfo(TMyRec5)).TypeKind = tkRecord then
    Log('Regular record');

  var Mrc56 := Mrc2;
end;

end.
