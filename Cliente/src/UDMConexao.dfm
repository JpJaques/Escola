object DMConexao: TDMConexao
  OldCreateOrder = False
  Height = 271
  Width = 415
  object SQLConnection: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'Port=1327'
      'HostName=localhost'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/')
    Left = 48
    Top = 40
  end
  object dspConexao: TDataSetProvider
    Left = 126
    Top = 40
  end
  object sqldsConexao: TSQLDataSet
    Params = <>
    Left = 205
    Top = 40
  end
end
