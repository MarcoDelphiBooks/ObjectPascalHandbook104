object FormIoFiles: TFormIoFiles
  Left = 0
  Top = 0
  Caption = 'IoFilesInFolder'
  ClientHeight = 373
  ClientWidth = 620
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object LblFileInfo: TLabel
    Left = 208
    Top = 296
    Width = 49
    Height = 13
    Caption = 'LblFileInfo'
  end
  object BtnSubfolders: TButton
    Left = 32
    Top = 88
    Width = 153
    Height = 25
    Caption = 'BtnSubfolders'
    TabOrder = 0
    OnClick = BtnSubfoldersClick
  end
  object EdBaseFolder: TEdit
    Left = 32
    Top = 40
    Width = 153
    Height = 21
    TabOrder = 1
  end
  object BtnPasFiles: TButton
    Left = 32
    Top = 128
    Width = 153
    Height = 25
    Caption = 'BtnPasFiles'
    TabOrder = 2
    OnClick = BtnPasFilesClick
  end
  object ListBox1: TListBox
    Left = 208
    Top = 40
    Width = 393
    Height = 241
    ItemHeight = 13
    TabOrder = 3
    OnClick = ListBox1Click
  end
  object BtnFilterFolders: TButton
    Left = 32
    Top = 169
    Width = 153
    Height = 25
    Caption = 'BtnFilterFolders'
    TabOrder = 4
    OnClick = BtnFilterFoldersClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 354
    Width = 620
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object BtnFilterPasDpr: TButton
    Left = 32
    Top = 208
    Width = 153
    Height = 25
    Caption = 'BtnFilterPasDpr'
    TabOrder = 6
    OnClick = BtnFilterPasDprClick
  end
end
