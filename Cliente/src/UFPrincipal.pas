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
UFConfigCliente;

type
  TFPrincipal = class(TForm)
    procedure FormCreate(Sender: TObject);
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
