object FConfigCliente: TFConfigCliente
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 120
  ClientWidth = 410
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnlGeral: TJvPanel
    Left = 0
    Top = 0
    Width = 410
    Height = 120
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object btnGravar: TJvSpeedButton
      Left = 216
      Top = 65
      Width = 105
      Height = 40
      Caption = 'Gravar'
      OnClick = btnGravarClick
    end
    object btnCancelar: TJvSpeedButton
      Left = 72
      Top = 65
      Width = 105
      Height = 40
      Caption = 'Cancelar'
      OnClick = btnCancelarClick
    end
    object edtHostname: TJvEdit
      Left = 56
      Top = 16
      Width = 145
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      Text = ''
      TextHint = 'HOSTNAME'
    end
    object edtPorta: TJvEdit
      Left = 232
      Top = 16
      Width = 73
      Height = 21
      TabOrder = 1
      Text = ''
      NumbersOnly = True
      TextHint = 'PORTA'
    end
  end
end
