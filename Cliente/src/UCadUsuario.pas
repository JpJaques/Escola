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
    procedure arredondar;
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

procedure TFCadUsuarios.arredondar;
var
  I: Integer;
  Rgn: HRGN;
  GroupBox: TGroupBox;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TGroupBox then
    begin
      GroupBox := TGroupBox(Components[I]);
      Rgn := CreateRoundRectRgn(0, 0, GroupBox.Width, GroupBox.Height, 20, 20); // 20 é o raio dos cantos arredondados
      SetWindowRgn(GroupBox.Handle, Rgn, True);
    end;
  end;
end;

procedure TFCadUsuarios.FormCreate(Sender: TObject);
begin
  DMCadastro := TDMCadUsuario.Create(self);
  arredondar;
  inherited;

end;

procedure TFCadUsuarios.IncluirClick(Sender: TObject);
begin
  inherited;
 dbNome.SetFocus;
end;

End.
