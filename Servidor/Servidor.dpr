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
  Vcl.Dialogs,
  System.SysUtils {FrmSplash},
  Vcl.Themes,
  Vcl.Styles,
  UCelio in 'src\UCelio.pas',
  ClassPaiCadastro in '..\Cliente\Classes\ClassPaiCadastro.pas',
  ClassUsuario in '..\Cliente\Classes\ClassUsuario.pas',
  USMPaiCadastro in 'src\USMPaiCadastro.pas' {SMPaiCadastro: TDSServerModule},
  USMCadUsuario in 'src\USMCadUsuario.pas' {SMCadUsuario: TDSServerModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
 // Application.CreateForm(TSMCadUsuario, SMCadUsuario);
  Application.CreateForm(TSMConexao, SMConexao);
  SMConexao.Conexao;

  Application.Run;

end.
