object TextScrubberOptionsForm: TTextScrubberOptionsForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'TextScrubber Options'
  ClientHeight = 249
  ClientWidth = 268
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
    268
    249)
  PixelsPerInch = 96
  TextHeight = 13
  object OkBtn: TButton
    Left = 104
    Top = 216
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 185
    Top = 216
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object ClickChoiceRadioGroup: TRadioGroup
    Left = 6
    Top = 8
    Width = 254
    Height = 89
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Tray Icon Click Action'
    Items.Strings = (
      'Scrub text of formatting'
      'Scrub and remove line breaks')
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 103
    Width = 252
    Height = 98
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Other Options'
    TabOrder = 3
    DesignSize = (
      252
      98)
    object cbShouldTrim: TCheckBox
      Left = 8
      Top = 24
      Width = 241
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Remove spaces at each end when scrubbing'
      TabOrder = 0
    end
    object cbRunOnStartup: TCheckBox
      Left = 8
      Top = 47
      Width = 225
      Height = 17
      Caption = 'Run %s on Startup'
      TabOrder = 1
    end
  end
end
