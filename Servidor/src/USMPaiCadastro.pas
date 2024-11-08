unit USMPaiCadastro;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, Data.FMTBcd, Datasnap.Provider, Data.DB, Data.SqlExpr,
    System.StrUtils, ClassPaiCadastro, USMConexao;

type
  TSMPaiCadastro = class(TDSServerModule)
    SQLDSCadastro: TSQLDataSet;
    DSPCadastro: TDataSetProvider;
    procedure DSServerModuleCreate(Sender: TObject);
  private

  public
    FClassefilha: fClassPaiCadastro;
    protected
      procedure DSServerCreate_Filho(Sender: TObject); Virtual;
  end;

implementation


{$R *.dfm}


procedure TSMPaiCadastro.DSServerCreate_Filho(Sender: TObject);
begin
  SQLDSCadastro.SQLConnection :=  SMConexao.Conexao;
  SQLDSCadastro.Close;
  SQLDSCadastro.CommandText := FClassefilha.SqlCadastro;
  FClassefilha.CriarParametro(SQLDSCadastro);
  SQLDSCadastro.Params.CreateParam(ftInteger,'COD',ptInput);
  SQLDSCadastro.Open;
end;

procedure TSMPaiCadastro.DSServerModuleCreate(Sender: TObject);
begin
  DSServerCreate_Filho(Sender);
end;

end.

