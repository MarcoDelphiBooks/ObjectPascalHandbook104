object Form39: TForm39
  Left = 0
  Top = 0
  Caption = 'RttiAttrib'
  ClientHeight = 292
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
  object BtnMethods: TButton
    Left = 26
    Top = 76
    Width = 105
    Height = 25
    Caption = 'BtnMethods'
    TabOrder = 0
    OnClick = BtnMethodsClick
  end
  object Memo1: TMemo
    Left = 152
    Top = 26
    Width = 385
    Height = 239
    TabOrder = 1
  end
  object BtnClassAttribs: TButton
    Left = 26
    Top = 24
    Width = 105
    Height = 25
    Caption = 'BtnClassAttribs'
    TabOrder = 2
    OnClick = BtnClassAttribsClick
  end
  object BtnInvokeIfZero: TButton
    Left = 26
    Top = 128
    Width = 105
    Height = 25
    Caption = 'BtnInvokeIfZero'
    TabOrder = 3
    OnClick = BtnInvokeIfZeroClick
  end
end
