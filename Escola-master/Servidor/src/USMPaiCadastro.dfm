object SMPaiCadastro: TSMPaiCadastro
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 232
  Width = 289
  object SQLDSCadastro: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    Left = 45
    Top = 40
  end
  object DSPCadastro: TDataSetProvider
    DataSet = SQLDSCadastro
    Left = 50
    Top = 115
  end
end
