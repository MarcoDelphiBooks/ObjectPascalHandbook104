unit AnonAjax_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, GIFImg, Vcl.Imaging.pngimage;

type
  TFormAnonAjax = class(TForm)
    BtnRead: TButton;
    Memo1: TMemo;
    EdUrl: TEdit;
    Image1: TImage;
    BtnLinks: TButton;
    BtnImages: TButton;
    procedure BtnReadClick(Sender: TObject);
    procedure BtnLinksClick(Sender: TObject);
    procedure BtnImagesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAnonAjax: TFormAnonAjax;

implementation

{$R *.dfm}

uses
  AnonAjax_Thread, System.StrUtils;

procedure TFormAnonAjax.BtnReadClick(Sender: TObject);
begin
  AjaxCall(EdUrl.Text,
    procedure(AResponseContent: TStringStream)
    begin
      Memo1.Lines.Text := AResponseContent.DataString;
      Memo1.Lines.Insert(0, 'From URL: ' + EdUrl.Text);
    end);
end;

procedure TFormAnonAjax.BtnLinksClick(Sender: TObject);
begin
  AjaxCall(EdUrl.Text,
    procedure(AResponseContent: TStringStream)
    begin
      ExtractLinks(AResponseContent.DataString,
        procedure(const AUrl: string)
        begin
          Memo1.Lines.Add(AUrl + ' in ' + EdUrl.Text);
        end);
    end);
end;

procedure TFormAnonAjax.BtnImagesClick(Sender: TObject);
var
  NHit: Integer;
begin
  NHit := 0;
  AjaxCall(EdUrl.Text,
    procedure(AResponseContent: TStringStream)
    begin
      ExtractImages(AResponseContent.DataString,
        procedure(const AUrl: string)
        begin
          Inc(NHit);
          Memo1.Lines.Add(IntToStr (NHit) + '.' + AUrl + ' in ' + EdUrl.Text);
          if nHit = 1 then // Load the first
          begin
            var RealURL := IfThen(AURL[1]='/', EdUrl.Text + AURL, AURL);
            AjaxCall(RealUrl,
              procedure(AResponseContent: TStringStream)
              begin
                // Load image of the current type only
                Image1.Picture.Graphic.LoadFromStream(AResponseContent);
              end);
          end;
        end);
    end);
end;

end.
