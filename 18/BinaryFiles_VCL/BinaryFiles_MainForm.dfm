object FormBinary: TFormBinary
  Left = 0
  Top = 0
  Caption = 'BinaryFiles'
  ClientHeight = 390
  ClientWidth = 663
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
  object BtnWrite: TButton
    Left = 8
    Top = 22
    Width = 201
    Height = 25
    Caption = 'Write Binary'
    TabOrder = 0
    OnClick = BtnWriteClick
  end
  object BtnRead: TButton
    Left = 8
    Top = 64
    Width = 201
    Height = 25
    Caption = 'Read Binary'
    TabOrder = 1
    OnClick = BtnReadClick
  end
  object Memo1: TMemo
    Left = 232
    Top = 24
    Width = 417
    Height = 353
    TabOrder = 2
  end
  object BtnWriteRecord: TButton
    Left = 8
    Top = 128
    Width = 201
    Height = 25
    Caption = 'Write Record'
    TabOrder = 3
    OnClick = BtnWriteRecordClick
  end
  object BtnReadRecord: TButton
    Left = 8
    Top = 175
    Width = 201
    Height = 25
    Caption = 'Read Record'
    TabOrder = 4
    OnClick = BtnReadRecordClick
  end
end
