object AboutForm: TAboutForm
  Left = 772
  Top = 447
  Anchors = []
  BorderStyle = bsDialog
  Caption = 'About Text Scrubber'
  ClientHeight = 190
  ClientWidth = 364
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    364
    190)
  PixelsPerInch = 96
  TextHeight = 13
  object MainIconImage: TImage
    Left = 8
    Top = 8
    Width = 57
    Height = 57
  end
  object lblTitle: TLabel
    Left = 88
    Top = 8
    Width = 146
    Height = 25
    Caption = 'Text Scrubber'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVersion: TLabel
    Left = 88
    Top = 39
    Width = 35
    Height = 13
    Caption = 'Version'
  end
  object lblCopyright: TLabel
    Left = 88
    Top = 109
    Width = 57
    Height = 13
    Caption = 'lblCopyright'
  end
  object lblDescription: TLabel
    Left = 88
    Top = 58
    Width = 258
    Height = 45
    AutoSize = False
    Caption = 'lblDescription'
    WordWrap = True
  end
  object OkBtn: TButton
    Left = 139
    Top = 143
    Width = 73
    Height = 25
    Anchors = []
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 0
  end
end
