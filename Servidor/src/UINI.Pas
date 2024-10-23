unit UIni;

interface
Uses
System.IniFiles,
SYstem.SysUtils,
System.Classes;

type
  TIni = class
  private
    FIni: TIniFile;
    FSection: string;
    function GetPath:string;
  public
    constructor Create(ASection: String);
    destructor Destroy; override;
    Procedure Escrever(AIdent, AValue: String);
    function LerString(AValue, ADefault: String):string;
    function LerInteiro(AValue: string): Integer;

  end;

implementation

{ TIni }

constructor TIni.Create(ASection: String);
var
  LDir: string;
begin
  LDir := ExtractFilePath(GetPath);

  if Not DirectoryExists(LDir) then
    ForceDirectories(LDir);

 FIni     := TIniFile.Create(GetPath);
 FSection := ASection;
end;

destructor TIni.Destroy;
begin
  FIni.Free;
  inherited;
end;

procedure TIni.Escrever(AIdent, AValue: String);
begin
  FIni.WriteString(FSection,AIdent,AValue);
end;

function TIni.GetPath: string;
begin
  Result := ExtractFileDir(ParamStr(0)) + '\CONF\Configuracao.ini'
end;

function TIni.LerInteiro(AValue: string): Integer;
begin
  Result := FIni.ReadInteger(FSection,AValue, 0);
end;

function TIni.LerString(AValue, ADefault: String): string;
begin
  Result := FIni.ReadString(FSection,AValue, ADefault);
end;

end.
