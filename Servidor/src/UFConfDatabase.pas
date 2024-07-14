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
JvDialogs,
UMensagens,
UIniConfigDatabase;

type
  TFConfDatabase = class(TForm)
    pnlFundo: TJvPanel;
    edtHostname: TJvEdit;
    edtPorta: TJvEdit;
    edtCaminho: TJvEdit;
    edtUsuario: TJvEdit;
    edtSenha: TJvEdit;
    btnConfirmar: TJvSpeedButton;
    btnTestar: TJvSpeedButton;
    btnCancelar: TJvSpeedButton;
    DialogoDatabase: TJvOpenDialog;
    lblMensagem: TJvLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnTestarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtCaminhoDblClick(Sender: TObject);
    procedure edtCaminhoMouseEnter(Sender: TObject);
    procedure edtCaminhoMouseLeave(Sender: TObject);
    procedure pnlFundoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FCaminho:  string;
    FUsername: string;
    FSenha:    string;
    FMensagem: string;
    FIni:      TIniConfigDatabase;
    MensagemHabilitada: Boolean;
    function IIF(Expressao : Variant; RetornoVerdadeiro : Variant; RetornoFalse : Variant): Variant;

  public
    Function TestaConexao:String;

  end;


implementation
uses
  UFPrincipal;

{$R *.dfm}

{ TFConfDatabase }


procedure TFConfDatabase.btnCancelarClick(Sender: TObject);
begin
  FPrincipal.ConfirmaDBConf := False;
  Close;
end;

procedure TFConfDatabase.btnConfirmarClick(Sender: TObject);
var
  LCaminho: string;
begin
  FIni.SetUserName(edtUsuario.Text);
  FIni.SetPassword(edtSenha.Text);
  FIni.SetHostname(edtHostname.Text);
  FIni.SetPorta(edtPorta.Text);

  if not(Pos('/',edtCaminho.Text) > 0) then
  begin
    LCaminho := edtHostname.Text + '/' + edtPorta.Text + ':' + edtCaminho.Text;
    FIni.SetDatabase(LCaminho)
  end
  else
    FIni.SetDatabase(edtCaminho.Text);

  FPrincipal.ConfirmaDBConf := True;
  Self.Close;
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

procedure TFConfDatabase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FIni.Free;
  Action := caFree;
end;

procedure TFConfDatabase.FormCreate(Sender: TObject);
begin
// Seta a Classe de Config do Ini
  FIni := TIniConfigDatabase.Create;
end;

procedure TFConfDatabase.FormShow(Sender: TObject);
begin
  edtPorta.Text    := FIni.GetPorta;
  edtSenha.Text    := FIni.GetPassword;
  edtHostname.Text := FIni.GetHostname;
  edtUsuario.Text  := FIni.GetUserName;
  edtCaminho.Text  := FIni.GetDatabase;
end;

function TFConfDatabase.IIF(Expressao, RetornoVerdadeiro,RetornoFalse: Variant): Variant;
begin
  if Expressao then
    Result := RetornoVerdadeiro
  else
    Result := RetornoFalse;
end;

procedure TFConfDatabase.pnlFundoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Screen.Cursor := crSizeAll;
  ReleaseCapture;
  Self.Perform(wm_nclbuttondown,HTCAPTION,0);
  Screen.Cursor := crDefault;
end;

Function TFConfDatabase.TestaConexao:String;
var
  LDatabase:string;
begin
  if not(Pos('/',edtCaminho.Text) > 0) then
    LDatabase := edtHostname.Text + '/' + edtPorta.Text + ':' + edtCaminho.Text
  else
    LDatabase := edtCaminho.Text;

  Result := FPrincipal.Conexao.TestaConexao(edtUsuario.Text,
                                  edtSenha.Text,
                                  LDatabase);
end;

procedure TFConfDatabase.btnTestarClick(Sender: TObject);
begin
  lblMensagem.Caption := '';

  // Realizar Teste de Conexão com os Paremetros que estão na Tela
  if TestaConexao.IsEmpty then
  begin
    lblMensagem.Caption := 'Conexão Realizada Com Sucesso!';
    lblMensagem.Font.Color := clGreen;
    lblMensagem.Font.Size := 10;
  end
  else
  begin
    lblMensagem.Caption := TestaConexao;
    lblMensagem.Font.Color := clRed;
    lblMensagem.Font.Size := 10;
  end;

end;

end.
