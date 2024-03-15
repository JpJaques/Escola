unit UDMConexao;

interface

uses
  System.SysUtils, System.Classes, ClientClassesUnit, Data.DBXDataSnap,
  Data.DBXCommon, IPPeerClient, Data.DB, Data.SqlExpr;

type
  TClientModule = class(TDataModule)
    SQLConnection: TSQLConnection;
  private
    FInstanceOwner: Boolean;
    FServerMethodsClient: TServerMethodsClient;
    function GetServerMethodsClient: TServerMethodsClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property ServerMethodsClient: TServerMethodsClient read GetServerMethodsClient write FServerMethodsClient;

end;

var
  ClientModule: TClientModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TClientModule.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TClientModule.Destroy;
begin
  FServerMethodsClient.Free;
  inherited;
end;

function TClientModule.GetServerMethodsClient: TServerMethodsClient;
begin
  if FServerMethodsClient = nil then
  begin
    SQLConnection.Open;
    FServerMethodsClient:= TServerMethodsClient.Create(SQLConnection.DBXConnection, FInstanceOwner);
  end;
  Result := FServerMethodsClient;
end;

end.
