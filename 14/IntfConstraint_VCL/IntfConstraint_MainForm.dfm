object FormIntfConstraint: TFormIntfConstraint
  Left = 0
  Top = 0
  Caption = 'IntfConstraint'
  ClientHeight = 292
  ClientWidth = 570
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
    Top = 8
    Width = 97
    Height = 25
    Caption = 'BtnValue'
    TabOrder = 0
    OnClick = BtnValueClick
  end
  object Memo1: TMemo
    Left = 128
    Top = 8
    Width = 241
    Height = 276
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object BtnValueButton: TButton
    Left = 8
    Top = 40
    Width = 97
    Height = 25
    Caption = 'BtnValueButton'
    TabOrder = 2
    OnClick = BtnValueButtonClick
  end
  object BtnPlainIntf: TButton
    Left = 8
    Top = 71
    Width = 97
    Height = 25
    Caption = 'BtnPlainIntf'
    TabOrder = 3
    OnClick = BtnPlainIntfClick
  end
  object BtnConstructor: TButton
    Left = 8
    Top = 208
    Width = 97
    Height = 25
    Caption = 'BtnConstructor'
    TabOrder = 4
    OnClick = BtnConstructorClick
  end
  object ScrollBox1: TScrollBox
    Left = 376
    Top = 8
    Width = 185
    Height = 276
    TabOrder = 5
  end
end
