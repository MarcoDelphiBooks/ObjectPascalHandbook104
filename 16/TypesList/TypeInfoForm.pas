unit TypeInfoForm;

interface

uses
  System.SysUtils, System.RTTI, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView, FMX.TabControl, FMX.StdCtrls,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Controls.Presentation;

type
  TFormTypeInfo = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    LVProperties: TListView;
    LVMethods: TListView;
    LVFields: TListView;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    LabelType: TLabel;
  private
    { Private declarations }
  public
    procedure Clear;
    procedure ShowTypeDetails(typename: string);
  end;

var
  FormTypeInfo: TFormTypeInfo;

implementation

{$R *.fmx}

uses
  System.TypInfo;

{ TFormTypeInfo }

procedure TFormTypeInfo.Clear;
begin
  LVProperties.Items.Clear;
  LVMethods.Items.Clear;
  LVFields.Items.Clear;
end;

function VisibilityToken(MV: TMemberVisibility): string;
begin
  case MV of
    mvPrivate: Result := '[pri]';
    mvProtected: Result := '[pro]';
    mvPublic: Result := '[pub]';
    mvPublished: Result := '[pbl]';
  else
    Result := '[und]';
  end;
end;

procedure TFormTypeInfo.ShowTypeDetails(TypeName: string);
var
  AContext: TRttiContext;
  AType: TRttiType;
  AProperty: TRttiProperty;
  AMethod: TRttiMethod;
  AField: TRttiField;
begin
  AType := AContext.FindType(TypeName);
  if not Assigned(AType) then
    Exit;

  LabelType.Text := AType.QualifiedName;
  for AProperty in AType.GetProperties do
    FormTypeInfo.LVProperties.Items.Add.Text := AProperty.Name +
      ': ' + AProperty.PropertyType.Name + ' ' +
      VisibilityToken(AProperty.Visibility);
  for AMethod in AType.GetMethods do
    LVMethods.Items.Add.Text := AMethod.Name + ' ' +
      VisibilityToken(AMethod.Visibility);
  for AField in AType.GetFields do
    LVFields.Items.Add.Text := AField.Name + ': ' +
      AField.FieldType.Name + ' ' +
      VisibilityToken(AField.Visibility);
end;

end.
