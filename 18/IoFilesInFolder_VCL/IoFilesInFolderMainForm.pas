unit IoFilesInFolderMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TFormIoFiles = class(TForm)
    BtnSubfolders: TButton;
    EdBaseFolder: TEdit;
    BtnPasFiles: TButton;
    ListBox1: TListBox;
    LblFileInfo: TLabel;
    BtnFilterFolders: TButton;
    StatusBar1: TStatusBar;
    BtnFilterPasDpr: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnSubfoldersClick(Sender: TObject);
    procedure BtnPasFilesClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnFilterFoldersClick(Sender: TObject);
    procedure BtnFilterPasDprClick(Sender: TObject);
  private
    SFilesList: TStringList;
  end;

var
  FormIoFiles: TFormIoFiles;

implementation

{$R *.dfm}

uses
  Types, IOUtils, ShlObj, ComObj;

procedure TFormIoFiles.BtnFilterFoldersClick(Sender: TObject);
var
  PathList: TStringDynArray;
  StrPath: string;
  NTotal, NFound: Integer;
begin
  FreeAndNil(SFilesList); // disable ListBox OnClick
  if TDirectory.Exists(EdBaseFolder.Text) then
  begin
    ListBox1.Items.Clear;
    NTotal := 0;
    NFound := 0;
    PathList := TDirectory.GetDirectories(EdBaseFolder.Text,
      TSearchOption.soAllDirectories,
      function(const Path: string; const SearchRec: TSearchRec): Boolean
      begin
        Result := not (SearchRec.Name = '__history') and
          not (SearchRec.Name[1] = '.');
        Inc(NTotal);
        if Result then
          Inc(NFound);
        StatusBar1.SimpleText := Format('Folders %d/%d', [NFound, NTotal]);
        Application.ProcessMessages;
      end);
    for StrPath in PathList do
      ListBox1.Items.Add(StrPath);
  end;
end;

procedure TFormIoFiles.BtnFilterPasDprClick(Sender: TObject);
var
  PathList, FilesList: TStringDynArray;
  StrPath, StrFile: string;
  NTotal, NFound: Integer;
begin
  if TDirectory.Exists(EdBaseFolder.Text) then
  begin
    if not Assigned(SFilesList) then
      SFilesList := TStringList.Create
    else
      SFilesList.Clear;

    // clean up
    ListBox1.Items.Clear;

    // search in all subfolders
    PathList := TDirectory.GetDirectories(EdBaseFolder.Text,
      TSearchOption.soAllDirectories,
      function (const Path: string; const SearchRec: TSearchRec): Boolean
      begin
        Result := not (SearchRec.Name = '__history') and
          not (SearchRec.Name[1] = '.');
        Application.ProcessMessages;
      end);
    // add the current folder
    SetLength(PathList, Length(PathList) + 1);
    PathList[High(PathList)] := EdBaseFolder.Text;

    for StrPath in PathList do
    begin
      FilesList := TDirectory.GetFiles(StrPath, '*.*',
        function(const Path: string; const SearchRec: TSearchRec): Boolean
        var
          StrExt: string;
        begin
          StrExt := TPath.GetExtension(SearchRec.Name);
          Result := (StrExt = '.pas') or (StrExt = '.dpr');
          Inc(NTotal);
          if Result then
            Inc(NFound);
          StatusBar1.SimpleText := Format('Files %d/%d', [NFound, NTotal]);
          Application.ProcessMessages;
        end);
      for StrFile in FilesList do
        SFilesList.Add(StrFile);
    end;

    // now copy the file names only (no path) to a listbox
    for StrFile in SFilesList do
      ListBox1.Items.Add(TPath.GetFileName(StrFile));
  end;end;

procedure TFormIoFiles.BtnPasFilesClick(Sender: TObject);
var
  PathList, FilesList: TStringDynArray;
  StrPath, StrFile: string;
begin
  if TDirectory.Exists(EdBaseFolder.Text) then
  begin
    if not Assigned(SFilesList) then
      SFilesList := TStringList.Create
    else
      SFilesList.Clear;

    // clean up
    ListBox1.Items.Clear;

    // search in the given folder
    FilesList := TDirectory.GetFiles(EdBaseFolder.Text, '*.pas');
    for StrFile in FilesList do
      SFilesList.Add(StrFile);

    // search in all subfolders
    PathList := TDirectory.GetDirectories(EdBaseFolder.Text,
      TSearchOption.soAllDirectories, nil);
    for StrPath in PathList do
    begin
      FilesList := TDirectory.GetFiles(StrPath, '*.pas');
      for StrFile in FilesList do
        SFilesList.Add(StrFile);
    end;

    // now copy the file names only (no path) to a listbox
    for StrFile in SFilesList do
      ListBox1.Items.Add(TPath.GetFileName(StrFile));
  end;
end;

procedure TFormIoFiles.BtnSubfoldersClick(Sender: TObject);
var
  PathList: TStringDynArray;
  StrPath: string;
begin
  FreeAndNil(SFilesList); // disable ListBox OnClick
  if TDirectory.Exists(EdBaseFolder.Text) then
  begin
    ListBox1.Items.Clear;
    PathList := TDirectory.GetDirectories(EdBaseFolder.Text,
      TSearchOption.soAllDirectories, nil);
    for StrPath in PathList do
      ListBox1.Items.Add(StrPath);
  end;
end;

procedure TFormIoFiles.FormCreate(Sender: TObject);
var
  SzBufferW: string;
begin
  SetLength(SzBufferW, MAX_PATH);
  OleCheck(SHGetFolderPath(Handle, CSIDL_MYDOCUMENTS, 0, 0, PChar(SzBufferW)));
  edBaseFolder.Text := string(SzBufferW);
end;

procedure TFormIoFiles.FormDestroy(Sender: TObject);
begin
  FreeAndNil(SFilesList);
end;

procedure TFormIoFiles.ListBox1Click(Sender: TObject);
var
  StrFileName: string;
begin
  if not Assigned(SFilesList) then
    Exit;
  StrFileName := SFilesList[ListBox1.ItemIndex];
  lblFileInfo.Caption := StrFileName + sLineBreak +
    'Creation: ' + DateTimeToStr(TFile.GetCreationTime(StrFileName)) + sLineBreak +
    'LastAccess: ' + DateTimeToStr(TFile.GetLastAccessTime(StrFileName)) + sLineBreak +
    'LastWrite: ' + DateTimeToStr(TFile.GetLastWriteTime(StrFileName));
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.
