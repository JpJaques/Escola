object FPaiCadastro: TFPaiCadastro
  Left = 366
  Top = 0
  Caption = 'FPaiCadastro'
  ClientHeight = 402
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PanelPai: TPanel
    Left = 0
    Top = 0
    Width = 632
    Height = 41
    Align = alTop
    TabOrder = 0
    OnExit = PanelPaiExit
    ExplicitWidth = 943
    object Codigo: TLabel
      Left = 14
      Top = 14
      Width = 53
      Height = 13
      Caption = 'C'#243'digo....:'
    end
    object EditCodigo: TJvCalcEdit
      Left = 73
      Top = 11
      Width = 121
      Height = 21
      ImageKind = ikEllipsis
      TabOrder = 0
      DecimalPlacesAlwaysShown = False
      OnButtonClick = EditCodigoButtonClick
      OnKeyPress = EditCodigoKeyPress
    end
    object Anterior: TButton
      Left = 511
      Top = 2
      Width = 32
      Height = 33
      Caption = '<'
      TabOrder = 1
      OnClick = AnteriorClick
    end
    object Proximo: TButton
      Left = 556
      Top = 2
      Width = 32
      Height = 33
      Caption = '>'
      TabOrder = 2
      OnClick = ProximoClick
    end
    object Ultimo: TButton
      Left = 600
      Top = 2
      Width = 30
      Height = 33
      Caption = '>>'
      TabOrder = 3
      OnClick = UltimoClick
    end
    object Primeiro: TButton
      Left = 467
      Top = 2
      Width = 32
      Height = 33
      Caption = '<<'
      TabOrder = 4
      OnClick = PrimeiroClick
    end
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 47
    Width = 457
    Height = 354
    ActivePage = TabSheet1
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Principal'
      ExplicitTop = 21
    end
  end
  object Panel2: TPanel
    Left = 467
    Top = 47
    Width = 163
    Height = 354
    Caption = ' '
    Color = clMenu
    ParentBackground = False
    TabOrder = 1
    object Incluir: TButton
      Left = 21
      Top = 24
      Width = 116
      Height = 33
      Caption = 'Incluir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = IncluirClick
    end
    object Gravar: TButton
      Left = 21
      Top = 86
      Width = 116
      Height = 33
      Caption = 'Gravar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = GravarClick
    end
    object Cancelar: TButton
      Left = 21
      Top = 148
      Width = 116
      Height = 33
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = CancelarClick
    end
    object Excluir: TButton
      Left = 21
      Top = 210
      Width = 116
      Height = 33
      Caption = 'Excluir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = ExcluirClick
    end
    object Relatorio: TButton
      Left = 21
      Top = 272
      Width = 116
      Height = 33
      Caption = 'Relat'#243'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
  object DS: TDataSource
    OnStateChange = DSStateChange
    Left = 296
    Top = 8
  end
end
