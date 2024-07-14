object FConfDatabase: TFConfDatabase
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 234
  ClientWidth = 375
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFundo: TJvPanel
    Left = 0
    Top = 0
    Width = 375
    Height = 234
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    OnMouseDown = pnlFundoMouseDown
    object btnConfirmar: TJvSpeedButton
      Left = 235
      Top = 153
      Width = 80
      Height = 25
      Caption = 'Confirmar'
      OnClick = btnConfirmarClick
    end
    object btnTestar: TJvSpeedButton
      Left = 140
      Top = 153
      Width = 78
      Height = 25
      Caption = 'Testar'
      OnClick = btnTestarClick
    end
    object btnCancelar: TJvSpeedButton
      Left = 49
      Top = 153
      Width = 78
      Height = 25
      Caption = 'Cancelar'
      OnClick = btnCancelarClick
    end
    object lblMensagem: TJvLabel
      Left = 0
      Top = 217
      Width = 371
      Height = 13
      Align = alBottom
      Transparent = True
      ExplicitWidth = 5
    end
    object edtHostname: TJvEdit
      Left = 6
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
      Left = 182
      Top = 32
      Width = 63
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
      Left = 6
      Top = 72
      Width = 358
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
      Left = 6
      Top = 112
      Width = 172
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
      Left = 191
      Top = 112
      Width = 152
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
  end
  object DialogoDatabase: TJvOpenDialog
    Height = 0
    Width = 0
    Left = 240
    Top = 16
  end
end
