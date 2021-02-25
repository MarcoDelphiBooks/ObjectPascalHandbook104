unit TrivialXmlWriter;

interface

uses
  Classes, Generics.Collections;

type
  TTrivialXmlWriter = class
  private
    FWriter: TTextWriter;
    FNodes: TStack<string>;
    FOwnsTextWriter: Boolean;
  public
    constructor Create(AWriter: TTextWriter); overload;
    constructor Create(AStream: TStream); overload;
    destructor Destroy; override;
    procedure WriteStartElement(const SName: string);
    procedure WriteEndElement(Indent: Boolean = False);
    procedure WriteString(const SValue: string);
    procedure WriteObjectPublished(AnObj: TObject);
    procedure WriteObjectRtti(AnObj: TObject);
    procedure WriteObjectAttrib(AnObj: TObject);
    function Indentation: string;
  end;

  XmlAttribute = class(TCustomAttribute)
  private
    FTag: string;
  public
    constructor Create(StrTag: string = '');
    property TagName: string read FTag;
  end;

implementation

{ TTrivialXmlWriter }

uses
  System.TypInfo, System.SysUtils, System.RTTI;

function CheckXmlAttr(AField: TRttiField; var StrTag: string): Boolean;
var
  Attrib: TCustomAttribute;
begin
  Result := False;
  for Attrib in AField.GetAttributes do
    if Attrib is XmlAttribute then
    begin
      StrTag := XmlAttribute(Attrib).TagName;
      if StrTag = '' then // default value
        StrTag := AField.Name;
      Exit(True);
    end;
end;

constructor TTrivialXmlWriter.Create(AWriter: TTextWriter);
begin
  FWriter := AWriter;
  FNodes := TStack<string>.Create;
end;

constructor TTrivialXmlWriter.Create(AStream: TStream);
begin
  FWriter := TStreamWriter.Create (AStream);
  Create (FWriter); // Call first constructor
  FOwnsTextWriter := True;
end;

destructor TTrivialXmlWriter.Destroy;
begin
  while FNodes.Count > 0 do
    WriteEndElement;
  FNodes.Free;
  if FOwnsTextWriter then
    FreeAndNil (FWriter);
  inherited;
end;

function TTrivialXmlWriter.Indentation: string;
begin
  Result := StringOfChar (' ', FNodes.Count * 2)
end;

procedure TTrivialXmlWriter.WriteEndElement(Indent: Boolean);
var
  StrNode: string;
begin
  StrNode := FNodes.Pop;
  if Indent then
    FWriter.Write(Indentation);
  FWriter.Write('</' + StrNode + '>' + sLineBreak);
end;

procedure TTrivialXmlWriter.WriteObjectAttrib(AnObj: TObject);
var
  AContext: TRttiContext;
  AType: TRttiType;
  AField: TRttiField;
  StrTagName: string;
begin
  WriteString(sLineBreak); // new line
  AType := AContext.GetType(anObj.ClassType);
  for AField in AType.GetFields do
  begin
    if CheckXmlAttr(AField, StrTagName) then
    begin
      if AField.FieldType.IsInstance then
      begin
        WriteStartElement(StrTagName);
        WriteObjectAttrib(AField.GetValue(anObj).AsObject);
        WriteEndElement(True);
      end
      else
      begin
        WriteStartElement(StrTagName);
        WriteString(AField.GetValue(anObj).ToString);
        WriteEndElement;
      end;
    end;
  end;
end;

procedure TTrivialXmlWriter.WriteObjectPublished(AnObj: TObject);
var
  NProps, I: Integer;
  PropList: PPropList;
  InternalObject: TObject;
  StrPropName: string;
begin
  WriteString(sLineBreak); // new line
  // get list of properties
  NProps := GetTypeData(AnObj.ClassInfo)^.PropCount;
  if NProps = 0 then
    Exit;

  GetMem(PropList, NProps * SizeOf(Pointer));
  try
    GetPropInfos(AnObj.ClassInfo, PropList);
    for I := 0 to NProps - 1 do
    begin
      StrPropName := UTF8ToString(PropList[I].Name);
      case PropList[I].PropType^.Kind of

        tkUnknown, tkInteger, tkChar, tkEnumeration, tkFloat,
          tkString, tkUString, tkSet, tkWChar, tkLString, tkWString, tkInt64:
        begin
          WriteStartElement(StrPropName);
          WriteString(GetPropValue(AnObj, StrPropName));
          WriteEndElement;
        end;

        tkClass:
        begin
          InternalObject := GetObjectProp(AnObj, StrPropName);
          if Assigned(InternalObject) and // skip if nil
            InternalObject.InheritsFrom(TPersistent) then
          begin
            // recurse in subclass
            WriteStartElement(StrPropName);
            WriteObjectPublished(InternalObject as TPersistent);
            WriteEndElement(True);
          end;
        end; // tkClass
      end; // case
    end; // for
  finally
    FreeMem(PropList);
  end;
end;

procedure TTrivialXmlWriter.WriteObjectRtti(AnObj: TObject);
var
  AContext: TRttiContext;
  AType: TRttiType;
  AField: TRttiField;
begin
  WriteString(sLineBreak); // New line
  AType := AContext.GetType(anObj.ClassType);
  for AField in AType.GetFields do
  begin
    if AField.FieldType.IsInstance then
    begin
      WriteStartElement(AField.Name);
      WriteObjectRtti(AField.GetValue(anObj).AsObject);
      WriteEndElement(True);
    end
    else
    begin
      WriteStartElement(AField.Name);
      WriteString(AField.GetValue(anObj).ToString);
      WriteEndElement;
    end;
  end;
end;

procedure TTrivialXmlWriter.WriteStartElement(const SName: string);
begin
  FWriter.Write(Indentation + '<' + SName + '>');
  FNodes.Push(Sname);
end;

procedure TTrivialXmlWriter.WriteString(const SValue: string);
begin
  FWriter.Write(SValue);
end;

{ xmlAttribute }

constructor xmlAttribute.Create(StrTag: string);
begin
  FTag := StrTag;
end;

end.
