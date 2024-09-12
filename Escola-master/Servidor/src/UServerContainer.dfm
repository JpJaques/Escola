object ServerContainer: TServerContainer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 271
  Width = 415
  object DSServer: TDSServer
    AutoStart = False
    Left = 96
    Top = 11
  end
  object DSTCPServerTransport: TDSTCPServerTransport
    Port = 1327
    Server = DSServer
    Filters = <>
    OnConnect = DSTCPServerTransportConnect
    OnDisconnect = DSTCPServerTransportDisconnect
    Left = 96
    Top = 73
  end
end
