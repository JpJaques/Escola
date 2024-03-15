unit UFConfDatabase;

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
Vcl.ExtCtrls,
JvExExtCtrls,
JvExtComponent,
JvPanel,
Vcl.StdCtrls,
JvExStdCtrls,
JvEdit,
JvExControls,
JvSpeedButton,
JvLabel,
system.IniFiles,
UInicializacao;

type
  TFConfDatabase = class(TForm)
    pnlFundo: TJvPanel;
    edtHostname: TJvEdit;
    edtPorta: TJvEdit;
    edtCaminho: TJvEdit;
    edtUsuario: TJvEdit;
    edtSenha: TJvEdit;
    pnlMensagens: TJvPanel;
    btnConfirmar: TJvSpeedButton;
    btnTestar: TJvSpeedButton;
    btnCancelar: TJvSpeedButton;
    lblMensagem: TJvLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnTestarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    FCaminho  : string;
    FUsername : string;
    FSenha    : string;
    FMensagem : string;
    function IIF(Expressao : Variant; RetornoVerdadeiro : Variant; RetornoFalse : Variant): Variant;
  public
    procedure HabilitaMensagem;
    procedure DesabilitaMensagem;
    procedure TestaConexao;
  end;

var
  FConfDatabase: TFConfDatabase;

implementation

uses
  Data.SqlExpr;

{$R *.dfm}

{ TFConfDatabase }

procedure TFConfDatabase.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFConfDatabase.btnConfirmarClick(Sender: TObject);
var
  INI     : TIniFile;
  Arquivo : string;
begin
  FCaminho  := edtHostname.Text + '/' + edtPorta.Text + ':' + edtCaminho.Text;
  FUsername := edtUsuario.Text;
  FSenha    := edtSenha.Text;

  Arquivo   := UInicializacao.Retorna_Dir_Arq_Configuracao(tArquivo);
  INI       := TIniFile.Create(Arquivo);
  try
    if (FCaminho <> INI.ReadString('DATABASE','DATABASE','')) then
      INI.WriteString('DATABASE', 'DATABASE',FCaminho)
    else if (FUsername <> INI.ReadString('DATABASE','USERNAME','')) then
      INI.WriteString('DATABASE', 'USERNAME',FUsername)
    else if (FSenha <> INI.ReadString('DATABASE','SENHA','')) then
      INI.WriteString('DATABASE', 'SENHA',FSenha);
    Close;
  finally
    INI.Free;
  end;

end;


procedure TFConfDatabase.DesabilitaMensagem;
begin
  pnlMensagens.Visible := False;
  pnlFundo.Height      := pnlFundo.Height - pnlMensagens.Height;
  pnlMensagens.Caption := '';
end;

procedure TFConfDatabase.FormCreate(Sender: TObject);
begin
  pnlMensagens.Visible := False;
  pnlFundo.Height      := pnlFundo.Height - pnlMensagens.Height;
end;

procedure TFConfDatabase.HabilitaMensagem;
begin
  pnlMensagens.Visible  := True;
  pnlFundo.Height       := pnlFundo.Height + pnlMensagens.Height;
  lblMensagem.Font.Name := 'Segoe UI';
  lblMensagem.Font.Size := 18;
  lblMensagem.Caption   := FMensagem;
  lblMensagem.WordWrap  := True;


end;

function TFConfDatabase.IIF(Expressao, RetornoVerdadeiro,RetornoFalse: Variant): Variant;
begin
  if Expressao then
    Result := RetornoVerdadeiro
  else
    Result := RetornoFalse;
end;

procedure TFConfDatabase.btnTestarClick(Sender: TObject);
begin
  TestaConexao;
end;

procedure TFConfDatabase.TestaConexao;
var
  Conexao : TSQLConnection;
  PathComp: string;
begin
  PathComp := edtHostname.Text + '/' + edtPorta.Text + ':' + FCaminho;
  Conexao  := TSQLConnection.Create(self);
  try
    try
      Conexao.Close;
      Conexao.DriverName     := 'Firebird';
      Conexao.ConnectionName := 'FBConnection';
      Conexao.LoginPrompt    := False;
      Conexao.Params.Clear;
      Conexao.Params.Text    := UInicializacao.Retorna_Param_Conexao_Database(PathComp,edtHostname.Text,edtSenha.Text);
      Conexao.Open;

      FMensagem := PathComp + ' Conectado Com Sucesso!!';
      HabilitaMensagem;
      lblMensagem.Font.Color := clGreen;
    except
      on EX:Exception do
      begin
        FMensagem := EX.Message;
        HabilitaMensagem;
        lblMensagem.Font.Color := clRed;
      end;
    end;
   Conexao.Close;
  finally
   Conexao.Free;
  end;


end;

end.
