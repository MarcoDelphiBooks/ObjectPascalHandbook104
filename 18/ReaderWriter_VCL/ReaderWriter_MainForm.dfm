object FormReaderWriter: TFormReaderWriter
  Left = 0
  Top = 0
  Caption = 'ReaderWriter'
  ClientHeight = 376
  ClientWidth = 606
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 16
    Width = 39
    Height = 13
    Caption = 'Streams'
  end
  object Label2: TLabel
    Left = 200
    Top = 16
    Width = 33
    Height = 13
    Caption = 'Strings'
  end
  object Label3: TLabel
    Left = 360
    Top = 16
    Width = 19
    Height = 13
    Caption = 'XML'
  end
  object BtnWrite: TButton
    Left = 32
    Top = 35
    Width = 129
    Height = 25
    Caption = 'BtnWrite'
    TabOrder = 0
    OnClick = BtnWriteClick
  end
  object BtnRead: TButton
    Left = 32
    Top = 80
    Width = 129
    Height = 25
    Caption = 'BtnRead'
    TabOrder = 1
    OnClick = BtnReadClick
  end
  object BtnWriteAndRead: TButton
    Left = 200
    Top = 35
    Width = 121
    Height = 25
    Caption = 'BtnWriteAndRead'
    TabOrder = 2
    OnClick = BtnWriteAndReadClick
  end
  object Memo1: TMemo
    Left = 32
    Top = 128
    Width = 441
    Height = 217
    TabOrder = 3
  end
  object BtnXmlCorrect: TButton
    Left = 360
    Top = 35
    Width = 113
    Height = 25
    Caption = 'BtnXmlCorrect'
    TabOrder = 4
    OnClick = BtnXmlCorrectClick
  end
  object BtnXmlUnbalanced: TButton
    Left = 360
    Top = 80
    Width = 113
    Height = 25
    Caption = 'BtnXmlUnbalanced'
    TabOrder = 5
    OnClick = BtnXmlUnbalancedClick
  end
  object BtnClassic: TButton
    Left = 495
    Top = 126
    Width = 103
    Height = 25
    Caption = 'BtnClassic'
    TabOrder = 6
    OnClick = BtnClassicClick
  end
end
