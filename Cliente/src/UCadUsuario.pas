unit UCadUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPaiCadastro, Vcl.DBCtrls, Data.DB,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask, JvExMask, JvToolEdit, JvBaseEdits,
  Vcl.ExtCtrls;

type
  TFCadUsuarios = class(TFPaiCadastro)
    dbNome: TDBEdit;
    dbSenha: TDBEdit;
    Usu�rio: TLabel;
    Senha: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCadUsuarios: TFCadUsuarios;

implementation

 uses
 UDMCadUsuario;


{$R *.dfm}

procedure TFCadUsuarios.FormCreate(Sender: TObject);
begin
  DMCadastro := TDMCadUsuario.Create(self);
  inherited;

end;

End.
