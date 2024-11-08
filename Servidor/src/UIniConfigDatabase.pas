unit UIniConfigDatabase;

interface
uses
System.IniFiles,
System.Classes,
System.SysUtils,
UIni;

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
        FIni : TIni;
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
  FIni := TIni.Create(SECTION);
end;


destructor TIniConfigDatabase.Destroy;
begin
  FIni.Free;
  inherited;
end;

function TIniConfigDatabase.GetDatabase: string;
begin
  Result := FIni.LerString(DATABASE, 'DATABASE.FDB');
end;

function TIniConfigDatabase.GetHostname: string;
begin
  Result := FIni.LerString(HOSTNAME,'LOCALHOST');
end;

function TIniConfigDatabase.GetPassword: string;
begin
  Result := FIni.LerString(PASSWORD,'123456');
end;

function TIniConfigDatabase.GetPorta: string;
begin
  Result := FIni.LerString(PORTA,'3055');
end;

function TIniConfigDatabase.GetUserName: string;
begin
  Result := FIni.LerString(USERNAME,'SYSDBA');
end;

procedure TIniConfigDatabase.SetDatabase(AValue: String);
begin
  FIni.Escrever(DATABASE,AValue);
end;

procedure TIniConfigDatabase.SetHostname(AValue: String);
begin
  FIni.Escrever(HOSTNAME,AValue);
end;

procedure TIniConfigDatabase.SetPassword(AValue: String);
begin
  FIni.Escrever(PASSWORD,AValue);
end;

procedure TIniConfigDatabase.SetPorta(AValue: String);
begin
  FIni.Escrever(PORTA,AValue);
end;

procedure TIniConfigDatabase.SetUserName(AValue: String);
begin
  FIni.Escrever(USERNAME,AValue);
end;

end.
