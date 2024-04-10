object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  ClientHeight = 350
  ClientWidth = 675
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 328
    Top = 184
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
      end
    end
  end
end
