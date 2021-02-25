unit XmlPersist_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, xmldom, XMLIntf, msxmldom, XMLDoc;

type
  TFormXmlPersist = class(TForm)
    BtnPublished: TButton;
    Memo1: TMemo;
    BtnRtti: TButton;
    BtnAttributes: TButton;
    procedure BtnPublishedClick(Sender: TObject);
    procedure BtnRttiClick(Sender: TObject);
    procedure BtnAttributesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormXmlPersist: TFormXmlPersist;

implementation

{$R *.dfm}

uses
  TrivialXmlWriter, XmlPersistPublish_Classes,
  XmlPersistRtti_Classes, XmlPersistAttrib_Classes;

procedure TFormXmlPersist.BtnAttributesClick(Sender: TObject);
var
  APerson: TAttrPerson;
  ACompany: TAttrCompany;
  SS: TStringStream;
  XmlWri: TTrivialXmlWriter;
begin
  // Create a person
  APerson := TAttrPerson.Create;
  APerson.Name := 'Wiley';
  APerson.Country := 'Desert';

  // Create a company and add person to it
  ACompany := TAttrCompany.Create;
  ACompany.Name := 'ACME Inc.';
  ACompany.ID := IntToStr(GetTickCount);
  ACompany.Country := 'Worldwide';
  ACompany.Boss := APerson;

  // Stream the company (and person)
  SS := TStringStream.Create;
  try
    XmlWri := TTrivialXmlWriter.Create(SS);
    try
      XmlWri.WriteStartElement('company');
      XmlWri.WriteObjectAttrib(ACompany);
      XmlWri.WriteEndElement;
    finally
       XmlWri.Free;
    end;
    // Reset and laod stream
    SS.Position := 0;
    Memo1.Lines.LoadFromStream(SS);
  finally
    SS.Free;
  end;
end;

procedure TFormXmlPersist.btnPublishedClick(Sender: TObject);
var
  APerson: TPerson;
  ACompany: TCompany;
  SS: TStringStream;
  XmlWri: TTrivialXmlWriter;
begin
  // Create a person
  APerson := TPerson.Create;
  APerson.Name := 'Wiley';
  APerson.Country := 'Desert';

  // Create a company and add person to it
  ACompany := TCompany.Create;
  ACompany.Name := 'ACME Inc.';
  ACompany.ID := IntToStr(GetTickCount);
  ACompany.Country := 'Worldwide';
  ACompany.Boss := APerson;

  // Stream the company (and person)
  SS := TStringStream.Create;
  try
    XmlWri := TTrivialXmlWriter.Create(SS);
    try
      XmlWri.WriteStartElement('company');
      XmlWri.WriteObjectPublished(ACompany);
      XmlWri.WriteEndElement;
    finally
       XmlWri.Free;
    end;
    // Reset and laod stream
    SS.Position := 0;
    Memo1.Lines.LoadFromStream(SS);
  finally
    SS.Free;
  end;
end;

procedure TFormXmlPersist.BtnRttiClick(Sender: TObject);
var
  APerson: TNewPerson;
  ACompany: TNewCompany;
  SS: TStringStream;
  XmlWri: TTrivialXmlWriter;
begin
  // Create a person
  APerson := TNewPerson.Create;
  APerson.Name := 'Wiley';
  APerson.Country := 'Desert';

  // Create a company and add person to it
  ACompany := TNewCompany.Create;
  ACompany.Name := 'ACME Inc.';
  ACompany.ID := IntToStr(GetTickCount);
  ACompany.Country := 'Worldwide';
  ACompany.Boss := APerson;

  // Stream the company (and person)
  SS := TStringStream.Create;
  try
    XmlWri := TTrivialXmlWriter.Create (SS);
    try
      XmlWri.WriteStartElement('company');
      XmlWri.WriteObjectRtti(ACompany);
      XmlWri.WriteEndElement;
    finally
       XmlWri.Free;
    end;
    // Reset and laod stream
    SS.Position := 0;
    Memo1.Lines.LoadFromStream(SS);
  finally
    SS.Free;
  end;
end;

end.
