unit ShowMemoryForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Objects;

type
  TForm1 = class(TForm)
    Button1: TButton;
    AniIndicator1: TAniIndicator;
    Image2: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  System.UIConsts, FMX.Utils;

procedure TForm1.Button1Click(Sender: TObject);
var
  AMemoryMap: TMemoryMap;
  CS: TChunkStatus;
  I: Integer;
  Col: TAlphaColor;
  Bitmap1: TBitmap;
  BD1: TBitmapData;
  P1: PAlphaColorArray;
begin
  AniIndicator1.Enabled := True;
  AniIndicator1.Visible := True;

  Bitmap1:= TBitmap.Create(256, 256);
  try
    Bitmap1.Map(TMapAccess.Write, BD1);
    Col := claBlack; // only to avoid warning
    GetMemoryMap(AMemoryMap);
    for I := Low(aMemoryMap) to High(aMemoryMap) do
    begin
      CS := AMemoryMap[I];
      case CS of
        csUnallocated: Col := claWhite;
        csAllocated: Col := claBlue;
        csReserved: Col := claRed;
        csSysAllocated: Col := claBlack;
        csSysReserved: Col := claYellow;
      end;

      P1 := PAlphaColorArray(BD1.GetScanline(I mod 256));
      P1[I div 256] := Col;
    end;
    Bitmap1.Unmap(BD1);
    Image2.Bitmap := Bitmap1;
  finally
    AniIndicator1.Enabled := False;
    AniIndicator1.Visible := False;
    Bitmap1.Free;
  end;

end;

end.
