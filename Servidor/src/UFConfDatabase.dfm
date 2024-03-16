object FConfDatabase: TFConfDatabase
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 205
  ClientWidth = 387
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFundo: TJvPanel
    Left = 0
    Top = 0
    Width = 387
    Height = 205
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 293
    ExplicitHeight = 350
    DesignSize = (
      383
      201)
    object btnConfirmar: TJvSpeedButton
      Left = 192
      Top = 160
      Width = 75
      Height = 25
      Caption = 'Confirmar'
      OnClick = btnConfirmarClick
    end
    object btnTestar: TJvSpeedButton
      Left = 107
      Top = 160
      Width = 75
      Height = 25
      Caption = 'Testar'
      OnClick = btnTestarClick
    end
    object btnCancelar: TJvSpeedButton
      Left = 16
      Top = 160
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      OnClick = btnCancelarClick
    end
    object edtHostname: TJvEdit
      Left = 16
      Top = 32
      Width = 166
      Height = 21
      Hint = 'HOSTNAME DATABASE'
      Flat = False
      ParentFlat = False
      CharCase = ecUpperCase
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = ''
      TextHint = 'HOSTNAME'
    end
    object edtPorta: TJvEdit
      Left = 190
      Top = 32
      Width = 58
      Height = 21
      Hint = 'PORTA DATABASE'
      Flat = False
      ParentFlat = False
      CharCase = ecUpperCase
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = ''
      NumbersOnly = True
      TextHint = 'PORTA'
    end
    object edtCaminho: TJvEdit
      Left = 16
      Top = 72
      Width = 353
      Height = 21
      Hint = 'Click 2 Vezes para Abir Caixa de Pesquisa'
      Flat = False
      ParentFlat = False
      OnMouseEnter = edtCaminhoMouseEnter
      OnMouseLeave = edtCaminhoMouseLeave
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = ''
      OnDblClick = edtCaminhoDblClick
      TextHint = 'CAMINHO'
    end
    object edtUsuario: TJvEdit
      Left = 16
      Top = 112
      Width = 167
      Height = 21
      Hint = 'SYSDBA, ADMIN'
      Flat = False
      ParentFlat = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Text = ''
      TextHint = 'USERNAME'
    end
    object edtSenha: TJvEdit
      Left = 190
      Top = 112
      Width = 140
      Height = 21
      Hint = 'SYSDBA, ADMIN'
      Flat = False
      ParentFlat = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Text = ''
      TextHint = 'SENHA'
    end
    object pnlMensagens: TJvPanel
      Left = -2
      Top = 69
      Width = 387
      Height = 0
      Anchors = [akLeft, akRight, akBottom]
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 5
      ExplicitTop = 214
      ExplicitWidth = 293
      object lblMensagem: TJvLabel
        Left = 0
        Top = 0
        Width = 387
        Height = 0
        Align = alClient
        Transparent = True
        WordWrap = True
        ExplicitTop = 128
        ExplicitWidth = 293
        ExplicitHeight = 13
      end
    end
  end
  object DialogoDatabase: TJvOpenDialog
    Height = 0
    Width = 0
    Left = 240
    Top = 16
  end
end
