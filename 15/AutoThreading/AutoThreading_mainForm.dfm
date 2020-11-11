object ThreadingForm: TThreadingForm
  Left = 0
  Top = 0
  Caption = 'AutoThreading'
  ClientHeight = 312
  ClientWidth = 581
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnAutoThread: TButton
    Left = 48
    Top = 56
    Width = 161
    Height = 25
    Caption = 'Automatic Thread'
    TabOrder = 0
    OnClick = btnAutoThreadClick
  end
  object Button2: TButton
    Left = 48
    Top = 184
    Width = 161
    Height = 25
    Caption = 'Spin Demo'
    TabOrder = 1
    OnClick = Button2Click
  end
  object btnPlain: TButton
    Left = 48
    Top = 25
    Width = 161
    Height = 25
    Caption = 'Plain Code'
    TabOrder = 2
    OnClick = btnPlainClick
  end
  object btnBlockingHttp: TButton
    Left = 240
    Top = 25
    Width = 161
    Height = 25
    Caption = 'Blocking Http'
    TabOrder = 3
    OnClick = btnBlockingHttpClick
  end
  object btnThreadedHttp: TButton
    Left = 240
    Top = 56
    Width = 161
    Height = 25
    Caption = 'Threaded Http'
    TabOrder = 4
    OnClick = btnThreadedHttpClick
  end
  object Memo1: TMemo
    Left = 240
    Top = 96
    Width = 313
    Height = 193
    TabOrder = 5
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 464
    Top = 32
  end
end
