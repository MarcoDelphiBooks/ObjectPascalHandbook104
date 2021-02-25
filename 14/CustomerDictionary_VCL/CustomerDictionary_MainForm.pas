unit CustomerDictionary_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CustomerClasses, ComCtrls;

type
  TFormCustomerDictionary = class(TForm)
    BbtnPopulate: TButton;
    ListView1: TListView;
    procedure FormCreate(Sender: TObject);
    procedure BbtnPopulateClick(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    CustDict: TCustomerDictionary;
  public
    { Public declarations }
  end;

var
  FormCustomerDictionary: TFormCustomerDictionary;

implementation

uses
  CustomerDataModule, strUtils;

{$R *.dfm}

procedure TFormCustomerDictionary.BbtnPopulateClick(Sender: TObject);
var
  Custkey: TCustomerKey;
  ListItem: TListItem;
begin
  DataModule1.ClientDataSet1.Active := True;
  CustDict.LoadFromDataSet(DataModule1.ClientDataSet1);

  for Custkey in CustDict.Keys do
  begin
    ListItem := ListView1.Items.Add;
    ListItem.Caption := Custkey.Company;
    ListItem.SubItems.Add(FloatToStr(Custkey.CustNo));
    ListItem.Data := Custkey;
  end;
end;

procedure TFormCustomerDictionary.FormCreate(Sender: TObject);
begin
  CustDict := TCustomerDictionary.Create;
end;

procedure TFormCustomerDictionary.ListView1SelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
  ACustomer: TCustomer;
begin
  ACustomer := CustDict.Items[Item.Data];
  Item.SubItems.Add(IfThen(ACustomer.State <> '',
    ACustomer.State + ', ' + ACustomer.Country, ACustomer.Country));
end;

end.
