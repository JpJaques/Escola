unit UFPrincipal;

interface

uses
Winapi.Windows,
Winapi.Messages,
System.SysUtils,
System.Variants,
System.Classes,
Vcl.Graphics,
Vcl.Controls,
Vcl.Forms,
Vcl.Dialogs,
UDMConexao,
UInicializacao,
UFConfigCliente, Vcl.Menus, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TFPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    CAdastro1: TMenuItem;
    Manuteno1: TMenuItem;
    Utilitarios1: TMenuItem;
    Usurio1: TMenuItem;
    img1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure img1Click(Sender: TObject);
  private
    { Private declarations }
    procedure Inicializar;
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  Inicializar;
end;

procedure TFPrincipal.img1Click(Sender: TObject);
begin

end;

procedure TFPrincipal.Inicializar;
var
  MensagemRetorno : string;
  FConfigConexao  : TFConfigCliente;
begin
  ClientModule    := TClientModule.Create(Self);
  MensagemRetorno := UInicializacao.RealizaConexao;
  if not (Trim(MensagemRetorno) = '') then
  begin
    if (MessageDlg(MensagemRetorno+#13+'Deseja Abrir Realizar Configuração?',
       mtError,[mbOK, mbNo],0)= mrOk) then
    begin
      FConfigConexao := TFConfigCliente.Create(nil);
      FConfigConexao.ShowModal;
      Inicializar;
    end
    else
      Application.Terminate;

  end;

end;

end.
