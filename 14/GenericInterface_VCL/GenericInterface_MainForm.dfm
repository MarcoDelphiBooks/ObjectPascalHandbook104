object FormGenericInterface: TFormGenericInterface
  Left = 0
  Top = 0
  Caption = 'GenericInterface'
  ClientHeight = 292
  ClientWidth = 553
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BtnValue: TButton
    Left = 8
    Top = 9
    Width = 97
    Height = 25
    Caption = 'BtnValue'
    TabOrder = 0
    OnClick = BtnValueClick
  end
  object Memo1: TMemo
    Left = 111
    Top = 8
    Width = 241
    Height = 276
    TabOrder = 1
  end
  object BtnValueButton: TButton
    Left = 8
    Top = 104
    Width = 97
    Height = 25
    Caption = 'BtnValueButton'
    TabOrder = 2
    OnClick = BtnValueButtonClick
  end
  object BtnIValue: TButton
    Left = 8
    Top = 40
    Width = 97
    Height = 25
    Caption = 'BtnIValue'
    TabOrder = 3
    OnClick = BtnIValueClick
  end
  object ScrollBox1: TScrollBox
    Left = 358
    Top = 8
    Width = 185
    Height = 276
    TabOrder = 4
  end
end
