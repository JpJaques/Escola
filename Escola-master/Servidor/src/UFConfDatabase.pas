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
 UMensagens;

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
  private
    FCaminho:           string;
    FUsername:          string;
    FSenha:             string;
    FMensagem:          string;
    MensagemHabilitada: Boolean;
    function IIF(Expressao : Variant; RetornoVerdadeiro : Variant; RetornoFalse : Variant): Variant;
  public
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

  Arquivo   := ChangeFileExt(ExtractFilePath(Application.ExeName)+'CONF\Configuracao','.ini');
  INI       := TIniFile.Create(Arquivo);
  try
    if not INI.SectionExists('DATABASE') then
    begin
      INI.WriteString('DATABASE', 'DATABASE',FCaminho);
      INI.WriteString('DATABASE', 'USERNAME',FUsername);
      INI.WriteString('DATABASE', 'SENHA',FSenha);
    end
    else
    begin
      if (FCaminho <> INI.ReadString('DATABASE','DATABASE','')) then
        INI.WriteString('DATABASE', 'DATABASE',FCaminho)
      else if (FUsername <> INI.ReadString('DATABASE','USERNAME','')) then
        INI.WriteString('DATABASE', 'USERNAME',FUsername)
      else if (FSenha <> INI.ReadString('DATABASE','SENHA','')) then
        INI.WriteString('DATABASE', 'SENHA',FSenha);
    end;

    Close;
  finally
    INI.Free;
  end;

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
  Arquivo := ChangeFileExt(ExtractFilePath(Application.ExeName)+'CONF\Configuracao','.ini');
  INI     := TIniFile.Create(Arquivo);

  if not INI.SectionExists('DATABASE') then
  begin
   edtHostname.Text := 'LOCALHOST';
   edtPorta.Text    := '3055';
   edtCaminho.Text  := ChangeFilePath((ExtractFilePath(Application.ExeName + 'CONF')+'DATABASE'),'.FDB');
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

procedure TFConfDatabase.btnTestarClick(Sender: TObject);
begin
  TestaConexao;
end;

procedure TFConfDatabase.TestaConexao;
var
  Conexao : TSQLConnection;
  PathComp: string;
begin
  lblMensagem.Caption := '';
  lblMensagem.WordWrap := True;
  Conexao  := TSQLConnection.Create(self);
  try
    try
      Conexao.Close;
      Conexao.DriverName     := 'Firebird';
      Conexao.ConnectionName := 'FBConnection';
      Conexao.LoginPrompt    := False;
      Conexao.Params.Clear;
      Conexao.Params.Text :=
          'DriverUnit=Data.DBXFirebird' + #13 +
          'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver240.bpl' + #13 +
          'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=24.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b' + #13 +
          'MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFirebirdDriver240.bpl' + #13 +
          'MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandFactory,Borland.Data.DbxFirebirdDriver,Version=24.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b' + #13 +
          'GetDriverFunc=getSQLDriverINTERBASE' + #13 +
          'LibraryName=dbxfb.dll' + #13 +
          'LibraryNameOsx=libsqlfb.dylib' + #13 +
          'VendorLib=fbclient.dll' + #13 +
          'VendorLibWin64=fbclient.dll' + #13 +
          'VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird' + #13 +
          'Database=' + edtCaminho.Text + #13 +
          'User_Name=' + edtUsuario.Text + #13 +
          'Password=' + edtSenha.Text + #13 +
          'Role=RoleName' + #13 +
          'MaxBlobSize=-1' + #13 +
          'LocaleCode=0000' + #13 +
          'IsolationLevel=ReadCommitted' + #13 +
          'SQLDialect=3' + #13 +
          'CommitRetain=False' + #13 +
          'WaitOnLocks=True' + #13 +
          'TrimChar=False' + #13 +
          'BlobSize=-1' + #13 +
          'ErrorResourceFile=' + #13 +
          'RoleName=RoleName' + #13 +
          'ServerCharSet=' + #13 +
          'Trim Char=False';

      Conexao.Open;

      lblMensagem.Caption    := Conexao_Realizada + #13 +  PathComp;
      lblMensagem.Font.Color := clGreen;
      lblMensagem.Font.Size  := 15;
      Conexao.Close;
    except
      on Ex:Exception do
      begin
        lblMensagem.Caption := Format(Erro,[Ex.Message]);
        lblMensagem.Font.Color := clRed;
        lblMensagem.Font.Size  := 15;
      end;
    end;
   Conexao.Close;
  finally
   Conexao.Free;
  end;


end;

end.
