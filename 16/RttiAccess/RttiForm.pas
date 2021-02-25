unit RttiForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.ListBox, FMX.ListView.Types, FMX.ListView,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    BtnReadValues: TButton;
    BtnInvoke: TButton;
    Memo1: TMemo;
    procedure BtnReadValuesClick(Sender: TObject);
    procedure BtnInvokeClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Show(StrMessage: string);
  end;

var
  Form1: TForm1;


implementation

{$R *.fmx}

uses
  System.Rtti;

procedure TForm1.BtnInvokeClick(Sender: TObject);
var
  Context: TRttiContext;
  AType: TRttiType;
  AMethod: TRttiMethod;
  TheValues: array of TValue;
  AValue: TValue;
begin
  AType := Context.GetType(TButton);
  AMethod := AType.GetMethod('ToString');
  TheValues := [];
  AValue := AMethod.Invoke(Sender, TheValues);
  Show(AValue.AsString);

  AType := Context.GetType(TForm1);
  AMethod := AType.GetMethod('Show');
  SetLength(TheValues, 1);
  TheValues[0] := AValue;
  AMethod.Invoke(self, TheValues);
end;

procedure TForm1.BtnReadValuesClick(Sender: TObject);
var
  Context: TRttiContext;
  AType: TRttiType;
  AProperty: TRttiProperty;
  AValue: TValue;
  AField: TRttiField;
begin
  AType := Context.GetType(TButton);
  AProperty := AType.GetProperty('Text');
  AValue := AProperty.GetValue(Sender);
  Show(AValue.AsString);

  AField := AType.GetField('FDesignInfo');
  AValue := AField.GetValue(Sender);
  Show(AValue.AsInteger.ToString);
end;

procedure TForm1.Show(StrMessage: string);
begin
  Memo1.Lines.Add(StrMessage);
end;

end.
