object ControlEnumForm: TControlEnumForm
  Left = 0
  Top = 0
  Caption = 'ControlEnum'
  ClientHeight = 302
  ClientWidth = 581
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 344
    Top = 8
    Width = 229
    Height = 286
    TabOrder = 0
  end
  object BtnFormChild: TButton
    Left = 23
    Top = 8
    Width = 106
    Height = 25
    Caption = 'BtnFormChild'
    TabOrder = 1
    OnClick = BtnFormChildClick
  end
  object Edit1: TEdit
    Left = 16
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 96
    Width = 97
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 3
  end
  object RadioButton1: TRadioButton
    Left = 16
    Top = 136
    Width = 113
    Height = 17
    Caption = 'RadioButton1'
    TabOrder = 4
  end
  object Panel1: TPanel
    Left = 16
    Top = 168
    Width = 305
    Height = 126
    Caption = 'Panel1'
    TabOrder = 5
    object BtnPanelChild: TButton
      Left = 22
      Top = 32
      Width = 91
      Height = 25
      Caption = 'BtnPanelChild'
      TabOrder = 0
      OnClick = BtnPanelChildClick
    end
    object ComboBox1: TComboBox
      Left = 24
      Top = 88
      Width = 145
      Height = 21
      TabOrder = 1
      Text = 'ComboBox1'
    end
  end
  object BtnFormComps: TButton
    Left = 135
    Top = 8
    Width = 98
    Height = 25
    Caption = 'BtnFormComps'
    TabOrder = 6
    OnClick = BtnFormCompsClick
  end
  object BtnButtonChild: TButton
    Left = 240
    Top = 8
    Width = 98
    Height = 25
    Caption = 'BtnButtonChild'
    TabOrder = 7
    OnClick = BtnButtonChildClick
  end
  object MainMenu1: TMainMenu
    Left = 240
    Top = 80
  end
end
