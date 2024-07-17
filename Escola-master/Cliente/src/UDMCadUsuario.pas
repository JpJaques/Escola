unit UDMCadUsuario;

interface

uses
  System.SysUtils, System.Classes, UDMPaiCadastro, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, ClassUsuario;

type
  TDMCadUsuario = class(TDMPaiCadastro)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMCadUsuario: TDMCadUsuario;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMCadUsuario.DataModuleCreate(Sender: TObject);
begin
  FClassFilha := TClassUsuario.Create;
  DSProviderConnection.ServerClassName := 'TSMUsuario';
  inherited;

end;

end.
