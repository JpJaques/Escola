inherited FCadUsuarios: TFCadUsuarios
  Caption = 'Cadastro de Usu'#225'rios'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelPai: TPanel
    ExplicitWidth = 632
  end
  inherited PageControl1: TPageControl
    inherited TabSheet1: TTabSheet
      ExplicitTop = 24
      object Usuário: TLabel
        Left = 40
        Top = 62
        Width = 36
        Height = 13
        Caption = 'Usu'#225'rio'
      end
      object Senha: TLabel
        Left = 40
        Top = 158
        Width = 30
        Height = 13
        Caption = 'Senha'
      end
      object dbNome: TDBEdit
        Left = 40
        Top = 88
        Width = 353
        Height = 21
        TabOrder = 0
      end
      object dbSenha: TDBEdit
        Left = 40
        Top = 186
        Width = 353
        Height = 21
        TabOrder = 1
      end
    end
  end
  inherited Panel2: TPanel
    Caption = ''
  end
end
