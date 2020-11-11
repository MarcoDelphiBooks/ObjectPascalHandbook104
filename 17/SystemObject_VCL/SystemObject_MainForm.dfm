object FormSystemObject: TFormSystemObject
  Left = 0
  Top = 0
  Caption = 'SystemObject'
  ClientHeight = 292
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 136
    Top = 48
    Width = 401
    Height = 233
    TabOrder = 0
  end
  object BtnCompare: TButton
    Left = 8
    Top = 14
    Width = 105
    Height = 25
    Caption = 'BtnCompare'
    TabOrder = 1
    OnClick = BtnCompareClick
  end
  object BtnTest: TButton
    Left = 8
    Top = 96
    Width = 105
    Height = 25
    Caption = 'BtnTest'
    TabOrder = 2
    OnClick = BtnTestClick
  end
  object ComboBox1: TComboBox
    Left = 136
    Top = 16
    Width = 189
    Height = 21
    TabOrder = 3
    Text = 'ComboBox1'
  end
  object ComboBox2: TComboBox
    Left = 341
    Top = 16
    Width = 196
    Height = 21
    TabOrder = 4
    Text = 'ComboBox2'
  end
  object Button1: TButton
    Left = 8
    Top = 136
    Width = 105
    Height = 25
    Caption = 'Button1'
    TabOrder = 5
  end
end
