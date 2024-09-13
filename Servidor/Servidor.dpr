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
  ClassPaiCadastro in '..\Cliente\Classes\ClassPaiCadastro.pas',
  ClassUsuario in '..\Cliente\Classes\ClassUsuario.pas',
  USMPaiCadastro in 'src\USMPaiCadastro.pas' {SMPaiCadastro: TDSServerModule},
  USMCadUsuario in 'src\USMCadUsuario.pas' {SMCadUsuario: TDSServerModule},
  UConfigDatabase in 'src\UConfigDatabase.pas',
  UIniConfigDatabase in 'src\UIniConfigDatabase.pas',
  UMetadataDatabase in 'src\UMetadataDatabase.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;

end.
