object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  Align = alClient
  Caption = 'Menu Principal'
  ClientHeight = 350
  ClientWidth = 675
  Color = clActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PanelInferior: TPanel
    Left = 0
    Top = 0
    Width = 675
    Height = 35
    Align = alTop
    Color = clTeal
    ParentBackground = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 315
    Width = 675
    Height = 35
    Align = alBottom
    Color = clTeal
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 18
      Width = 667
      Height = 13
      Align = alBottom
      Alignment = taCenter
      Caption = 'Label1'
      ExplicitWidth = 31
    end
  end
  object MainMenu1: TMainMenu
    Left = 616
    Top = 56
    object CAdastro1: TMenuItem
      Caption = 'Cadastro'
    end
    object Manuteno1: TMenuItem
      Caption = 'Manuten'#231#227'o'
    end
    object Utilitarios1: TMenuItem
      Caption = 'Utilitarios'
      object Usurio1: TMenuItem
        Caption = 'Usu'#225'rio'
        OnClick = Usurio1Click
      end
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 32
    Top = 267
  end
end
