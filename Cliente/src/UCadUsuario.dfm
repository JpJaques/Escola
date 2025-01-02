inherited FCadUsuarios: TFCadUsuarios
  Caption = 'Cadastro de Usu'#225'rios'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    inherited TabSheet1: TTabSheet
      object Usuário: TLabel
        Left = 40
        Top = 62
        Width = 36
        Height = 13
        Caption = 'Usu'#225'rio'
      end
      object Senha: TLabel
        Left = 40
        Top = 135
        Width = 30
        Height = 13
        Caption = 'Senha'
      end
      object dbNome: TDBEdit
        Left = 40
        Top = 81
        Width = 353
        Height = 21
        CharCase = ecUpperCase
        DataField = 'NOME_USUARIO'
        DataSource = DS
        TabOrder = 0
      end
      object dbSenha: TDBEdit
        Left = 40
        Top = 154
        Width = 353
        Height = 21
        DataField = 'SENHA_USUARIO'
        DataSource = DS
        PasswordChar = '*'
        TabOrder = 1
      end
      object Grupo_de_Usuario: TGroupBox
        Left = 40
        Top = 197
        Width = 353
        Height = 110
        Caption = 'Tipo de Usu'#225'rio'
        Color = clSkyBlue
        ParentBackground = False
        ParentColor = False
        TabOrder = 2
        object DBAdmin: TDBCheckBox
          Left = 12
          Top = 33
          Width = 97
          Height = 17
          Caption = 'Administrador'
          DataField = 'ADMINISTRADOR'
          DataSource = DS
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object DBCBProf: TDBCheckBox
          Left = 12
          Top = 73
          Width = 97
          Height = 17
          Caption = 'Professor'
          DataField = 'PROFESSOR'
          DataSource = DS
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object DBcBDiretor: TDBCheckBox
          Left = 148
          Top = 33
          Width = 97
          Height = 17
          Caption = 'Diretor'
          DataField = 'DIRETOR'
          DataSource = DS
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object DBCCAluno: TDBCheckBox
          Left = 148
          Top = 73
          Width = 97
          Height = 17
          Caption = 'Aluno'
          DataField = 'ALUNO'
          DataSource = DS
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
    end
  end
  inherited Panel2: TPanel
    Caption = ''
    Color = clActiveCaption
  end
end
