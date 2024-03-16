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
UInicializacao, JvDialogs;

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
    DialogoDatabase: TJvOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure btnTestarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtCaminhoDblClick(Sender: TObject);
    procedure edtCaminhoMouseEnter(Sender: TObject);
    procedure edtCaminhoMouseLeave(Sender: TObject);
  private
    FCaminho:           string;
    FUsername:          string;
    FSenha:             string;
    FMensagem:          string;
    MensagemHabilitada: Boolean;
    function IIF(Expressao : Variant; RetornoVerdadeiro : Variant; RetornoFalse : Variant): Variant;
    procedure PainelMensagem;
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

procedure TFConfDatabase.PainelMensagem;
begin
  if MensagemHabilitada then
  begin
    Self.Height := 350;
    pnlMensagens.Height := 135;
  end
  else
  begin
    if not (Trim(lblMensagem.Caption) = '') then
      lblMensagem.Caption := '';

    pnlMensagens.Height := 0;
    Self.Height := 205;
  end;
end;

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

procedure TFConfDatabase.edtCaminhoDblClick(Sender: TObject);
begin
 DialogoDatabase.Title      := 'Selecione o banco de dados e click em Salvar.';
 DialogoDatabase.DefaultExt := '*.fdb';
 DialogoDatabase.Filter     := 'FDB|*.fdb|';

 if DialogoDatabase.Execute then
  edtCaminho.Text := DialogoDatabase.FileName;

end;

procedure TFConfDatabase.edtCaminhoMouseEnter(Sender: TObject);
begin
  edtCaminho.ShowHint := True;
end;

procedure TFConfDatabase.edtCaminhoMouseLeave(Sender: TObject);
begin
  edtCaminho.ShowHint := False;
end;

procedure TFConfDatabase.FormCreate(Sender: TObject);
var
  INI:     TIniFile;
  Arquivo: string;
begin
  Arquivo := UInicializacao.Retorna_Dir_Arq_Configuracao(tArquivo);
  INI     := TIniFile.Create(Arquivo);

  if not INI.SectionExists('DATABASE') then
  begin
   INI.WriteString('DATABASE','HOSTNAME','LOCALHOST');
   INI.WriteString('DATABASE','PORTA','3055');
   INI.WriteString('DATABASE','DATABASE',ExtractFilePath(Application.ExeName + 'CONF'));
   INI.WriteString('DATABASE','USERNAME','SYSDBA');
   INI.WriteString('DATABASE','SENHA','masterkey');
   edtHostname.Text := 'LOCALHOST';
   edtPorta.Text    := '3055';
   edtCaminho.Text  := ExtractFilePath(Application.ExeName + 'CONF');
   edtUsuario.Text  := 'SYSDBA';
   edtSenha.Text    := 'masterkey';
  end
  else
  begin
   edtHostname.Text := INI.ReadString('DATABASE','HOSTNAME','');
   edtPorta.Text    := INI.ReadString('DATABASE','PORTA','');
   edtCaminho.Text  := INI.ReadString('DATABASE','DATABASE','');
   edtUsuario.Text  := INI.ReadString('DATABASE','USERNAME','');
   edtSenha.Text    := INI.ReadString('DATABASE','SENHA','');
  end;

  MensagemHabilitada := False;
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
