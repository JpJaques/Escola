object DMPaiCadastro: TDMPaiCadastro
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 267
  Width = 305
  object CDSCadastro: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforeOpen = CDSCadastroBeforeOpen
    AfterOpen = CDSCadastroAfterOpen
    AfterPost = CDSCadastroAfterPost
    AfterDelete = CDSCadastroAfterDelete
    OnNewRecord = CDSCadastroNewRecord
    OnReconcileError = CDSCadastroReconcileError
    Left = 55
    Top = 175
  end
  object DSProviderConnection: TDSProviderConnection
    Left = 65
    Top = 45
  end
end
