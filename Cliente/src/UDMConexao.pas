unit UDMConexao;

interface

uses
  System.SysUtils, System.Classes, ClientClassesUnit, Data.DBXDataSnap,
  Data.DBXCommon, IPPeerClient, Data.DB, Data.SqlExpr, Data.FMTBcd,
  Datasnap.Provider;

type
  TDMConexao = class(TDataModule)
    SQLConnection: TSQLConnection;
    dspConexao: TDataSetProvider;
    sqldsConexao: TSQLDataSet;
  private
    FInstanceOwner: Boolean;
    FServerMethodsClient: TServerMethodsClient;
    function GetServerMethodsClient: TServerMethodsClient;
    { Private declarations }
  public
    function ExecuteScala(SQL:String): Variant;
    function ExecuteReader(SQL: String): OleVariant;
    function Logar(pLogin, pSenha: String): Boolean;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property ServerMethodsClient: TServerMethodsClient read GetServerMethodsClient write FServerMethodsClient;

end;

var
  DMConexao: TDMConexao;

implementation

uses
  Datasnap.DBClient;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TDMConexao.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TDMConexao.Destroy;
begin
  FServerMethodsClient.Free;
  inherited;
end;

function TDMConexao.ExecuteReader(SQL: String): OleVariant;
begin
  sqldsConexao.Close;
  sqldsConexao.CommandText := SQL;

  Result := dspConexao.Data;
end;

function TDMConexao.ExecuteScala(SQL: String): Variant;
begin
   sqldsConexao.Close;
   sqldsConexao.CommandText := SQL;
   sqldsConexao.Open;

   case sqldsConexao.Fields[0].DataType of
     ftString:
       Result := sqldsConexao.Fields[0].AsString;
     ftInteger:
       Result := sqldsConexao.Fields[0].AsInteger;
     ftLargeint:
       Result := sqldsConexao.Fields[0].AsLargeInt;
     ftMemo:
       Result := sqldsConexao.Fields[0].AsString;
     else
       raise Exception.Create('Tipo ' + IntToStr(Ord(sqldsConexao.Fields[0].DataType)) + 'não definido');
   end;
end;

function TDMConexao.GetServerMethodsClient: TServerMethodsClient;
begin
  if FServerMethodsClient = nil then
  begin
    SQLConnection.Open;
    FServerMethodsClient:= TServerMethodsClient.Create(SQLConnection.DBXConnection, FInstanceOwner);
  end;
  Result := FServerMethodsClient;
end;

function TDMConexao.Logar(pLogin, pSenha: String): Boolean;
var
  SQL: String;
  CDS: TClientDataSet;
begin
  CDS := TClientDataSet.Create(nil);

  SQL :=
      'select' + #13 +
      '   USUARIO.COD_USUARIO,'        + #13 +
      '   USUARIO.NOME_USUARIO,'      + #13 +
      '   USUARIO.SENHA_USUARIO'      + #13 +
      'from USUARIO'                  + #13 +
      'where USUARIO.NOME_USUARIO = ' + QuotedStr(pLogin) + #13 +
      '  and USUARIO.SENHA_USUARIO = ' + QuotedStr(pSenha);

  CDS.Data := ExecuteReader(SQL);

  try
    if CDS.RecordCount > 0 then
      Result := True
    else
      raise Exception.Create('Login ou Senha Inválidos.');
  finally
     FreeAndNil(CDS);
  end;
end;

end.
