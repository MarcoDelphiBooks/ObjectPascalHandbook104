unit ListDictionary_MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Generics.Collections, Vcl.StdCtrls;

type
  TMyObject = class
  private
    FValue: Integer;
    procedure SetValue(const Value: Integer);
  public
    property Value: Integer read FValue write SetValue;
  end;

  TFormLists = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FList: TStringList;

    // changed code (in Frankfurt) to use the specific TObjectDictionary class
    // which allows objects ownership for either values or keys

    sDict: {TDictionary} TObjectDictionary<string,TMyObject>;
    // procedure ValueNotify(Sender: TObject; const Item: TMyObject;
    // Action: TCollectionNotification);
  public
    { Public declarations }
  end;

var
  FormLists: TFormLists;

implementation

{$R *.dfm}

uses
  Diagnostics;

function RandomName: string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to 30 + Random (50) do
    Result := Result + Char (Ord('a') + Random (26));
end;

procedure TFormLists.Button1Click(Sender: TObject);
var
  SW: TStopwatch;
  I: Integer;
  AName: string;
  AnIndex: Integer;
  AnObject: TMyObject;
  TheTotal: integer;
begin
  SW.Reset;
  SW.Start;

  TheTotal := 0;
  for I := 0 to FList.Count -1  do
  begin
    AName := FList[I];
    // now search for it
    AnIndex := FList.IndexOf (AName);
    // get the object
    AnObject := FList.Objects [AnIndex] as TMyObject;
    Inc (TheTotal, AnObject.Value);
  end;

  SW.Stop;
  memo1.Lines.Add ('Total: ' + IntToStr (TheTotal));
  memo1.Lines.Add ('StringList: ' + IntToStr (SW.ElapsedMilliseconds));
end;

procedure TFormLists.Button2Click(Sender: TObject);
var
  SW: TStopwatch;
  I: Integer;
  AName: string;
  AnObject: TMyObject;
  TheTotal: integer;
begin
  SW.Reset;
  SW.Start;

  TheTotal := 0;
  for I := 0 to FList.Count -1  do
  begin
    AName := FList[I];
   // get the object
    AnObject := sDict.Items [AName];
    Inc (TheTotal, AnObject.Value);
  end;

  SW.Stop;
  memo2.Lines.Add ('Total: ' + IntToStr (TheTotal));
  memo2.Lines.Add ('Dictionary: ' + IntToStr (SW.ElapsedMilliseconds));
end;

procedure TFormLists.Button3Click(Sender: TObject);
var
  I: Integer;
  AName: string;
  AnObject: TMyObject;
begin
  // else insertion is very slow
  FList.Sorted := False;

  for I := 1 to 500000 do // half million
  begin
    AName := RandomName;
    AnObject := TMyObject.Create;
    AnObject.Value := Random (200);
    FList.AddObject (AName, AnObject);
    sDict.Add (AName, AnObject);
    if (I mod 1000) = 0 then
      Application.ProcessMessages;
  end;
  Caption := Caption +  ' - ' + IntToStr (FList.Count);

  // else insertion is very slow
  FList.Sorted := True;
end;

procedure TFormLists.FormCreate(Sender: TObject);
begin
  FList := TStringList.Create;
  sDict :=  {TDictionary} TObjectDictionary<string,TMyObject>.
    Create ([doOwnsValues]);
  // sDict.OnValueNotify := ValueNotify;
  Randomize;
end;

procedure TFormLists.FormDestroy(Sender: TObject);
begin
  FList.Free;
  sDict.Free;
end;

//procedure TForm1.ValueNotify(Sender: TObject; const Item: TMyObject;
//    Action: TCollectionNotification);
//begin
//  if Action = cnRemoved then
//    Item.Free;
//end;

{ TMyObject }

procedure TMyObject.SetValue(const Value: Integer);
begin
  FValue := Value;
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.
