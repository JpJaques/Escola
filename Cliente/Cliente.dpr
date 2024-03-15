program Cliente;

uses
  Vcl.Forms,
  UFPrincipal in 'src\UFPrincipal.pas' {FPrincipal},
  ClientClassesUnit in 'ClientClassesUnit.pas',
  UDMConexao in 'src\UDMConexao.pas' {ClientModule: TDataModule},
  UFConfigCliente in 'src\UFConfigCliente.pas' {FConfigCliente},
  UInicializacao in 'src\UInicializacao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TClientModule, ClientModule);
  Application.CreateForm(TFConfigCliente, FConfigCliente);
  Application.Run;
end.
