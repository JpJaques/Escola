unit USMConexao;

interface

uses
System.SysUtils,
System.Classes,
Datasnap.DSServer,
Datasnap.DSAuth,
Datasnap.DSProviderDataModuleAdapter,
System.Generics.Collections,
Data.DB,
Data.SqlExpr,
Winapi.Windows,
UFConfDatabase,
Vcl.Forms,
Data.DBXFirebird,
Datasnap.DBClient,
Datasnap.DSTCPServerTransport,
Data.DBXCommon,
System.StrUtils;

type
  TSMConexao = class(TDSServerModule)
    procedure DSServerModuleCreate(Sender: TObject);
    procedure DSServerModuleDestroy(Sender: TObject);
  private
    FControleConexao : TDictionary<Integer,TSQLConnection>;
    function GetConection : TSQLConnection;
  public
    CDSConexao : TClientDataSet;
    property Conexao: TSQLConnection read GetConection;
    procedure CriaCDSMonitorarConexoes;
    procedure RegistraConexao(Conexao : TDSTCPConnectEventObject);
    procedure RemoveConexao;
    function  TestaConexao:string; overload;
    function  TestaConexao(const AUser, ASenha, ADatabase: String):string; overload;
    function  ExecuteReader(ASQL: String; CriarTransacao : Boolean = True):OleVariant;
    function  ExecuteScalar(ASQL: string; CriarTransacao : Boolean = True): Variant;
    procedure ExecuteCommand(ASQL: string; AParam: TParams = nil; CriarTransacao: Boolean = True);
  end;

implementation
  uses
    UConfigDatabase;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


{ TSMConexao }

procedure TSMConexao.DSServerModuleCreate(Sender: TObject);
begin
 FControleConexao := TDictionary<Integer,TSQLConnection>.Create();
 CDSConexao       := TClientDataSet.Create(self);
 CriaCDSMonitorarConexoes;
end;

procedure TSMConexao.DSServerModuleDestroy(Sender: TObject);
begin
  CDSConexao.Free;
end;

procedure TSMConexao.ExecuteCommand(ASQL: string; AParam: TParams; CriarTransacao: Boolean);
var
  Transacao: TDBXTransaction;
begin
  if CriarTransacao then
  begin
    GetConection.HasTransaction(Transacao);
    GetConection.BeginTransaction;
  end;

  try
    GetConection.Execute(ASQL, AParam);

    if GetConection.InTransaction then GetConection.CommitFreeAndNil(Transacao);

  except on E:Exception do
    begin
      if GetConection.InTransaction then GetConection.RollbackFreeAndNil(Transacao);

      raise Exception.Create('Erro na Execução do Comando: ' + E.Message);
    end;
  end;
end;

function TSMConexao.ExecuteReader(ASQL: String;CriarTransacao: Boolean): OleVariant;
var
  Transacao: TDBXTransaction;
  LSQLDS:    TSQLDataSet;
begin
  LSQLDS := TSQLDataSet.Create(Nil);

  try
    LSQLDS.SQLConnection := GetConection;
    LSQLDS.CommandText   := ASQL;

    if CriarTransacao then
    begin
      GetConection.HasTransaction(Transacao);
      GetConection.BeginTransaction;
    end;

    try

      Result := LSQLDS.ExecSQL;

      if GetConection.InTransaction then GetConection.CommitFreeAndNil(Transacao);

    except
      on E:Exception do
      begin
        if GetConection.InTransaction then GetConection.RollbackFreeAndNil(Transacao);

        raise Exception.Create('Falha ao Executar: ' + #13 + E.Message);

      end;

    end;

  finally
    LSQLDS.Free;
  end;
end;

function TSMConexao.ExecuteScalar(ASQL: string;CriarTransacao: Boolean): Variant;
var
  Transacao: TDBXTransaction;
  LSQLDS:    TSQLDataSet;
begin
  LSQLDS := TSQLDataSet.Create(Nil);

  try
    LSQLDS.SQLConnection := GetConection;
    LSQLDS.CommandText   := ASQL;

    try
      LSQLDS.ExecSQL;

      case LSQLDS.Fields[0].DataType of
        ftString:   Result := LSQLDS.Fields[0].AsString;
        ftInteger:  Result := LSQLDS.Fields[0].AsInteger;
        ftLargeint: Result := LSQLDS.Fields[0].AsLargeInt;
        ftCurrency: Result := LSQLDS.Fields[0].AsCurrency;
        ftDateTime: Result := LSQLDS.Fields[0].AsDateTime;
        ftBoolean:  Result := LSQLDS.Fields[0].AsBoolean;
      else
        Result := LSQLDS.Fields[0].AsVariant;
      end;

      if GetConection.InTransaction then GetConection.CommitFreeAndNil(Transacao);

    except on E:Exception do
      begin
        if GetConection.InTransaction then GetConection.RollbackFreeAndNil(Transacao);

        raise Exception.Create('Erro ao Executar: ' + #13 + E.Message);
      end;
    end;


  finally
    LSQLDS.Free;
  end;
end;

function TSMConexao.GetConection: TSQLConnection;
var
  Con : TSQLConnection;
  DBParamConfig : TConfigDatabase;
begin
  if FControleConexao.ContainsKey(GetCurrentThreadId) then
    Result := FControleConexao.Items[GetCurrentThreadId]
  else
  begin
    Con                := TSQLConnection.Create(nil);
    DBParamConfig      := TConfigDatabase.Create(self);

    Con.DriverName     := 'Firebird';
    Con.ConnectionName := 'FBConnection';
    Con.LoginPrompt    := False;

    Con.Params.Clear;
    Con.Params.Text    := DBParamConfig.GetParams;

    FControleConexao.Add(GetCurrentThreadId,Con);
    Result := Con;

    DBParamConfig.Free;
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
    LogChanges      := False;
    IndexFieldNames := 'ID';
  end;
end;

procedure TSMConexao.RegistraConexao(Conexao : TDSTCPConnectEventObject);
begin
  if CDSConexao.IsEmpty then
    CDSConexao.Insert
  else
    CDSConexao.Append;

  CDSConexao.FieldByName('IP').AsString  := Conexao.Channel.ChannelInfo.ClientInfo.IpAddress;
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

function TSMConexao.TestaConexao(const AUser, ASenha,ADatabase: String): string;
  var
  Con : TSQLConnection;
  DBParamConfig : TConfigDatabase;
begin
  try

    Con                := TSQLConnection.Create(nil);
    DBParamConfig      := TConfigDatabase.Create(self);

    Con.DriverName     := 'Firebird';
    Con.ConnectionName := 'FBConnection';
    Con.LoginPrompt    := False;

    Con.Params.Clear;
    Con.Params.Text    := DBParamConfig.GetParams(AUser,ASenha,ADatabase);

    try
      Con.Open;
      Result := '';
      Con.Close;
    except
      on E: Exception do
      begin
        Result := E.Message;
      end;
    end;

  finally
    DBParamConfig.Free;
    Con.Free;
  end;

end;

function TSMConexao.TestaConexao: string;
var
  Con : TSQLConnection;
  DBParamConfig : TConfigDatabase;
begin
  try

    Con                := TSQLConnection.Create(nil);
    DBParamConfig      := TConfigDatabase.Create(self);

    Con.DriverName     := 'Firebird';
    Con.ConnectionName := 'FBConnection';
    Con.LoginPrompt    := False;

    Con.Params.Clear;
    Con.Params.Text    := DBParamConfig.GetParams;

    try
      Con.Open;
      Result := '';
      Con.Close;
    except
      on E: Exception do
      begin
        Result := E.Message;
      end;
    end;

  finally
    DBParamConfig.Free;
    Con.Free;
  end;

end;

end.

