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
  UFSplash in 'UFSplash.pas' {FrmSplash},
  Vcl.Dialogs,
  System.SysUtils {FrmSplash},
  UFLogin in 'UFLogin.pas' {frmLogin},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  // Criando tela inicial Splash
  FrmSplash := TfrmSplash.Create(nil);
  FrmSplash.Show;
  FrmSplash.Update;

  FrmSplash.Passo(10,'Criando SMConexao.');
  TStyleManager.TrySetStyle('Golden Graphite');
  Application.CreateForm(TSMConexao, SMConexao);
  FrmSplash.Passo(20,'Carregando Arquivo Conexão.');
  SMConexao.Conexao;

  FrmSplash.Passo(40,'Criando Configurações.');

  FrmSplash.Passo(50,'Criando FPrincipal.');

  FrmSplash.Passo(70,'Conectando ao Banco de Dados.');

  FrmSplash.Passo(100,'Logando no sistema.');
  frmLogin := UFLogin.TfrmLogin.Create(nil);
  FreeAndNil(FrmSplash);
  frmLogin.ShowModal;

  Application.Run;

end.
