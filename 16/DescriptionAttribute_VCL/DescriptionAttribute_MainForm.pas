unit DescriptionAttribute_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Contnrs, ComCtrls, Generics.Collections;

type
  TFormDescrAttr = class(TForm)
    ListView1: TListView;
    procedure FormCreate(Sender: TObject);
  private
    FObjectsList: TObjectList<TObject>;
  public
    procedure UpdateList;
  end;

var
  FormDescrAttr: TFormDescrAttr;

implementation

{$R *.dfm}

uses
  DescriptionAttribute_Classes, RTTI;

procedure TFormDescrAttr.FormCreate(Sender: TObject);
var
  APerson: TPerson;
  ACompany: TCompany;
begin
  FObjectsList := TObjectList<TObject>.Create;

  // add a person
  APerson := TPerson.Create;
  APerson.Name := 'Wiley';
  APerson.Country := 'Desert';
  APerson.BirthDate := Date - 1000;
  FObjectsList.Add(APerson);

  // add a company
  ACompany := TCompany.Create;
  ACompany.Name := 'ACME Inc.';
  ACompany.ID := IntToStr(GetTickCount);
  ACompany.Country := 'Worldwide';
  FObjectsList.Add(ACompany);

  // add an unrelated object
  FObjectsList.Add(TStringList.Create);

  UpdateList;
end;

function TypeHasDescription(AType: TRttiType): Boolean;
var
  Attrib: TCustomAttribute;
begin
  for Attrib in AType.GetAttributes do
  begin
    if (Attrib is DescriptionAttribute) then
      Exit(True);
  end;
  Result := False;
end;

procedure TFormDescrAttr.UpdateList;
var
  AnObject: TObject;
  Context: TRttiContext;
  AType: TRttiType;
  Attrib: TCustomAttribute;
  AMethod: TRttiMethod;
  StrDescr, StrID: string;
begin
  for AnObject in FObjectsList do
  begin
    AType := Context.GetType(AnObject.ClassInfo);
    if TypeHasDescription(AType) then
    begin
      for AMethod in AType.GetMethods do
        for Attrib in AMethod.GetAttributes do
          if Attrib is DescriptionAttribute then
            case DescriptionAttribute(Attrib).Kind of
              dakClass: ; // ignore
              dakDescription:
                // should check if duplicate attribute
                StrDescr := AMethod.Invoke(AnObject, []).ToString;
              dakId:
                StrID := AMethod.Invoke(AnObject, []).ToString;
            end;
      // done looking for attributes
      // should check if we found anything
      with ListView1.Items.Add do
      begin
        Caption := StrID;
        SubItems.Add(StrDescr);
      end;
    end;
  end;
  // else ignore the object, could raise an exception
end;

end.
