object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'MR 101'
  ClientHeight = 342
  ClientWidth = 761
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    761
    342)
  PixelsPerInch = 96
  TextHeight = 19
  object Button1: TButton
    Left = 16
    Top = 23
    Width = 125
    Height = 35
    Caption = 'Tests'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 160
    Top = 21
    Width = 583
    Height = 297
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
  end
  object Button2: TButton
    Left = 16
    Top = 64
    Width = 125
    Height = 35
    Caption = 'parameters'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 16
    Top = 176
    Width = 125
    Height = 35
    Caption = 'exception'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 16
    Top = 232
    Width = 125
    Height = 35
    Caption = 'arrays'
    TabOrder = 4
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 16
    Top = 288
    Width = 125
    Height = 33
    Caption = 'copy constr'
    TabOrder = 5
    OnClick = Button6Click
  end
end
