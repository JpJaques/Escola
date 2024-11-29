unit UFManutencaoDatabase;

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
Vcl.Buttons,
Vcl.StdCtrls,
dbcClasses,
dbcDBComparer,
Data.DBXFirebird,
Data.DB,
Data.SqlExpr,
dbcDBEngine,
dbcConnection_DBX,
dbcCustomScriptExtract,
dbcIBScriptExtract,
dbcDBStructure,
dbcIBDatabaseExtract,
Data.DBXCommon,
FireDAC.Comp.Client,
FireDAC.Comp.Script,
FireDAC.Stan.Option,
FireDAC.Phys,
FireDAC.Phys.FBDef,
FireDAC.Phys.FB,
FireDAC.Comp.ScriptCommands,
FireDAC.Stan.Util,
FireDAC.Stan.Def, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf,
  FireDAC.Comp.UI;

type
  TFManutencaoDatabase = class(TForm)
    pnlGeral: TPanel;
    pnlTopo: TPanel;
    btnFechar: TSpeedButton;
    pnlOpcoes: TPanel;
    Linha: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    edtOrigem: TEdit;
    edtTarget: TEdit;
    lblOrigem: TLabel;
    lblTarget: TLabel;
    btnComparar: TButton;
    btnExtrair: TButton;
    OpenDialog: TOpenDialog;
    DBComparer: TDBComparer;
    mmScript: TMemo;
    DBStructureOrigem: TDBStructure;
    DBStructureTarget: TDBStructure;
    DBCConnectionDBXOrigem: TDBCConnectionDBX;
    SQLConnectionOrigem: TSQLConnection;
    SQLConnectionTarget: TSQLConnection;
    DBCConnectionDBXTarget: TDBCConnectionDBX;
    IBDBExtract: TIBDBExtract;
    Label1: TLabel;
    Label2: TLabel;
    mmLog: TMemo;
    Panel4: TPanel;
    gbExtracao: TGroupBox;
    cbSalvarArq: TCheckBox;
    cbMostraLogExt: TCheckBox;
    cbMostraScriptExt: TCheckBox;
    btnCriarBancoOrigem: TButton;
    GroupBox1: TGroupBox;
    cbExecutaScript: TCheckBox;
    ExtractTarget: TIBDBExtract;
    ExtractOrigem: TIBDBExtract;
    GroupBox2: TGroupBox;
    cbExecutaScriptComparacao: TCheckBox;
    cbSalvarScriptComparacao: TCheckBox;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    procedure btnFecharClick(Sender: TObject);
    procedure pnlTopoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure btnExtrairClick(Sender: TObject);
    procedure btnCompararClick(Sender: TObject);
    procedure SQLConnectionTargetBeforeConnect(Sender: TObject);
    procedure SQLConnectionOrigemBeforeConnect(Sender: TObject);
    procedure IBScriptExtractLogNextLine(Sender: TObject; LogText: string);
    procedure IBDBExtractLogNextLine(Sender: TObject; LogText: string);
    procedure btnCriarBancoOrigemClick(Sender: TObject);
    procedure ExtractTargetLogNextLine(Sender: TObject; LogText: string);
    procedure ExtractOrigemLogNextLine(Sender: TObject; LogText: string);
    procedure DBComparerLogNextLine(Sender: TObject; LogText: string);
    procedure DBComparerBeforeExtract(Sender: TObject);
    procedure DBComparerBeforeExtractMaster(Sender: TObject);
    procedure DBComparerBeforeExtractTarget(Sender: TObject);
    procedure DBComparerAfterExtractMaster(Sender: TObject);
    procedure DBComparerAfterExtractTarget(Sender: TObject);
  private
    { Private declarations }
    const
      cORIGEM = 'ORIGEM';
      cTARGET = 'TARGET';
      cFDB    = 'FDB';
      cSQL    = 'SQL';

    procedure TestarConexao;
    Procedure LimparMemos;
    procedure AntesConectar(Sender: TObject);
    procedure AdicionarLog(const AText: String);
    procedure ValidarBancoOrigemTarget();
    function ParamsDatabase(const ADatabase: String): string;
    function PathDatabase:string;
    function GetFDConn(Const ADatabase:String):TFDConnection;
    function GetFDScript:TFDScript;

  public
    { Public declarations }
  end;

implementation


{$R *.dfm}

procedure TFManutencaoDatabase.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFManutencaoDatabase.DBComparerAfterExtractMaster(Sender: TObject);
begin
  AdicionarLog('========> Finalizado Extração Metadata ORIGEM.....');
end;

procedure TFManutencaoDatabase.DBComparerAfterExtractTarget(Sender: TObject);
begin
  AdicionarLog('========> Finalizado Extração Metadata TARGET');
end;

procedure TFManutencaoDatabase.DBComparerBeforeExtract(Sender: TObject);
begin
  ExtractTarget.DBCConnection.Connected := True;
  ExtractOrigem.DBCConnection.Connected := True;
end;

procedure TFManutencaoDatabase.DBComparerBeforeExtractMaster(Sender: TObject);
begin
  AdicionarLog('=====> Extraindo Metadata banco ORIGEM......');
end;

procedure TFManutencaoDatabase.DBComparerBeforeExtractTarget(Sender: TObject);
begin
  AdicionarLog('=====> Extraindo Metadata banco TARGET......');
end;

procedure TFManutencaoDatabase.DBComparerLogNextLine(Sender: TObject;LogText: string);
begin
  AdicionarLog(LogText);
end;

procedure TFManutencaoDatabase.ExtractOrigemLogNextLine(Sender: TObject;LogText: string);
begin
  AdicionarLog(LogText);
end;

procedure TFManutencaoDatabase.ExtractTargetLogNextLine(Sender: TObject;LogText: string);
begin
  AdicionarLog(LogText);
end;

procedure TFManutencaoDatabase.AdicionarLog(const AText: String);
begin
  mmLog.Lines.Add(AText);
  mmLog.Perform(EM_SCROLLCARET, 0, 0);
end;

procedure TFManutencaoDatabase.AntesConectar(Sender: TObject);
var LDatabase: string;
begin
  LDatabase := Format('%s.FDB',[PathDatabase + 'ORIGEM']);

  if Sender is TFDConnection then
  begin
    TFDConnection(Sender).Params.Database := LDatabase;
    TFDConnection(Sender).Params.Values['CreateDatabase'] := BoolToStr(not FileExists(LDatabase), True);
  end;
end;

procedure TFManutencaoDatabase.btnCompararClick(Sender: TObject);
var
  LScriptComparacao: TStringList;
  LSCript: TFDScript;
  LConn: TFDConnection;
begin
  LimparMemos;
  ValidarBancoOrigemTarget;
  TestarConexao;
  DBComparer.ExtractDatabases;
  DBComparer.CompareDatabases;
  DBComparer.SQLExec.GetScript(mmScript.Lines);

  SQLConnectionTarget.Close;

  LConn   := GetFDConn(edtTarget.Text);
  LSCript := GetFDScript;
  LScriptComparacao := TStringList.Create;
  try
    LScriptComparacao.Text := mmScript.Lines.Text;
    //Salvar Desabilitado pois da erro ao encontrar caminho ainda não sei PQ.
    //if cbSalvarScriptComparacao.Checked then
    //LScriptComparacao.SaveToFile(PathDatabase + 'Comparacao.SQL');

    if not cbExecutaScriptComparacao.Checked then
      Exit;

    try
      LSCript.Connection := LConn;
      LSCript.SQLScripts.Add.SQL := LScriptComparacao;
      LSCript.ScriptOptions.IgnoreError := True;
      LSCript.ValidateAll;
      LConn.StartTransaction;
      LSCript.ExecuteAll;
      LConn.Commit;
    except
      on E: Exception do
      begin
        LConn.Rollback;
        raise Exception.Create('Error ao Executar Script: ' + #13 + E.Message);

      end;
    end;

  finally
    LSCript.Free;
    LConn.Free;
    LScriptComparacao.Free;
  end;
end;

procedure TFManutencaoDatabase.btnCriarBancoOrigemClick(Sender: TObject);
var
 LDB: string;
 Conn: TFDConnection;
 Script : TFDScript;
 Transaction: TFDTransaction;
begin
  LimparMemos;
  LDB := PathDatabase + 'ORIGEM.FDB';
  if FileExists(LDB) then
  begin
    ShowMessage('Arquivo de Banco de Dados  ORIGEM.FDB já Existe no diretório Atual.' + #13 +
                'O processo será Abortado!');
    Abort;
  end;

  if not FileExists(PathDatabase + 'ORIGEM.SQL') then
  begin
    ShowMessage('Arquivo de Banco de Dados ORIGEM.SQL NÃO Existe no diretório Atual.' + #13 +
                ' Execute o processo para gerar Metadata do banco de dados Primeiro.' +#13 +
                'O processo será Abortado!');
    Abort;
  end;

  Conn := TFDConnection.Create(Self);
  try
    Conn.Close;
    Conn.LoginPrompt := False;
    Conn.Connected   := False;
    Conn.DriverName  := 'FB';
    Conn.Params.Text :=
      'User_Name=SYSDBA       ' + #13 +
      'Password=masterkey     ' + #13 +
      'Server=Localhost       ' + #13 +
      'Port=3055              ' + #13 +
      'CharacterSet=ISO8859_1 ' + #13 +
      'DriverID=FB ';

    Conn.BeforeConnect := AntesConectar;
    try
      Conn.Open;
    Except
      on E:Exception do
        raise Exception.Create(E.Message);
    end;

    if not cbExecutaScript.Checked then
      Exit;

    try
      Script := TFDScript.Create(Self);
      Transaction := TFDTransaction.Create(Self);
      Transaction.Options.DisconnectAction := xdRollback;
      Script.Connection := Conn;
      Conn.Transaction  := Transaction;
      try
        Conn.StartTransaction;
        Script.SQLScriptFileName := Format('%s.SQL',[PathDatabase + cORIGEM]);
        Script.ValidateAll;
        Script.ExecuteAll;
        Conn.Commit;
      Except
        on E:Exception do
        begin
          Conn.Rollback;
          raise Exception.Create(E.Message);
        end;
      end;

    finally
      FreeAndNil(Script);
    end;

    Conn.Close;
  finally
    Conn.Free;
  end;

end;

procedure TFManutencaoDatabase.btnExtrairClick(Sender: TObject);
var
  LScriptMetadata: TStringList;
  LNome: string;
begin
  LimparMemos;
  LScriptMetadata := TStringList.Create;
  try
    OpenDialog.Title := 'Selecione o banco de dados que deseja Extrair Metadata.';
    OpenDialog.DefaultExt := '*.fdb';
    OpenDialog.Filter     := 'FDB|*.fdb|';

    if string(edtTarget.Text).Trim.IsEmpty then
      if OpenDialog.Execute then
        edtTarget.Text := OpenDialog.FileName;

    IBDBExtract.DBCConnection.Connected := true;
    IBDBExtract.ExtractDatabase;
    DBStructureTarget.Metadata.ScriptOptions.GenerateScript := True;
    DBStructureTarget.Metadata.ExtractMetadata(LScriptMetadata);

    if cbMostraScriptExt.Checked then
      mmScript.Lines.Text := LScriptMetadata.Text;

    if cbSalvarArq.Checked then
    begin
      LNome := InputBox('Defina o Nome do Arquivo','Nome:','ORIGEM');
      LScriptMetadata.SaveToFile(PathDatabase + LNome + '.SQL');
    end;

  finally
    LScriptMetadata.Free;
  end;
end;

procedure TFManutencaoDatabase.FormShow(Sender: TObject);
begin
  mmScript.Lines.Clear;
  mmLog.Lines.Clear;
end;

function TFManutencaoDatabase.GetFDConn(const ADatabase: String): TFDConnection;
var
  LConn: TFDConnection;
  LTransacao: TFDTransaction;
begin
  LConn      := TFDConnection.Create(Nil);
  LTransacao := TFDTransaction.Create(Nil);

  LConn.Close;
  LConn.LoginPrompt := False;
  LConn.Connected   := False;
  LConn.DriverName  := 'FB';
  LConn.Transaction := LTransacao;

  with LConn.Params do
  begin
    DriverID := 'FB';
    UserName := 'SYSDBA';
    Password := 'masterkey';
    Database := ADatabase;
    Add('Port=3055');
    Add('Server=Localhost');
    Add('CharacterSet=ISO8859_1');
  end;
  {
  'User_Name=SYSDBA       ' + #13 +
  'Password=masterkey     ' + #13 +
  'Server=Localhost       ' + #13 +
  'Port=3055              ' + #13 +
  'CharacterSet=ISO8859_1 ' + #13 +
  'DriverID=FB ';
  }
  try
    LConn.Open;
    LConn.Close;
  Except
    on E:Exception do
      raise Exception.Create(E.Message);
  end;
  Result := LConn;
end;

function TFManutencaoDatabase.GetFDScript: TFDScript;
var LSCript:TFDScript;
begin
  LSCript := TFDScript.Create(Nil);
  Result := LSCript;
end;

procedure TFManutencaoDatabase.IBDBExtractLogNextLine(Sender: TObject;LogText: string);
begin
  if cbMostraLogExt.Checked then
    AdicionarLog(LogText);
end;

procedure TFManutencaoDatabase.IBScriptExtractLogNextLine(Sender: TObject;LogText: string);
begin
  AdicionarLog(LogText);
end;

procedure TFManutencaoDatabase.LimparMemos;
begin
  mmLog.Lines.Clear;
  mmScript.Lines.Clear;
end;

function TFManutencaoDatabase.ParamsDatabase(const ADatabase: String): string;
begin
  Result :=
    'DriverName=Firebird'          + #13 +
    'Database=' +  ADatabase       + #13 +
    'RoleName=RoleName'            + #13 +
    'User_Name=SYSDBA'             + #13 +
    'Password=masterkey'           + #13 +
    'ServerCharSet='               + #13 +
    'SQLDialect=3'                 + #13 +
    'ErrorResourceFile='           + #13 +
    'LocaleCode=0000'              + #13 +
    'BlobSize=-1'                  + #13 +
    'CommitRetain=False'           + #13 +
    'WaitOnLocks=True'             + #13 +
    'IsolationLevel=ReadCommitted' + #13 +
    'Trim Char=False';

end;

function TFManutencaoDatabase.PathDatabase: string;
begin
  Result := ExtractFilePath(ParamStr(0)) + 'Database\';
end;

procedure TFManutencaoDatabase.pnlTopoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Screen.Cursor := crDefault;
  ReleaseCapture;
  Self.Perform(wm_nclbuttondown,HTCAPTION,0);
end;

procedure TFManutencaoDatabase.SQLConnectionOrigemBeforeConnect(Sender: TObject);
begin
  SQLConnectionOrigem.Params.Clear;
  SQLConnectionOrigem.Params.Text := ParamsDatabase(edtOrigem.Text);
end;

procedure TFManutencaoDatabase.SQLConnectionTargetBeforeConnect(Sender: TObject);
begin
  SQLConnectionTarget.Params.Clear;
  SQLConnectionTarget.Params.Text := ParamsDatabase(edtTarget.Text);
end;

procedure TFManutencaoDatabase.TestarConexao;
begin
  SQLConnectionOrigem.Connected := False;
  SQLConnectionOrigem.Connected := True;

  SQLConnectionTarget.Connected := False;
  SQLConnectionTarget.Connected := True;
end;

procedure TFManutencaoDatabase.ValidarBancoOrigemTarget();
var LMSG: string;
begin
  LMSG                  := 'Selecione o Arquivo .FDB para ser o Arquivo de %s';
  OpenDialog.DefaultExt := '*.fdb';
  OpenDialog.Filter     := 'FDB|*.fdb|';


  if not (string(edtOrigem.Text).Contains('.FDB')) then
  begin
    OpenDialog.Title := 'Selecione o banco ' + cORIGEM;

    if OpenDialog.Execute then
      if String(OpenDialog.FileName).Trim.IsEmpty then
        raise Exception.Create(Format(LMSG,[cORIGEM]));

    edtOrigem.Text := OpenDialog.FileName;
  end;

  if not (String(edtTarget.Text).Contains('.FDB')) then
  begin
    OpenDialog.Title := 'Selecione o banco ' + cTARGET;

    if OpenDialog.Execute then
      if String(OpenDialog.FileName).Trim.IsEmpty then
        raise Exception.Create(Format(LMSG,[cTARGET]));

    edtTarget.Text := OpenDialog.FileName;
  end;

end;

end.
