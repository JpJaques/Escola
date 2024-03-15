unit UExpositoraClasse;

interface

uses
Datasnap.DSCommonServer,
Datasnap.DSServer,
System.Classes,
Datasnap.DSReflect,
Datasnap.DataBkr,
Datasnap.DSProviderDataModuleAdapter;

  type
    TClassExpositoraClasseEX = Class
      class procedure Registrar(Dono : TComponent; ServidorDataSnap: TDSCustomServer;
              ClasseExposta : TPersistentClass; NecessitaExporProvider : Boolean; CicloDeVida : String);


    end;

  type
  TClassExpositoraClasse = class(TDSServerClass)
  private
    FClasseExposta: TPersistentClass;
    FNecessitaExporProvider : Boolean;
  protected
    function GetDSClass: TDSClass; override;
  public
    constructor Create(AOwner: TComponent; AServer: TDSCustomServer; AClass: TPersistentClass; NecessitaExporProvider : Boolean; ALifeCycle: String); reintroduce; overload;
  end;

implementation


constructor TClassExpositoraClasse.Create(AOwner: TComponent; AServer: TDSCustomServer; AClass: TPersistentClass;
                                          NecessitaExporProvider : Boolean; ALifeCycle: String);

begin
  inherited Create(AOwner);
  FClasseExposta := AClass;
  Self.Server := AServer;
  FNecessitaExporProvider := NecessitaExporProvider;
  Self.LifeCycle := ALifeCycle;
end;

function TClassExpositoraClasse.GetDSClass: TDSClass;
var
  isAdapted : Boolean;
begin
  //Verificando se é derivado de um TDSProviderDataModule
  isAdapted := FClasseExposta.InheritsFrom(TProviderDataModule);

  Result := TDSClass.Create(FClasseExposta, isAdapted);

  if FNecessitaExporProvider and isAdapted then
    Result := TDSClass.Create(TDSProviderDataModuleAdapter, Result);

end;


{ TClassExpositoraClasseEX }

class procedure TClassExpositoraClasseEX.Registrar(Dono: TComponent;
  ServidorDataSnap: TDSCustomServer; ClasseExposta: TPersistentClass;
  NecessitaExporProvider: Boolean; CicloDeVida: String);
begin
  TClassExpositoraClasse.Create(Dono,ServidorDataSnap,ClasseExposta,NecessitaExporProvider,CicloDeVida);
end;

end.
