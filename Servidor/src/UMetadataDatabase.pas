unit UMetadataDatabase;

interface
Uses
System.SysUtils,
System.Classes;

type
  TMetadataDatabase = class
  private
    const
      DB         = 'DATABASE';
      FBPATH     = 'C:\Program Files\Firebird\Firebird_4_0\';
      ISQL       = 'isql -ex -o ';
      CMD        = 'cmd.exe';

      Class procedure AntesConectar(Sender: TObject);
      class function RetornaPathDB:string;
      class procedure CriaMetadata;


      class procedure ExecutaShell(Const AAplicacao,AComando,ACaminhoExecucao: String);
  public
    Class Procedure GerarMetadata;
    class procedure CriarDatabase;
  end;

implementation

uses
Winapi.ShellAPI,
Vcl.Dialogs,
Winapi.Windows,
System.UITypes,
FireDAC.Stan.Intf,
FireDAC.Stan.Option,
FireDAC.Stan.Error,
FireDAC.UI.Intf,
FireDAC.Phys.Intf,
FireDAC.Stan.Def,
FireDAC.Stan.Pool,
FireDAC.Stan.Async,
FireDAC.Phys,
FireDAC.VCLUI.Wait,
Data.DB,
FireDAC.Comp.Client,
FireDAC.Phys.FBDef,
FireDAC.Phys.IBBase,
FireDAC.Phys.FB,
FireDAC.Comp.ScriptCommands,
FireDAC.Stan.Util,
FireDAC.Comp.Script;

{ TMetadataDatabase }

Class procedure TMetadataDatabase.AntesConectar(Sender: TObject);
var
  LDatabase: string;
begin
  LDatabase := Format('%s.FDB',[RetornaPathDB + DB]);

  if Sender is TFDConnection then
  begin
    TFDConnection(Sender).Params.Database := LDatabase;
    TFDConnection(Sender).Params.Values['CreateDatabase'] := BoolToStr(not FileExists(LDatabase), True);
  end;
end;

class procedure TMetadataDatabase.CriaMetadata;
var
  Comando: string;
begin
  Comando := ISQL + ' "' + RetornaPathDB + DB + '.SQL" ' + RetornaPathDB + DB + '.FDB ';

  ExecutaShell(CMD,Comando,FBPATH);

end;

class procedure TMetadataDatabase.CriarDatabase;
var
 LDB: string;
 Conn: TFDConnection;
 Script : TFDScript;
 Transaction: TFDTransaction;
begin
  LDB := RetornaPathDB + DB + '.FDB';
  if FileExists(LDB) then
  begin
    ShowMessage('Arquivo de Banco de Dados '+ DB + '.FDB já Existe no diretório Atual.' + #13 +
                'O processo será Abortado!');
    Abort;
  end;


  if not FileExists(RetornaPathDB + DB + '.SQL') then
  begin
    ShowMessage('Arquivo de Banco de Dados '+ DB + '.SQL NÃO Existe no diretório Atual.' + #13 +
                ' Execute o processo para gerar Metadata do banco de dados Primeiro.' +#13 +
                'O processo será Abortado!');
    Abort;
  end;

  Conn := TFDConnection.Create(Nil);
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

    Script := TFDScript.Create(Nil);
    Transaction := TFDTransaction.Create(Nil);
    Transaction.Options.DisconnectAction := xdRollback;

    Script.Connection  := Conn;
    Conn.Transaction := Transaction;

    try
      Conn.StartTransaction;

      Script.ExecuteFile(Format('%s.SQL',[RetornaPathDB + DB]));
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

    Conn.Close;
  finally
    Script.Free;
    Conn.Free;
  end;

end;

class procedure TMetadataDatabase.ExecutaShell(const AAplicacao, AComando,ACaminhoExecucao: String);
begin
  ShellExecute(0,Nil,PWideChar(AAplicacao),PWideChar('/C '+ AComando),PWideChar(ACaminhoExecucao),SW_HIDE);
end;

class procedure TMetadataDatabase.GerarMetadata;
var
  msg: string;
begin
   msg :=
    'O Aquivo de DATABASE.SQL já Existe no Diretório : '+ RetornaPathDB + DB + '%s' + #13 +
    'Deseja Sobrescreve-lo?';

  if not FileExists(RetornaPathDB + DB + '.FDB') then
  begin
    ShowMessage('O Arquivo de Banco de Dados "DATABASE.FDB" Não Existe no Diretório Padrão Atual.' +
                #13 + 'O Processo Será Abortado!');
    Abort;
  end;

  if FileExists(RetornaPathDB + DB + '.SQL') then
  begin
    if (MessageDlg(Format(msg,['.SQL']),mtConfirmation,[mbOK,mbNo],0) = MrOK) then
    begin
      DeleteFile(PWideChar(RetornaPathDB + DB + '.SQL'));
      CriaMetadata;
    end;
  end
  else
    CriaMetadata;

end;

class function TMetadataDatabase.RetornaPathDB: string;
begin
  Result := ExtractFilePath(ParamStr(0)) + '..\DATABASE\';
end;

end.
