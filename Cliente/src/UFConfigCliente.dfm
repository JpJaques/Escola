object FConfigCliente: TFConfigCliente
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 186
  ClientWidth = 458
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlGeral: TJvPanel
    Left = 0
    Top = 0
    Width = 458
    Height = 186
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = 8
    ExplicitHeight = 401
    object btnGravar: TJvSpeedButton
      Left = 232
      Top = 121
      Width = 105
      Height = 40
      Caption = 'Gravar'
      OnClick = btnGravarClick
    end
    object btnCancelar: TJvSpeedButton
      Left = 64
      Top = 121
      Width = 105
      Height = 40
      Caption = 'Cancelar'
      OnClick = btnCancelarClick
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 454
      Height = 33
      Align = alTop
      Caption = 'Configura'#231#227'o Servidor'
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
    end
    object VlServer: TValueListEditor
      Left = 0
      Top = 33
      Width = 454
      Height = 64
      Align = alTop
      BorderStyle = bsNone
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goThumbTracking]
      TabOrder = 1
      ColWidths = (
        150
        302)
    end
  end
end
