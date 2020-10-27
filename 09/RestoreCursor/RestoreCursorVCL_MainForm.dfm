object Form42: TForm42
  Left = 0
  Top = 0
  Caption = 'RestoreCursorVCL'
  ClientHeight = 291
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 24
    Top = 16
    Width = 121
    Height = 33
    Caption = 'try-finally'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 24
    Top = 55
    Width = 121
    Height = 33
    Caption = 'managed record'
    TabOrder = 1
    OnClick = Button2Click
  end
end
