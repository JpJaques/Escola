unit USMConexao;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  Datasnap.DSProviderDataModuleAdapter, System.Generics.Collections, Data.DB,
  Data.SqlExpr, Winapi.Windows, UFConfDatabase, Vcl.Forms, Data.DBXFirebird,
  UInicializacao, Datasnap.DBClient, Datasnap.DSTCPServerTransport, Data.FMTBcd,
  Datasnap.Provider;

type
  TSMConexao = class(TDSServerModule)
    SQLDS: TSQLDataSet;
    DSP: TDataSetProvider;
    procedure DSServerModuleCreate(Sender: TObject);
    procedure DSServerModuleDestroy(Sender: TObject);
    function ExecuteScalar(SQL: string): Variant;
    function ExecuteReader(SQL: string): OleVariant;
    function GerarCodigo(NomeGenerator: string): integer;
  private
    FControleConexao: TDictionary<Integer, TSQLConnection>;
    function GetConection: TSQLConnection;

  public
    CDSConexao: TClientDataSet;
    property Conexao: TSQLConnection read GetConection;
    procedure CriaCDSMonitorarConexoes;
    procedure RegistraConexao(Conexao: TDSTCPConnectEventObject);
    procedure RemoveConexao;

  end;

var
  SMConexao: TSMConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


{ TSMConexao }

procedure TSMConexao.DSServerModuleCreate(Sender: TObject);
begin
  FControleConexao := TDictionary<Integer, TSQLConnection>.Create();
  CDSConexao := TClientDataSet.Create(self);
  CriaCDSMonitorarConexoes;
  SQLDS.SQLConnection:= Conexao;
  DSP.Dataset:= SQLDS;
end;

procedure TSMConexao.DSServerModuleDestroy(Sender: TObject);
begin
  CDSConexao.Free;
end;

function TSMConexao.ExecuteReader(SQL: string): OleVariant;
begin
 SQLDS.Close;
 SQLDS.CommandText:= SQL;
 SQLDS.Open;
 Result:= DSP.Data;
end;

function TSMConexao.ExecuteScalar(SQL: string): Variant;
begin
 SQLDS.Close;
 SQLDS.CommandText:=SQL;
 SQLDS.Open;
 Result:= SQLDS.Fields[0].AsVariant;
end;

function TSMConexao.GerarCodigo(NomeGenerator: string): integer;
begin
 Result := ExecuteScalar('SELECT GEN_ID ('+ NomeGenerator +',1) FROM RDB$DATABASE');
end;

function TSMConexao.GetConection: TSQLConnection;
var
  Con: TSQLConnection;
begin
  if FControleConexao.ContainsKey(GetCurrentThreadId) then
    Result := FControleConexao.Items[GetCurrentThreadId]
  else
  begin
    Con := TSQLConnection.Create(nil);
    Con.DriverName := 'Firebird';
    Con.ConnectionName := 'FBConnection';
    Con.LoginPrompt := False;
    Con.Params.Clear;
    Con.Params.Text := UInicializacao.Retorna_Param_Conexao_Database();

    FControleConexao.Add(GetCurrentThreadId, Con);
    Result := Con;

  end;
end;

procedure TSMConexao.CriaCDSMonitorarConexoes;
begin
  with CDSConexao do
  begin
    Close;
    Fields.Clear;
    FieldDefs.Add('ID', ftInteger, 0, False);
    FieldDefs.Add('IP', ftString, 15, False);
    FieldDefs.Add('MODULO', ftString, 30, False);
    CreateDataSet;
    LogChanges := False;
    IndexFieldNames := 'ID';
  end;
end;

procedure TSMConexao.RegistraConexao(Conexao: TDSTCPConnectEventObject);
begin
  if CDSConexao.IsEmpty then
    CDSConexao.Insert
  else
    CDSConexao.Append;

  CDSConexao.FieldByName('IP').AsString := Conexao.Channel.ChannelInfo.ClientInfo.IpAddress;
  CDSConexao.FieldByName('ID').AsInteger := GetCurrentThreadId;
  CDSConexao.Post;
end;

procedure TSMConexao.RemoveConexao;
begin
  if FControleConexao.ContainsKey(GetCurrentThreadId) then
  begin
    FControleConexao.Items[GetCurrentThreadId].Close;
    FControleConexao.Remove(GetCurrentThreadId);

    if CDSConexao.FindKey([GetCurrentThreadId]) then
      CDSConexao.Delete;

    CDSConexao.Post;
  end;

end;

end.

