object Form30: TForm30
  Left = 0
  Top = 0
  Caption = 'TypeCompRules'
  ClientHeight = 215
  ClientWidth = 604
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BtnArrays: TButton
    Left = 40
    Top = 75
    Width = 97
    Height = 25
    Caption = 'Arrays'
    TabOrder = 0
    OnClick = BtnArraysClick
  end
  object BtnGenerics: TButton
    Left = 40
    Top = 106
    Width = 97
    Height = 25
    Caption = 'Generics'
    TabOrder = 1
    OnClick = BtnGenericsClick
  end
  object BtnGlobal: TButton
    Left = 40
    Top = 168
    Width = 97
    Height = 25
    Caption = 'Global'
    TabOrder = 2
    OnClick = BtnGlobalClick
  end
  object Memo1: TMemo
    Left = 152
    Top = 24
    Width = 425
    Height = 169
    Lines.Strings = (
      'Memo1')
    TabOrder = 3
  end
  object BtnOtherUnit: TButton
    Left = 40
    Top = 137
    Width = 97
    Height = 25
    Caption = 'OtherUnit'
    TabOrder = 4
    OnClick = BtnOtherUnitClick
  end
  object BtnTypeCheck: TButton
    Left = 40
    Top = 22
    Width = 97
    Height = 25
    Caption = 'TypeCheck'
    TabOrder = 5
    OnClick = BtnTypeCheckClick
  end
end
