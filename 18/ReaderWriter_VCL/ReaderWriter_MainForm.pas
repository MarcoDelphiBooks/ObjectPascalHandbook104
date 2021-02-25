unit ReaderWriter_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormReaderWriter = class(TForm)
    BtnWrite: TButton;
    BtnRead: TButton;
    BtnWriteAndRead: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    Label3: TLabel;
    BtnXmlCorrect: TButton;
    BtnXmlUnbalanced: TButton;
    BtnClassic: TButton;
    procedure BtnWriteClick(Sender: TObject);
    procedure BtnReadClick(Sender: TObject);
    procedure BtnWriteAndReadClick(Sender: TObject);
    procedure BtnXmlCorrectClick(Sender: TObject);
    procedure BtnXmlUnbalancedClick(Sender: TObject);
    procedure BtnClassicClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormReaderWriter: TFormReaderWriter;

implementation

{$R *.dfm}

uses
  Generics.Collections;

type
  TTrivialXmlWriter = class
  private
    FWriter: TTextWriter;
    FNodes: TStack<string>;
  public
    constructor Create(AWriter: TTextWriter);
    destructor Destroy; override;
    procedure WriteStartElement(const SName: string);
    procedure WriteEndElement;
    procedure WriteString(const SValue: string);
  end;


procedure TFormReaderWriter.BtnWriteAndReadClick(Sender: TObject);
var
  SW: TStringWriter;
  SR: TStringReader;
  TheString: string;
begin
  SW := TStringWriter.Create;
  try
    SW.WriteLine('Hello, world');
    SW.WriteLine('Have a nice day');
    SW.WriteLine(Left);
    TheString := SW.ToString;
  finally
    SW.Free;
  end;

  SR := TStringReader.Create(TheString);
  try
    while SR.Peek <> -1 do
      Memo1.Lines.Add(SR.ReadLine);
  finally
    SR.Free;
  end;
end;

procedure TFormReaderWriter.BtnWriteClick(Sender: TObject);
var
  SW: TStreamWriter;
begin
  SW := TStreamWriter.Create('test.txt', False, TEncoding.UTF8);
  try
    SW.WriteLine('Hello, world');
    SW.WriteLine('Have a nice day');
    SW.WriteLine(Left);
  finally
    SW.Free;
  end;
end;

procedure TFormReaderWriter.BtnXmlCorrectClick(Sender: TObject);
var
  SW: TStringWriter;
  TXW: TTrivialXmlWriter;
  TheString: string;
begin
  SW := TStringWriter.Create;
  try
    TXW := TTrivialXmlWriter.Create (SW);
    try
      TXW.WriteStartElement('book');
        TXW.WriteStartElement('title');
          TXW.WriteString('Delphi 2009 Handbook');
        TXW.WriteEndElement;
        TXW.WriteStartElement('author');
          TXW.WriteString('Marco Cantù');
        TXW.WriteEndElement;
      TXW.WriteEndElement;
    finally
       TXW.Free;
    end;
    TheString := SW.ToString;
  finally
    SW.Free;
  end;

  Memo1.Lines.Text := TheString;
end;

procedure TFormReaderWriter.BtnXmlUnbalancedClick(Sender: TObject);
var
  SW: TStringWriter;
  TXW: TTrivialXmlWriter;
  TheString: string;
begin
  SW := TStringWriter.Create;
  try
    TXW := TTrivialXmlWriter.Create(SW);
    try
      TXW.WriteStartElement('book');
        TXW.WriteStartElement('title');
          TXW.WriteString('Delphi 2009 Handbook');
//        TXW.WriteEndElement;
        TXW.WriteStartElement('author');
          TXW.WriteString('Marco Cantù');
//        TXW.WriteEndElement;
//      TXW.WriteEndElement;
    finally
       TXW.Free;
    end;
    TheString := SW.ToString;
  finally
    SW.Free;
  end;

  Memo1.Lines.Text := TheString;end;

procedure TFormReaderWriter.BtnClassicClick(Sender: TObject);
var
  FS: TFileStream;
  Str: AnsiString;
begin
  if FileExists('test.txt') then
    FS := TFileStream.Create('test.txt', fmCreate)
  else
    FS := TFileStream.Create('test.txt', fmOpenReadWrite);
  try
    Str := 'Hello, world';
    FS.Write(Str[1], Length(Str));
    Str := sLineBreak;
    FS.Write(Str[1], Length(Str));
    Str := IntToStr (Left);
    FS.Write(Str[1], Length(Str));
  finally
    FS.Free;
  end;
end;

procedure TFormReaderWriter.BtnReadClick(Sender: TObject);
var
  SR: TStreamReader;
begin
  SR := TStreamReader.Create('test.txt', True);
  try
    while not SR.EndOfStream do
      Memo1.Lines.Add (SR.ReadLine);
  finally
    SR.Free;
  end;
end;

{ TTrivialXmlWriter }

constructor TTrivialXmlWriter.Create(AWriter: TTextWriter);
begin
  FWriter := AWriter;
  FNodes := TStack<string>.Create;
end;

destructor TTrivialXmlWriter.Destroy;
begin
  while FNodes.Count > 0 do
    WriteEndElement;
  FNodes.Free;
  inherited;
end;

procedure TTrivialXmlWriter.WriteEndElement;
begin
  FWriter.Write('</' + FNodes.Pop + '>');
end;

procedure TTrivialXmlWriter.WriteStartElement(const SName: string);
begin
  FWriter.Write('<' + SName + '>');
  FNodes.Push(Sname);
end;

procedure TTrivialXmlWriter.WriteString(const SValue: string);
begin
  FWriter.Write(SValue);
end;

end.
