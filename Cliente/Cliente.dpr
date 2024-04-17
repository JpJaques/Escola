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
  ClassUsuario in 'Classes\ClassUsuario.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Sky');
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TDMConexao, DMConexao);
  Application.CreateForm(TFConfigCliente, FConfigCliente);
  Application.CreateForm(TFPaiCadastro, FPaiCadastro);
  Application.CreateForm(TFCadUsuarios, FCadUsuarios);
  Application.CreateForm(TDMPaiCadastro, DMPaiCadastro);
  Application.Run;
end.
