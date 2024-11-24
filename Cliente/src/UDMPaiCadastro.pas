unit UDMPaiCadastro;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, Datasnap.DSConnect, UDmConexao, ClassPaiCadastro;

type
  TDMPaiCadastro = class(TDataModule)
    CDSCadastro: TClientDataSet;
    DSProviderConnection: TDSProviderConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure CDSCadastroBeforeOpen(DataSet: TDataSet);
  private
    FCodigoAtual: Integer;
  public
    FClassFilha: TClassPaiCadastro;
    //property CodigoAtual: Integer read FCodigoAtual write FCodigoAtual;//VERIFICAR O MOTIVO COM JOAO
    procedure AbrirRegistro(codigo:Integer);
    procedure ProximoCodigo;
    procedure Anterior;
    procedure UltimoCOdigo;
    procedure Primeiro;
    Property CodigoAtual: Integer read FCodigoAtual;
  end;

var
  DMPaiCadastro: TDMPaiCadastro;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMPaiCadastro.AbrirRegistro(codigo: Integer);
begin
 if codigo > 0 then begin
    FcodigoAtual:= Codigo;
    CDSCadastro.Close;

    // SQLDS.ParamByName('COD').AsInteger:=codigo;
    CDSCadastro.FetchParams;
    CDSCadastro.Open;
  end;
end;

procedure TDMPaiCadastro.Anterior;
begin

end;

procedure TDMPaiCadastro.CDSCadastroBeforeOpen(DataSet: TDataSet);
var
  X: Integer;
begin
 with CDSCadastro do
  begin
    for x := 0 to Params.Count - 1 do
    begin
      if AnsiUpperCase(Params.Items[x].Name) = 'COD' then
       Params.ParamByName('COD').AsInteger := FCodigoAtual ;
    end;
  end;
end;

procedure TDMPaiCadastro.DataModuleCreate(Sender: TObject);
begin
  DSProviderConnection.SQLConnection := DmConexao.SQLConnection;
  CDSCadastro.ProviderName           := 'DSPCadastro';
  CDSCadastro.RemoteServer           := DSProviderConnection;

  CDSCadastro.FetchParams;
  CDSCadastro.Open;
end;

procedure TDMPaiCadastro.Primeiro;
begin

end;

procedure TDMPaiCadastro.ProximoCodigo;
begin

end;

procedure TDMPaiCadastro.UltimoCOdigo;
begin

end;

end.
