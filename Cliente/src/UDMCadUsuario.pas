unit UDMCadUsuario;

interface

uses
  System.SysUtils, System.Classes, UDMPaiCadastro, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect;

type
  TDMCadCidade = class(TDMPaiCadastro)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMCadCidade: TDMCadCidade;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
