unit URegistraClasseServidora;

interface

uses
System.Classes,
Datasnap.DSServer,
UExpositoraClasse,
Datasnap.DSNames,
UServerMethods;

procedure RegistraClasseServidora(ADono: TComponent; AServer: TDSServer);

implementation



procedure RegistraClasseServidora(ADono: TComponent; AServer: TDSServer);
begin
  Assert(AServer.Started = false, 'Não é possível Adicionar Classe com Servidor Ativo!');
  TClassExpositoraClasseEX.Registrar(ADono, AServer, {Classe a Ser Exposta Ex: TSMCadBanco}TServerMethods,True,  TDSLifeCycle.Session);
end;

end.
