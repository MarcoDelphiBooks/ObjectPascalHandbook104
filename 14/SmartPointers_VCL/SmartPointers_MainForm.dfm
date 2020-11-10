object FormSmartPointers: TFormSmartPointers
  Left = 0
  Top = 0
  Caption = 'SmartPointers'
  ClientHeight = 361
  ClientWidth = 525
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BtnLeak: TButton
    Left = 72
    Top = 30
    Width = 113
    Height = 25
    Caption = 'BtnLeak'
    TabOrder = 0
    OnClick = BtnLeakClick
  end
  object BtnSmart: TButton
    Left = 72
    Top = 61
    Width = 113
    Height = 25
    Caption = 'BtnSmart'
    TabOrder = 1
    OnClick = BtnSmartClick
  end
  object BtnSmartShort: TButton
    Left = 72
    Top = 92
    Width = 113
    Height = 25
    Caption = 'BtnSmartShort'
    TabOrder = 2
    OnClick = BtnSmartShortClick
  end
  object BtnImplicitCreate: TButton
    Left = 72
    Top = 123
    Width = 113
    Height = 25
    Caption = 'BtnImplicitCreate'
    TabOrder = 3
    OnClick = BtnImplicitCreateClick
  end
  object Memo1: TMemo
    Left = 232
    Top = 32
    Width = 249
    Height = 289
    TabOrder = 4
  end
end
