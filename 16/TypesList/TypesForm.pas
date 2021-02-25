unit TypesForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.ListBox, FMX.ListView.Types, FMX.ListView,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    BtnTypesList: TButton;
    ListView1: TListView;
    procedure BtnTypesListClick(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
  private
    { Private declarations }
  public
  end;

var
  Form1: TForm1;



implementation

{$R *.fmx}

uses
  System.Rtti, TypeInfoForm;

procedure TForm1.BtnTypesListClick(Sender: TObject);
var
  AContext: TRttiContext;
  TheTypes: TArray<TRttiType>;
  SList: TStringList;
  AType: TRttiType;
  STypeName: string;
begin
  ListView1.Items.Clear;
  SList := TStringList.Create;
  try
    TheTypes := AContext.GetTypes;
    for AType in TheTypes do
      if AType.IsInstance then
        SList.Add(AType.QualifiedName);
    SList.Sort;
    ListView1.BeginUpdate;
    try
      for STypeName in SList do
        (ListView1.Items.Add).Text := STypeName;
    finally
      ListView1.EndUpdate;
    end;
  finally
    SList.Free;
  end;
end;

procedure TForm1.ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  FormTypeInfo.Clear;
  FormTypeInfo.ShowTypeDetails(AItem.Text);
  FormTypeInfo.Show;
end;

end.
