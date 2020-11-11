object FormAnonAjax: TFormAnonAjax
  Left = 0
  Top = 0
  Caption = 'AnonAjax'
  ClientHeight = 554
  ClientWidth = 548
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 113
    Top = 249
    Width = 417
    Height = 288
    Picture.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D494844520000001E0000
      001E08060000003B30AEA20000000467414D410000D6D8D44F58320000001974
      455874536F6674776172650041646F626520496D616765526561647971C9653C
      000000EB4944415478DA63CC997081010790066257206604E2FF0CD4034C40FC
      83118FC57240EC351016CB02B1E740F9D807AAF01F8596FD433283A0C5A2406C
      42251FF303B100D472821653131803B11510FF44B698118B426AC6294E8B4129
      971D1A0CCC40FC1C888FD3C3E2142083036A310B10DF03E22DF4B03801CDE2FB
      40BC7DD4E2518B472D1EB578D4E2518BE965B11910DB2259FC9D5E168B03B114
      10FF85F2FF62B3F82E10EFA4B2C51800DD6250307C00E2DB949A0BF5DD5520FE
      458CC50C50CB5929B498096AE11220FE4CACC5D400308B5701F1175C1627D1D0
      E215F82C8EA2A1C5EB81F82B3605000CDABED324B0A8870000000049454E44AE
      426082}
  end
  object BtnRead: TButton
    Left = 32
    Top = 24
    Width = 75
    Height = 25
    Caption = 'BtnRead'
    TabOrder = 0
    OnClick = BtnReadClick
  end
  object Memo1: TMemo
    Left = 113
    Top = 53
    Width = 417
    Height = 190
    TabOrder = 1
  end
  object EdUrl: TEdit
    Left = 113
    Top = 26
    Width = 417
    Height = 21
    TabOrder = 2
    Text = 'http://blog.marcocantu.com'
  end
  object BtnLinks: TButton
    Left = 32
    Top = 55
    Width = 75
    Height = 25
    Caption = 'BtnLinks'
    TabOrder = 3
    OnClick = BtnLinksClick
  end
  object BtnImages: TButton
    Left = 32
    Top = 88
    Width = 75
    Height = 25
    Caption = 'BtnImages'
    TabOrder = 4
    OnClick = BtnImagesClick
  end
end
