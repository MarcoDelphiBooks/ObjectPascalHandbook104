unit KeyValueForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, KeyValueCode;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    FKV: TKeyValue<TButton>;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  FKV.Key := 'mykey';
  FKV.Value := Sender as TButton;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  FKV.Value := Sender as TButton; // was "self"
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  // ShowMessage('[' + FKV.Key + ',' + FKV.Value.ClassName + ']');
  ShowMessage('[' + FKV.Key + ',' + FKV.Value.Name + ']');
end;

procedure TForm2.Button4Click(Sender: TObject);
var
  KVO: TKeyValue<TObject>;
begin
  KVO := TKeyValue<TObject>.Create;
  try
    KVO.Key := 'object';
    KVO.Value := Sender;
    KVO.Value := self;
    ShowMessage('[' + KVO.Key + ',' +
      KVO.Value.ClassName + ']');
  finally
    KVO.Free;
  end;
end;

procedure TForm2.Button5Click(Sender: TObject);
var
  KVI: TKeyValue<Integer>;
begin
  KVI := TKeyValue<Integer>.Create;
  try
    KVI.Key := 'object';
    KVI.Value := 100;
    KVI.Value := Left;
    ShowMessage('[' + KVI.Key + ',' +
      IntToStr(KVI.Value) + ']');
  finally
    KVI.Free;
  end;
end;

procedure TForm2.Button6Click(Sender: TObject);
var
  KVO: TKeyValue<TComponent>;
begin
  KVO := TKeyValue<TComponent>.Create;
  try
    KVO.Key := 'object';
    KVO.Value := Sender as TComponent;
    KVO.Value := self;
    ShowMessage('[' + KVO.Key + ',' +
      KVO.Value.Name + ']');
  finally
    KVO.Free;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  FKV := TKeyValue<TButton>.Create;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FKV.Free;
end;

end.
