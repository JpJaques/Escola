program Servidor;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  UFPrincipal in 'src\UFPrincipal.pas' {FPrincipal},
  UServerMethods in 'src\UServerMethods.pas' {ServerMethods: TDSServerModule},
  UServerContainer in 'src\UServerContainer.pas' {ServerContainer: TDataModule},
  UConfiguracaoServidor in 'src\UConfiguracaoServidor.pas' {FConfigServidor},
  URegistraClasseServidora in 'src\URegistraClasseServidora.pas',
  UExpositoraClasse in 'src\UExpositoraClasse.pas',
  USMConexao in 'src\USMConexao.pas' {SMConexao: TDSServerModule},
  UFConfDatabase in 'src\UFConfDatabase.pas' {FConfDatabase},
  UInicializacao in 'src\UInicializacao.pas',
  UMensagens in 'src\UMensagens.pas',
  UResourses in 'src\UResourses.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.

