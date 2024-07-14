unit UServerContainer;

interface

uses
System.SysUtils,
System.Classes,
Datasnap.DSTCPServerTransport,
Datasnap.DSServer,
Datasnap.DSCommonServer,
IPPeerServer,
IPPeerAPI,
Datasnap.DSAuth,
System.IniFiles,
URegistraClasseServidora;
type
  TServerContainer = class(TDataModule)
    DSServer: TDSServer;
    DSTCPServerTransport: TDSTCPServerTransport;
    procedure DataModuleCreate(Sender: TObject);
    procedure DSTCPServerTransportConnect(Event: TDSTCPConnectEventObject);
    procedure DSTCPServerTransportDisconnect(
      Event: TDSTCPDisconnectEventObject);
  private

  public

  end;

var
  ServerContainer: TServerContainer;

implementation


{$R *.dfm}

uses
  UServerMethods, Vcl.Forms, UFPrincipal;

procedure TServerContainer.DataModuleCreate(Sender: TObject);
begin
  URegistraClasseServidora.RegistraClasseServidora(Self,DSServer);
end;


procedure TServerContainer.DSTCPServerTransportConnect(
  Event: TDSTCPConnectEventObject);
begin

  FPrincipal.Conexao.RegistraConexao(Event);
end;

procedure TServerContainer.DSTCPServerTransportDisconnect(
  Event: TDSTCPDisconnectEventObject);
begin
  FPrincipal.Conexao.RemoveConexao;
end;

end.

