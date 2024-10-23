unit UIniConfigServer;

interface
uses
System.Classes,
System.SysUtils,
UINI;

type
  TIniConfigServer = Class

    private
      const

        SECTION  = 'SERVER';
        HOSTNAME = 'HOSTNAME';
        PORTA    = 'PORTA';
      var

        FIni : TIni;

    public
      constructor Create;
      Destructor Destroy; Override;
      procedure SetHostname(AValue: String);
      procedure SetPorta(AValue: String);
      function GetHostName: string;
      function GetPorta: Integer;




  End;

implementation

{ TIniConfigServer }

constructor TIniConfigServer.Create;
begin
  FIni := TIni.Create(SECTION);
end;

destructor TIniConfigServer.Destroy;
begin
  FIni.Free;
  inherited;
end;

function TIniConfigServer.GetHostName: string;
begin
  Result := FIni.LerString(HOSTNAME, 'LocalHost');
end;

function TIniConfigServer.GetPorta: Integer;
begin
  Result := FIni.LerInteiro(PORTA);
end;

procedure TIniConfigServer.SetHostname(AValue: String);
begin
  FIni.Escrever(HOSTNAME, AValue);
end;

procedure TIniConfigServer.SetPorta(AValue: String);
begin
  FIni.Escrever(PORTA, AValue);
end;

end.
