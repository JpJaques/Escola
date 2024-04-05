unit UInicializacao;

interface

uses
System.IniFiles,
Data.SqlExpr,
System.Classes,
System.SysUtils,
Vcl.Forms,
Data.DB,
Data.DBXFirebird,
UConfiguracaoServidor,
UMensagens,
UFConfDatabase;

type
  Tipo = (tDiretorio, tArquivo);

function Retorna_Dir_Arq_Configuracao(ArqOuDir : Tipo):string;
function Inicializacao:string;
function Retorna_Param_Conexao_Database:String; overload;
function Retorna_Param_Conexao_Database(Database , Usuario, Senha: String):String; overload;

implementation

function Retorna_Dir_Arq_Configuracao(ArqOuDir : Tipo):string;
begin
  case ArqOuDir of
  tDiretorio : Result := ExtractFilePath(Application.ExeName)+'CONF\';
  tArquivo   : Result := ChangeFileExt(ExtractFilePath(Application.ExeName)+'CONF\Configuracao','.ini');
  end;

end;

function Inicializacao:string;
var
  Ini:             TIniFile;
  ArquivoIni:      string;
  Conexao:         TSQLCOnnection;
  MensagemRetorno: TStrings;
  FConfigServidor: TFConfigServidor;
  FConfigDatabase: TFConfDatabase;
begin
  Conexao         := TSQLConnection.Create(nil);
  MensagemRetorno := TStringList.Create;
  ArquivoIni      := Retorna_Dir_Arq_Configuracao(tArquivo);

  if not FileExists(ArquivoIni) then
  begin
    FConfigServidor := TFConfigServidor.create(nil);
    FConfigServidor.Show;
  end;

  Ini := TIniFile.Create(ArquivoIni);

  try
    MensagemRetorno.Clear;
    //Cria uma SQL Connection apenas para testar a conexão utilizando a sessão do INI.
    try
      Conexao.Close;
      Conexao.DriverName     := 'Firebird';
      Conexao.ConnectionName := 'FBConnection';
      Conexao.LoginPrompt    := False;
      Conexao.Params.Clear;

      if not Ini.SectionExists('DATABASE') then
      begin
        FConfigDatabase := TFConfDatabase.Create(nil);
        FConfigDatabase.Show;

      end;

      Conexao.Params.Text    := Retorna_Param_Conexao_Database(
          Ini.ReadString('DATABASE','DATABASE',''),
          Ini.ReadString('DATABASE','USERNAME',''),
          Ini.ReadString('DATABASE','SENHA',''));
      Conexao.Open;
      Conexao.Close;
      MensagemRetorno.Add(Conexao_Realizada);
      Result := MensagemRetorno.Text;
    except
      on E:Exception do
      begin
        MensagemRetorno.Add(Format(Erro,[E.Message]));
        Result := MensagemRetorno.Text;
      end;
    end;

  finally
    MensagemRetorno.Free;
    Ini.Free;
    Conexao.Free;
  end;

end;

function Retorna_Param_Conexao_Database(Database , Usuario, Senha: String):String;
begin
  Result :=
      'DriverUnit=Data.DBXFirebird'+                                                         #13+
      'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver240.bpl' +                #13+
      'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,' +
          'Borland.Data.DbxCommonDriver,Version=24.0.0.0,' +
          'Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b' +                                #13+
      'MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFirebirdDriver240.bpl' +  #13+
      'MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandFactory,' +
          'Borland.Data.DbxFirebirdDriver,Version=24.0.0.0,Culture=neutral,' +
          'PublicKeyToken=91d62ebb5b0d1b1b' +                                                 #13+
      'GetDriverFunc=getSQLDriverINTERBASE' +                                                 #13+
      'LibraryName=dbxfb.dll' +                                                               #13+
      'LibraryNameOsx=libsqlfb.dylib' +                                                       #13+
      'VendorLib=fbclient.dll' +                                                              #13+
      'VendorLibWin64=fbclient.dll' +                                                         #13+
      'VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird' +                        #13+
      'Database=' + Database +                                                                #13+
      'User_Name=' + Usuario +                                                                #13+
      'Password=' + Senha +                                                                   #13+
      'Role=RoleName' +                                                                       #13+
      'MaxBlobSize=-1' +                                                                      #13+
      'LocaleCode=0000' +                                                                     #13+
      'IsolationLevel=ReadCommitted' +                                                        #13+
      'SQLDialect=3' +                                                                        #13+
      'CommitRetain=False' +                                                                  #13+
      'WaitOnLocks=True' +                                                                    #13+
      'TrimChar=False' +                                                                      #13+
      'BlobSize=-1' +                                                                         #13+
      'ErrorResourceFile=' +                                                                  #13+
      'RoleName=RoleName' +                                                                   #13+
      'ServerCharSet=' +                                                                      #13+
      'Trim Char=False';

end;

function Retorna_Param_Conexao_Database:String;
var
  INI:     TIniFile;
  arquivo: string;
begin
  arquivo := Retorna_Dir_Arq_Configuracao(tArquivo);
  INI     := TIniFile.Create(arquivo);
  try
    Result :=
      'DriverUnit=Data.DBXFirebird'+                                                         #13+
      'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver240.bpl' +                #13+
      'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,' +
          'Borland.Data.DbxCommonDriver,Version=24.0.0.0,' +
          'Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b' +                                #13+
      'MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFirebirdDriver240.bpl' +  #13+
      'MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandFactory,' +
          'Borland.Data.DbxFirebirdDriver,Version=24.0.0.0,Culture=neutral,' +
          'PublicKeyToken=91d62ebb5b0d1b1b' +                                                 #13+
      'GetDriverFunc=getSQLDriverINTERBASE' +                                                 #13+
      'LibraryName=dbxfb.dll' +                                                               #13+
      'LibraryNameOsx=libsqlfb.dylib' +                                                       #13+
      'VendorLib=fbclient.dll' +                                                              #13+
      'VendorLibWin64=fbclient.dll' +                                                         #13+
      'VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird' +                        #13+
      'Database=' + INI.ReadString('DATABASE','DATABASE','') +                                #13+
      'User_Name=' + INI.ReadString('DATABASE','USERNAME','') +                               #13+
      'Password=' + INI.ReadString('DATABASE','SENHA','') +                                   #13+
      'Role=RoleName' +                                                                       #13+
      'MaxBlobSize=-1' +                                                                      #13+
      'LocaleCode=0000' +                                                                     #13+
      'IsolationLevel=ReadCommitted' +                                                        #13+
      'SQLDialect=3' +                                                                        #13+
      'CommitRetain=False' +                                                                  #13+
      'WaitOnLocks=True' +                                                                    #13+
      'TrimChar=False' +                                                                      #13+
      'BlobSize=-1' +                                                                         #13+
      'ErrorResourceFile=' +                                                                  #13+
      'RoleName=RoleName' +                                                                   #13+
      'ServerCharSet=' +                                                                      #13+
      'Trim Char=False';

  finally
    INI.Free;
  end;

end;


end.
