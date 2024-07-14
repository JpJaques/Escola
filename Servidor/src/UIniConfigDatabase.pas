unit UIniConfigDatabase;

interface
uses
System.IniFiles,
System.Classes,
System.SysUtils;

type
  TIniConfigDatabase = class

    private
      const
        SECTION    = 'DATABASE';
        DRIVERNAME = 'Firebird';
        USERNAME   = 'User_Name';
        PASSWORD   = 'Password';
        DATABASE   = 'Database';
        HOSTNAME   = 'Hostname';
        PORTA      = 'Porta';

      var
        FIni : TIniFile;
        procedure CriaIniPadrao(APathFile : String);
    public
      constructor Create;
      destructor Destroy; override;
      procedure SetUserName(AValue : String);
      procedure SetPassword(AValue : String);
      procedure SetDatabase(AValue : String);
      procedure SetHostname(AValue : String);
      procedure SetPorta(AValue : String);
      function GetUserName:string;
      function GetPassword:string;
      function GetDatabase:string;
      function GetHostname:string;
      function GetPorta:string;
  end;

implementation

{ TIniConfigDatabase }

constructor TIniConfigDatabase.Create;
var
  LIniFile, LDir: string;
begin
  LDir := ExtractFilePath(ParamStr(0)) + 'CONF';

  if Not DirectoryExists(LDir) then
    ForceDirectories(LDir);

  LIniFile := LDir + '\Configuracao.ini';

  if not FileExists(LIniFile) then
    CriaIniPadrao(LIniFile)
  else
    FIni := TIniFile.Create(LIniFile);
end;

procedure TIniConfigDatabase.CriaIniPadrao(APathFile : String);
begin
  FIni := TIniFile.Create(APathFile);

  FIni.WriteString(SECTION,USERNAME,'SYSDBA');
  FIni.WriteString(SECTION,PASSWORD,'masterkey');
  FIni.WriteString(SECTION,DATABASE,'Database.FDB');
  FIni.WriteString(SECTION,HOSTNAME,'127.0.0.1');
  FIni.WriteString(SECTION,PORTA,'3055');
end;

destructor TIniConfigDatabase.Destroy;
begin
  FIni.Free;
  inherited;
end;

function TIniConfigDatabase.GetDatabase: string;
begin
  Result := FIni.ReadString(SECTION,DATABASE,'');
end;

function TIniConfigDatabase.GetHostname: string;
begin
  Result := FIni.ReadString(SECTION,HOSTNAME,'');
end;

function TIniConfigDatabase.GetPassword: string;
begin
  Result := FIni.ReadString(SECTION,PASSWORD,'');
end;

function TIniConfigDatabase.GetPorta: string;
begin
  Result := FIni.ReadString(SECTION,PORTA,'');
end;

function TIniConfigDatabase.GetUserName: string;
begin
  Result := FIni.ReadString(SECTION,USERNAME,'');
end;

procedure TIniConfigDatabase.SetDatabase(AValue: String);
begin
  FIni.WriteString(SECTION,DATABASE,AValue);
end;

procedure TIniConfigDatabase.SetHostname(AValue: String);
begin
  FIni.WriteString(SECTION,HOSTNAME,AValue);
end;

procedure TIniConfigDatabase.SetPassword(AValue: String);
begin
  FIni.WriteString(SECTION,PASSWORD,AValue);
end;

procedure TIniConfigDatabase.SetPorta(AValue: String);
begin
  FIni.WriteString(SECTION,PORTA,AValue);
end;

procedure TIniConfigDatabase.SetUserName(AValue: String);
begin
  FIni.WriteString(SECTION,USERNAME,AValue);
end;

end.
