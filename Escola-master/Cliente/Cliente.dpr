program Cliente;

uses
  Vcl.Forms,
  UFPrincipal in 'src\UFPrincipal.pas' {FPrincipal},
  ClientClassesUnit in 'ClientClassesUnit.pas',
  UDMConexao in 'src\UDMConexao.pas' {DMConexao: TDataModule},
  UFConfigCliente in 'src\UFConfigCliente.pas' {FConfigCliente},
  UInicializacao in 'src\UInicializacao.pas',
  Vcl.Themes,
  Vcl.Styles,
  UPaiCadastro in 'src\UPaiCadastro.pas' {FPaiCadastro},
  UCadUsuario in 'src\UCadUsuario.pas' {FCadUsuarios},
  UDMPaiCadastro in 'src\UDMPaiCadastro.pas' {DMPaiCadastro: TDataModule},
  ClassPaiCadastro in 'Classes\ClassPaiCadastro.pas',
  ClassUsuario in 'Classes\ClassUsuario.pas',
  UDMCadUsuario in 'src\UDMCadUsuario.pas' {DMCadUsuario: TDataModule},
  UFLogin in 'src\UFLogin.pas' {frmLogin},
  UFSplash in 'src\UFSplash.pas', System.SysUtils {FrmSplash};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  //TStyleManager.TrySetStyle('Sky');

  FrmSplash := TfrmSplash.Create(nil);
  FrmSplash.Show;
  FrmSplash.Update;

  FrmSplash.Passo(10,'Criando SMConexao.');
  //TStyleManager.TrySetStyle('Golden Graphite');

  FrmSplash.Passo(20,'Carregando Arquivo Conexão.');
  Application.CreateForm(TDMConexao, DMConexao);
  FrmSplash.Passo(40,'Criando Configurações.');

  FrmSplash.Passo(50,'Criando FPrincipal.');

  FrmSplash.Passo(70,'Conectando ao Banco de Dados.');

  FrmSplash.Passo(100,'Logando no sistema.');
  frmLogin := UFLogin.TfrmLogin.Create(nil);
  FreeAndNil(FrmSplash);
  frmLogin.ShowModal;


  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.
