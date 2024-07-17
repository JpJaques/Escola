unit UInicializacao;


interface

uses
System.IniFiles,
System.SysUtils,
Vcl.Forms,
UDMConexao;

type
  Tipo = (tArquivo, tDiretorio);

function RealizaConexao:string;
function RetornaDiretorio(ATipo : Tipo):String;
implementation

function RetornaDiretorio(ATipo : Tipo):String;
begin
  case ATipo of
    tArquivo: Result := ChangeFileExt(ExtractFilePath(application.ExeName)+'CONF\Conexao','.ini');
    tDiretorio: Result := ExtractFilePath(application.ExeName)+'CONF';
  end;
end;

function RealizaConexao:string;
var
  INI     : TIniFile;
  arquivo : string;
begin
  arquivo := RetornaDiretorio(tArquivo);

  if not FileExists(arquivo) then
  begin
    Result := 'Arquivo De configuração inexistente!';
    Exit;
  end;

  INI := TIniFile.Create(arquivo);
  try
    DMConexao.SQLConnection.Close;
    DMConexao.SQLConnection.DriverName := 'DataSnap';
    DMConexao.SQLConnection.LoginPrompt := False;
    DMConexao.SQLConnection.Params.Clear;
    DMConexao.SQLConnection.Params.Text :=
                              'Port='+INI.ReadString('SERVIDOR','PORTA','')+#13+
                              'HostName='+INI.ReadString('SERVIDOR','HOSTNAME','')+#13+
                              'CommunicationProtocol=tcp/ip'+#13+
                              'DatasnapContext=datasnap/';
    try
     DMConexao.SQLConnection.Open;
     Result := '';
    except
      on E:Exception do
      begin
      Result := E.Message;
      DMConexao.SQLConnection.Close;
      end;
    end;
  finally
   INI.Free;
  end;
end;

end.
