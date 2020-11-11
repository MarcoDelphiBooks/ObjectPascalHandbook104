object FormAnonymFirst: TFormAnonymFirst
  Left = 0
  Top = 0
  Caption = 'AnonymFirst'
  ClientHeight = 310
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BtnSimpleVar: TButton
    Left = 8
    Top = 9
    Width = 114
    Height = 25
    Caption = 'BtnSimpleVar'
    TabOrder = 0
    OnClick = BtnSimpleVarClick
  end
  object Memo1: TMemo
    Left = 136
    Top = 8
    Width = 409
    Height = 273
    TabOrder = 1
  end
  object BtnProcParam: TButton
    Left = 8
    Top = 41
    Width = 114
    Height = 25
    Caption = 'BtnProcParam'
    TabOrder = 2
    OnClick = BtnProcParamClick
  end
  object BtnLocalVal: TButton
    Left = 8
    Top = 72
    Width = 114
    Height = 25
    Caption = 'BtnLocalVal'
    TabOrder = 3
    OnClick = BtnLocalValClick
  end
  object BtnStore: TButton
    Left = 8
    Top = 120
    Width = 114
    Height = 25
    Caption = 'BtnStore'
    TabOrder = 4
    OnClick = BtnStoreClick
  end
  object BtnCall: TButton
    Left = 8
    Top = 152
    Width = 114
    Height = 25
    Caption = 'BtnCall'
    TabOrder = 5
    OnClick = BtnCallClick
  end
  object BtnNoParen: TButton
    Left = 8
    Top = 183
    Width = 114
    Height = 25
    Caption = 'BtnNoParen'
    TabOrder = 6
  end
  object BtnReturn: TButton
    Left = 8
    Top = 248
    Width = 114
    Height = 25
    Caption = 'BtnReturn'
    TabOrder = 7
    OnClick = BtnReturnClick
  end
end
