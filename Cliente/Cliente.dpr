program Cliente;

uses
  Vcl.Forms,
  UFPrincipal in 'src\UFPrincipal.pas' {FPrincipal},
  ClientClassesUnit in 'ClientClassesUnit.pas',
  UDMConexao in 'src\UDMConexao.pas' {DMConexao: TDataModule},
  UFConfigCliente in 'src\UFConfigCliente.pas' {FConfigCliente},
  UInicializacao in 'src\UInicializacao.pas',
  UFLogin in 'src\UFLogin.pas' {frmLogin},
  UFSplash in 'src\UFSplash.pas' {FrmSplash},
  Vcl.Themes,
  System.SysUtils {FrmSplash};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  // Criando tela inicial Splash
  FrmSplash := TfrmSplash.Create(nil);
  FrmSplash.Show;
  FrmSplash.Update;

  FrmSplash.Passo(10,'Criando SMConexao.');

  TStyleManager.TrySetStyle('Golden Graphite');

  //Application.CreateForm(TClientModule, UDMConexao);
  Application.CreateForm(TDMConexao, DMConexao);

  FrmSplash.Passo(20,'Carregando Arquivo Conexão.');

  FrmSplash.Passo(40,'Criando Configurações.');

  FrmSplash.Passo(50,'Criando FPrincipal.');

  FrmSplash.Passo(70,'Conectando ao Banco de Dados.');

  FrmSplash.Passo(100,'Logando no sistema.');
  frmLogin := UFLogin.TfrmLogin.Create(nil);
  FreeAndNil(FrmSplash);
  frmLogin.ShowModal;

  Application.Run;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TDMConexao, DMConexao);
  Application.CreateForm(TFConfigCliente, FConfigCliente);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TFrmSplash, FrmSplash);
  Application.Run;
end.
