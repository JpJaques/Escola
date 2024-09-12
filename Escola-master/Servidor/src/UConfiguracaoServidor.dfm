object FConfigServidor: TFConfigServidor
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 200
  ClientWidth = 556
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pvlGeral: TJvPanel
    Left = 0
    Top = 0
    Width = 556
    Height = 200
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnlRodape: TJvPanel
      Left = 0
      Top = 152
      Width = 556
      Height = 48
      Align = alBottom
      BevelOuter = bvNone
      Color = 16775416
      ParentBackground = False
      TabOrder = 0
      object btnConfirmar: TJvSpeedButton
        Left = 288
        Top = 8
        Width = 86
        Height = 29
        Caption = 'Confirmar'
        OnClick = btnConfirmarClick
      end
      object btnCancelar: TJvSpeedButton
        Left = 152
        Top = 8
        Width = 86
        Height = 29
        Caption = 'Cancelar'
        OnClick = btnCancelarClick
      end
    end
    object pnlInfo: TJvPanel
      Left = 0
      Top = 0
      Width = 556
      Height = 152
      Align = alClient
      BevelOuter = bvNone
      Color = 16775416
      ParentBackground = False
      TabOrder = 1
      OnMouseDown = pnlInfoMouseDown
      DesignSize = (
        556
        152)
      object Label1: TLabel
        Left = 32
        Top = 24
        Width = 106
        Height = 28
        Caption = 'Hostname.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 77
        Top = 58
        Width = 61
        Height = 28
        Alignment = taRightJustify
        Caption = 'Porta.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtHostname: TJvEdit
        Left = 144
        Top = 24
        Width = 165
        Height = 29
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = ''
      end
      object edtPorta: TJvEdit
        Left = 144
        Top = 58
        Width = 121
        Height = 29
        Anchors = [akLeft, akTop, akRight, akBottom]
        AutoSize = False
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = ''
        NumbersOnly = True
      end
    end
  end
end
