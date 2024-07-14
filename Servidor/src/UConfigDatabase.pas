unit UConfigDatabase;

interface
uses
System.Classes,
System.SysUtils,
UIniConfigDatabase;

type
  TConfigDatabase = class
    private
      FParam : TStrings;
      FIni: TIniConfigDatabase;
      procedure CarregaParam;
    protected

    public
      constructor Create(AOwner: TComponent);
      destructor Destroy; override;
      function GetParams:String; overload;
      function GetParams(AUser , ASenha: string):String; overload;
      function GetParams(AUser , ASenha, ADatabase: string):String; overload;

  end;

implementation


{ TConfigDatabase }

constructor TConfigDatabase.Create(AOwner: TComponent);

begin
  FIni := TIniConfigDatabase.Create;
  CarregaParam;

end;

destructor TConfigDatabase.Destroy;
begin
  FParam.Free;
  inherited;
end;

function TConfigDatabase.GetParams(AUser, ASenha: string): String;
begin
  Result := Format(FParam.Text,[FIni.GetDatabase,
                                         AUser,
                                         ASenha]);
end;

function TConfigDatabase.GetParams(AUser, ASenha, ADatabase: string): String;
begin
  Result := format(FParam.Text,[ADatabase,
                                         AUser,
                                         ASenha]);
end;

function TConfigDatabase.GetParams: String;
begin
  Result := Format(FParam.Text,[FIni.GetDatabase,FIni.GetUserName,FIni.GetPassword]);
end;

procedure TConfigDatabase.CarregaParam;
begin
  if not Assigned(FParam) then
    FParam := TStringList.Create;

  FParam.Clear;
  FParam.Add('DriverUnit=Data.DBXFirebird');
  FParam.Add('DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver240.bpl');
  FParam.Add('DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=24.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
  FParam.Add('MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFirebirdDriver240.bpl');
  FParam.Add('MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandFactory,Borland.Data.DbxFirebirdDriver,Version=24.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
  FParam.Add('GetDriverFunc=getSQLDriverINTERBASE');
  FParam.Add('LibraryName=dbxfb.dll');
  FParam.Add('LibraryNameOsx=libsqlfb.dylib');
  FParam.Add('VendorLib=fbclient.dll');
  FParam.Add('VendorLibWin64=fbclient.dll');
  FParam.Add('VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird');
  FParam.Add('Database=%s');
  FParam.Add('User_Name=%s');
  FParam.Add('Password=%s');
  FParam.Add('Role=RoleName');
  FParam.Add('MaxBlobSize=-1');
  FParam.Add('LocaleCode=0000');
  FParam.Add('IsolationLevel=ReadCommitted');
  FParam.Add('SQLDialect=3');
  FParam.Add('CommitRetain=False');
  FParam.Add('WaitOnLocks=True');
  FParam.Add('TrimChar=False');
  FParam.Add('BlobSize=-1');
  FParam.Add('ErrorResourceFile=');
  FParam.Add('RoleName=RoleName');
  FParam.Add('ServerCharSet=');
  FParam.Add('Trim Char=False');

end;

end.
