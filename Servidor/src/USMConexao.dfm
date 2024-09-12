object SMConexao: TSMConexao
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  OnDestroy = DSServerModuleDestroy
  Height = 239
  Width = 311
  object SQLDS: TSQLDataSet
    Params = <>
    Left = 48
    Top = 32
  end
  object DSP: TDataSetProvider
    Left = 120
    Top = 32
  end
end
