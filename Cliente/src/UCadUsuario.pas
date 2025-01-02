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
    Usuário: TLabel;
    Senha: TLabel;
    Grupo_de_Usuario: TGroupBox;
    DBAdmin: TDBCheckBox;
    DBCBProf: TDBCheckBox;
    DBcBDiretor: TDBCheckBox;
    DBCCAluno: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure IncluirClick(Sender: TObject);
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

procedure TFCadUsuarios.IncluirClick(Sender: TObject);
begin
  inherited;
 dbNome.SetFocus;
end;

End.
