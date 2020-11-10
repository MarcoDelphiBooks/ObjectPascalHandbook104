object Form39: TForm39
  Left = 0
  Top = 0
  Caption = 'ObjFromIntf'
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
  object BtnSimpleTest: TButton
    Left = 56
    Top = 48
    Width = 185
    Height = 25
    Caption = 'BtnSimpleTest'
    TabOrder = 0
    OnClick = BtnSimpleTestClick
  end
  object BtnRefCountIssue: TButton
    Left = 56
    Top = 88
    Width = 185
    Height = 25
    Caption = 'BtnRefCountIssue'
    TabOrder = 1
    OnClick = BtnRefCountIssueClick
  end
end
