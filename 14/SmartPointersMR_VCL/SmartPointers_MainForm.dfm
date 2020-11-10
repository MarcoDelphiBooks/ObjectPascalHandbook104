object FormSmartPointers: TFormSmartPointers
  Left = 0
  Top = 0
  Caption = 'SmartPointers'
  ClientHeight = 361
  ClientWidth = 525
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BtnLeak: TButton
    Left = 72
    Top = 30
    Width = 113
    Height = 25
    Caption = 'BtnLeak'
    TabOrder = 0
    OnClick = BtnLeakClick
  end
  object Btnmanage: TButton
    Left = 72
    Top = 81
    Width = 113
    Height = 25
    Caption = 'BtnManage'
    TabOrder = 1
    OnClick = BtnmanageClick
  end
  object BtnAutoSmart: TButton
    Left = 72
    Top = 136
    Width = 113
    Height = 25
    Caption = 'BtnAutoSmart'
    TabOrder = 2
    OnClick = BtnAutoSmartClick
  end
  object Memo1: TMemo
    Left = 232
    Top = 32
    Width = 249
    Height = 289
    TabOrder = 3
  end
end
