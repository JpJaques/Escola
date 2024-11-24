unit USMCadUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  USMPaiCadastro, Data.FMTBcd, Datasnap.Provider, Data.DB, Data.SqlExpr,
  ClassUsuario;

type
  TSMCadUsuario = class(TSMPaiCadastro)
  private
    { Private declarations }
  public
  protected
    procedure DSServerCreate_Filho(Sender: TObject); override;
  end;

var
  SMCadUsuario: TSMCadUsuario;

implementation

{$R *.dfm}

procedure TSMCadUsuario.DSServerCreate_Filho(Sender: TObject);
begin
  FClassefilha := TClassUsuario.Create;
  inherited;

end;

end.

