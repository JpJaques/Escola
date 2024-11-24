object FManutencaoDatabase: TFManutencaoDatabase
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 663
  ClientWidth = 1097
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlGeral: TPanel
    Left = 0
    Top = 0
    Width = 1097
    Height = 663
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object pnlTopo: TPanel
      Left = 0
      Top = 0
      Width = 1097
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Servi'#231'os Database'
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      OnMouseDown = pnlTopoMouseDown
      object btnFechar: TSpeedButton
        AlignWithMargins = True
        Left = 1068
        Top = 3
        Width = 23
        Height = 33
        Margins.Right = 6
        Margins.Bottom = 5
        Align = alRight
        Caption = 'X'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -35
        Font.Name = 'Segoe UI'
        Font.Orientation = -1
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnFecharClick
        ExplicitLeft = 1071
        ExplicitTop = 4
        ExplicitHeight = 35
      end
    end
    object pnlOpcoes: TPanel
      Left = 0
      Top = 41
      Width = 1097
      Height = 96
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object lblOrigem: TLabel
        Left = 24
        Top = 2
        Width = 40
        Height = 13
        Caption = 'ORIGEM'
      end
      object lblTarget: TLabel
        Left = 24
        Top = 45
        Width = 39
        Height = 13
        Caption = 'TARGET'
      end
      object Linha: TPanel
        Left = 0
        Top = 95
        Width = 1097
        Height = 1
        Align = alBottom
        BevelOuter = bvNone
        Color = clBackground
        ParentBackground = False
        TabOrder = 0
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1
        Height = 95
        Align = alLeft
        BevelOuter = bvNone
        Color = clBackground
        ParentBackground = False
        TabOrder = 1
      end
      object Panel2: TPanel
        Left = 1096
        Top = 0
        Width = 1
        Height = 95
        Align = alRight
        BevelOuter = bvNone
        Color = clBackground
        ParentBackground = False
        TabOrder = 2
      end
      object edtOrigem: TEdit
        Left = 24
        Top = 15
        Width = 633
        Height = 21
        TabOrder = 3
      end
      object edtTarget: TEdit
        Left = 24
        Top = 61
        Width = 633
        Height = 21
        TabOrder = 4
      end
      object btnComparar: TButton
        Left = 672
        Top = 63
        Width = 121
        Height = 26
        Caption = 'Comparar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = btnCompararClick
      end
      object btnExtrair: TButton
        Left = 672
        Top = 6
        Width = 121
        Height = 25
        Caption = 'Extrair'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = btnExtrairClick
      end
      object gbExtracao: TGroupBox
        Left = 799
        Top = 6
        Width = 123
        Height = 68
        Caption = 'Op'#231#245'es Extra'#231#227'o'
        TabOrder = 7
        object cbSalvarArq: TCheckBox
          Left = 3
          Top = 13
          Width = 118
          Height = 17
          Caption = 'Salvar Arquivo .SQL'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object cbMostraLogExt: TCheckBox
          Left = 3
          Top = 30
          Width = 118
          Height = 17
          Caption = 'Mostrar Log'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object cbMostraScriptExt: TCheckBox
          Left = 3
          Top = 48
          Width = 118
          Height = 17
          Caption = 'Mostrar Script'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
      end
      object btnCriarBancoOrigem: TButton
        Left = 672
        Top = 33
        Width = 121
        Height = 26
        Caption = 'Criar Banco Origem'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        OnClick = btnCriarBancoOrigemClick
      end
      object GroupBox1: TGroupBox
        Left = 943
        Top = 6
        Width = 130
        Height = 38
        Caption = 'Op'#231#245'es Banco Origem'
        TabOrder = 9
        object cbExecutaScript: TCheckBox
          Left = 3
          Top = 13
          Width = 118
          Height = 17
          Caption = 'Excecutar Script .SQL'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
      end
      object GroupBox2: TGroupBox
        Left = 943
        Top = 44
        Width = 130
        Height = 50
        Caption = 'Op'#231#245'es Compara'#231#227'o'
        TabOrder = 10
        object cbExecutaScriptComparacao: TCheckBox
          Left = 3
          Top = 13
          Width = 118
          Height = 17
          Caption = 'Excecutar Script'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object cbSalvarScriptComparacao: TCheckBox
          Left = 3
          Top = 28
          Width = 118
          Height = 17
          Caption = 'Salvar Script'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 137
      Width = 1097
      Height = 526
      Align = alClient
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object Label1: TLabel
        Left = 1
        Top = 227
        Width = 1095
        Height = 29
        Align = alClient
        Alignment = taCenter
        Caption = 'Script'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitTop = 233
        ExplicitWidth = 33
        ExplicitHeight = 16
      end
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 1097
        Height = 16
        Align = alTop
        Alignment = taCenter
        Caption = 'Log'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 20
      end
      object Panel5: TPanel
        Left = 0
        Top = 227
        Width = 1
        Height = 29
        Align = alLeft
        BevelOuter = bvNone
        Color = clBackground
        ParentBackground = False
        TabOrder = 0
      end
      object Panel6: TPanel
        Left = 1096
        Top = 227
        Width = 1
        Height = 29
        Align = alRight
        BevelOuter = bvNone
        Color = clBackground
        ParentBackground = False
        TabOrder = 1
      end
      object mmScript: TMemo
        Left = 0
        Top = 257
        Width = 1097
        Height = 269
        Align = alBottom
        BevelInner = bvNone
        BevelOuter = bvNone
        TabOrder = 2
      end
      object mmLog: TMemo
        Left = 0
        Top = 16
        Width = 1097
        Height = 211
        Align = alTop
        TabOrder = 3
      end
      object Panel4: TPanel
        Left = 0
        Top = 256
        Width = 1097
        Height = 1
        Align = alBottom
        BevelOuter = bvNone
        Color = clBackground
        ParentBackground = False
        TabOrder = 4
      end
    end
  end
  object OpenDialog: TOpenDialog
    Left = 888
    Top = 8
  end
  object DBComparer: TDBComparer
    DBStructureMaster = DBStructureOrigem
    DBStructureTarget = DBStructureTarget
    ExtractorMaster = ExtractOrigem
    ExtractorTarget = ExtractTarget
    OnLogNextLine = DBComparerLogNextLine
    OnBeforeExtract = DBComparerBeforeExtract
    OnBeforeExtractTarget = DBComparerBeforeExtractTarget
    OnAfterExtractTarget = DBComparerAfterExtractTarget
    OnBeforeExtractMaster = DBComparerBeforeExtractMaster
    OnAfterExtractMaster = DBComparerAfterExtractMaster
    Left = 664
    Top = 376
  end
  object DBStructureOrigem: TDBStructure
    IBServerOptions.SQLServerVersion = st_Firebird_40
    MSSQLServerOptions.SQLServerVersion = st_MSSQL2000
    PGSQLServerOptions.SQLServerVersion = st_PostgreSQL_8x
    Left = 720
    Top = 256
  end
  object DBStructureTarget: TDBStructure
    IBServerOptions.SQLServerVersion = st_Firebird_40
    MSSQLServerOptions.SQLServerVersion = st_MSSQL2000
    PGSQLServerOptions.SQLServerVersion = st_PostgreSQL_8x
    Left = 600
    Top = 264
  end
  object DBCConnectionDBXOrigem: TDBCConnectionDBX
    Database = SQLConnectionOrigem
    Left = 720
    Top = 208
  end
  object SQLConnectionOrigem: TSQLConnection
    ConnectionName = 'FBConnection'
    DriverName = 'Firebird'
    KeepConnection = False
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      'Database=database.fdb'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'IsolationLevel=ReadCommitted'
      'Trim Char=False')
    BeforeConnect = SQLConnectionOrigemBeforeConnect
    Left = 720
    Top = 152
  end
  object SQLConnectionTarget: TSQLConnection
    ConnectionName = 'FBConnection'
    DriverName = 'Firebird'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      'Database=database.fdb'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'IsolationLevel=ReadCommitted'
      'Trim Char=False')
    BeforeConnect = SQLConnectionTargetBeforeConnect
    Left = 600
    Top = 152
  end
  object DBCConnectionDBXTarget: TDBCConnectionDBX
    Database = SQLConnectionTarget
    Left = 600
    Top = 208
  end
  object IBDBExtract: TIBDBExtract
    DBCConnection = DBCConnectionDBXTarget
    DBStructure = DBStructureTarget
    OnLogNextLine = IBDBExtractLogNextLine
    Left = 904
    Top = 160
  end
  object ExtractTarget: TIBDBExtract
    DBCConnection = DBCConnectionDBXTarget
    DBStructure = DBStructureTarget
    OnLogNextLine = ExtractTargetLogNextLine
    Left = 600
    Top = 320
  end
  object ExtractOrigem: TIBDBExtract
    DBCConnection = DBCConnectionDBXOrigem
    DBStructure = DBStructureOrigem
    OnLogNextLine = ExtractOrigemLogNextLine
    Left = 728
    Top = 320
  end
end
