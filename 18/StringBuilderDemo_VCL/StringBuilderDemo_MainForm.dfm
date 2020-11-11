object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
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
  object BtnSBuilder: TButton
    Left = 8
    Top = 111
    Width = 105
    Height = 25
    Caption = 'BtnSBuilder'
    TabOrder = 0
    OnClick = BtnSBuilderClick
  end
  object GBSize: TGroupBox
    Left = 8
    Top = 8
    Width = 105
    Height = 89
    Caption = 'Size'
    TabOrder = 1
    object rbShort: TRadioButton
      Left = 16
      Top = 24
      Width = 57
      Height = 17
      Caption = 'rbShort'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbLong: TRadioButton
      Left = 16
      Top = 48
      Width = 57
      Height = 17
      Caption = 'rbLong'
      TabOrder = 1
    end
  end
  object ListBox1: TListBox
    Left = 128
    Top = 16
    Width = 418
    Height = 268
    ItemHeight = 13
    TabOrder = 2
  end
  object BtnString: TButton
    Left = 8
    Top = 142
    Width = 105
    Height = 25
    Caption = 'BtnString'
    TabOrder = 3
    OnClick = BtnStringClick
  end
end
