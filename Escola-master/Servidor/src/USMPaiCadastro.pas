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
    FClassefilha: TClassPaiCadastro;
    protected
      procedure DSServerCreate_Filho(Sender: TObject); Virtual;
  end;

implementation


{$R *.dfm}


procedure TSMPaiCadastro.DSServerCreate_Filho(Sender: TObject);
begin
  SQLDSCadastro.Close;
  SQLDSCadastro.CommandText := FClassefilha.SqlCadastro;
  FClassefilha.CriarParametro(SQLDSCadastro);
end;

procedure TSMPaiCadastro.DSServerModuleCreate(Sender: TObject);
begin
  DSServerCreate_Filho(Sender);
end;

end.

