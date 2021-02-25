unit BinaryFiles_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormBinary = class(TForm)
    BtnWrite: TButton;
    BtnRead: TButton;
    Memo1: TMemo;
    BtnWriteRecord: TButton;
    BtnReadRecord: TButton;
    procedure BtnWriteClick(Sender: TObject);
    procedure BtnReadClick(Sender: TObject);
    procedure BtnWriteRecordClick(Sender: TObject);
    procedure BtnReadRecordClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure Log(const StrMsg: string);
  public
    { Public declarations }
  end;

  TMyRecord = record
    One: Integer;
    Two: Integer;
    Three: Double;
  end;

var
  FormBinary: TFormBinary;

implementation

{$R *.dfm}

uses
  System.RTTI, System.TypInfo;

// Keep this around for memory management and caching
var
  Context: TRTTIContext;
  RecType: TRTTIRecordType;

procedure WriteRecordBinary(RecordType: TRttiRecordType;
  Instance: Pointer; BW: TBinaryWriter);
var
  Field: TRttiField;
begin
  for Field in RecordType.GetFields do
  begin
    case Field.FieldType.TypeKind of
      tkInteger: BW.Write(Field.GetValue(Instance).AsInteger);
      tkFloat: BW.Write(Field.GetValue(Instance).AsType<Double>);
    end;
  end;
end;

procedure ReadRecordBinary(RecordType: TRttiRecordType;
  Instance: Pointer; BR: TBinaryReader);
var
  Field: TRttiField;
begin
  for Field in RecordType.GetFields do
  begin
    case Field.FieldType.TypeKind of
      tkInteger: Field.SetValue(Instance, BR.ReadInteger);
      tkFloat: Field.SetValue(Instance, BR.ReadDouble);
    end;
  end;
end;


procedure TFormBinary.BtnWriteClick(Sender: TObject);
var
  BW: TBinaryWriter;
begin
  BW := TBinaryWriter.Create('Test.data', False);
  try
    BW.Write(Left);
    BW.Write(Now);
    Log('File size: ' + IntToStr(BW.BaseStream.Size));
  finally
    BW.Free;
  end;
end;

procedure TFormBinary.BtnWriteRecordClick(Sender: TObject);
var
  BW: TBinaryWriter;
  Rec: TMyRecord;
begin
  Rec.One := 1;
  Rec.Two := 2;
  Rec.Three := 3.3;

  BW := TBinaryWriter.Create('Record.data', False);
  try
    WriteRecordBinary(RecType, @Rec, BW);
//    BW.Write(Rec.One);
//    BW.Write(Rec.Two);
//    BW.Write(Rec.Three);
    Log('File size: ' + IntToStr(BW.BaseStream.Size));
  finally
    BW.Free;
  end;
end;

procedure TFormBinary.FormCreate(Sender: TObject);
begin
  RecType := context.GetType(TypeInfo(TMyRecord)) as TRTTIRecordType;
end;

procedure TFormBinary.BtnReadRecordClick(Sender: TObject);
var
  BR: TBinaryReader;
  Rec: TMyRecord;
begin
  BR := TBinaryReader.Create('Record.data');
  try
    ReadRecordBinary(RecType, @Rec, BR);
//    Rec.One := BR.ReadInteger;
//    Rec.Two := BR.ReadInteger;
//    Rec.Three := BR.ReadDouble;
    Log('Two: ' + IntToStr(Rec.Two));
  finally
    BR.Free;
  end;
end;

procedure TFormBinary.BtnReadClick(Sender: TObject);
var
  BR: TBinaryReader;
  ATime: TDateTime;
begin
  BR := TBinaryReader.Create('test.data');
  try
    Left := BR.ReadInt32;
    Log('Left read: ' + IntToStr(Left));
    ATime := BR.ReadDouble;
    Log('Time read: ' + TimeToStr(ATime));
  finally
    BR.Free;
  end;
end;

procedure TFormBinary.Log(const StrMsg: string);
begin
  Memo1.Lines.Add(StrMsg);
end;

end.
