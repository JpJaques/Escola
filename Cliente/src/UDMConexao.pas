unit UDMConexao;

interface

uses
  System.SysUtils, System.Classes, ClientClassesUnit, Data.DBXDataSnap,
  Data.DBXCommon, IPPeerClient, Data.DB, Data.SqlExpr,System.Variants,Vcl.Forms;

type
  TDMConexao = class(TDataModule)
    SQLConnection: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    FInstanceOwner: Boolean;
    FServerMethodsClient: TServerMethodsClient;
    function GetServerMethodsClient: TServerMethodsClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property ServerMethodsClient: TServerMethodsClient read GetServerMethodsClient write FServerMethodsClient;
    function ExecuteMethods(Const Metodo: String; Const Parametros: array of Olevariant):Olevariant;
    function ExecuteReader(Sql:String):Olevariant;

  end;

var
  DMConexao: TDMConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TDMConexao.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

procedure TDMConexao.DataModuleCreate(Sender: TObject);
begin
  SQLConnection.Connected := True;
end;

destructor TDMConexao.Destroy;
begin
  FServerMethodsClient.Free;
  inherited;
end;

function TDMConexao.ExecuteMethods(const Metodo: String;
  const Parametros: array of Olevariant): Olevariant;
  var
  DBXComand: TDBXCommand;
  QtdParamentro, I  : Integer;
  MS: TMemoryStream;
  PosRetorno: Integer;
begin
  DBXComand := SQLConnection.DBXConnection.CreateCommand;

  DBXComand.CommandType := TDBXCommandTypes.DSServerMethod;
  DBXComand.Text := Metodo;
  DBXComand.Prepare;

  QtdParamentro := DBXComand.Parameters.Count;
  if (QtdParamentro > 0) and (DBXComand.Parameters[QtdParamentro - 1].Name = 'ReturnParameter') then
  begin
    Dec(QtdParamentro);
    PosRetorno := QtdParamentro;
  end
  else
    PosRetorno := -1;

  try
    for I := 0 to QtdParamentro -1 do
    begin
      case DBXComand.Parameters[I].DataType of
          TDBXDataTypes.BooleanType:
            DBXComand.Parameters[I].Value.SetBoolean(Parametros[I]);
          TDBXDataTypes.CurrencyType:
            DBXComand.Parameters[I].Value.AsCurrency := StrToCurr(Parametros[I]);
          TDBXDataTypes.DateType,
            TDBXDataTypes.DateTimeType,
            TDBXDataTypes.TimeStampType:
            DBXComand.Parameters[I].Value.AsDateTime := StrToDateTime(Parametros[I]);
          TDBXDataTypes.DoubleType,
            TDBXDataTypes.BcdType:
            DBXComand.Parameters[I].Value.SetDouble(StrToCurr(Parametros[I]));
          TDBXDataTypes.UInt8Type,
            TDBXDataTypes.Int8Type:
            DBXComand.Parameters[I].Value.SetInt8(StrToInt(Parametros[I]));
          TDBXDataTypes.Int16Type:
            DBXComand.Parameters[I].Value.SetInt16(StrToInt(Parametros[I]));
          TDBXDataTypes.Int32Type:
            DBXComand.Parameters[I].Value.SetInt32(StrToInt(Parametros[I]));
          TDBXDataTypes.Int64Type,
            TDBXDataTypes.Uint64Type:
            DBXComand.Parameters[I].Value.SetInt64(StrToInt64(Parametros[I]));
          TDBXDataTypes.VariantType:
            DBXComand.Parameters[I].Value.AsVariant := Parametros[I];
          TDBXDataTypes.AnsiStringType:
            DBXComand.Parameters[I].Value.AsString := Parametros[I];
          TDBXDataTypes.WideStringType:
            DBXComand.Parameters[I].Value.SetWideString(Parametros[I]);
          TDBXDataTypes.BlobType,
            TDBXDataTypes.MemoSubType,
            TDBXDataTypes.BinaryBlobType:
            begin
              if VarIsArray(Parametros[I]) then
              begin
                MS := TMemoryStream.Create;
                MS.Size     := VarArrayHighBound(Parametros[I], 1) - VarArrayLowBound(Parametros[I], 1) + 1;
                MS.Position := 0;
                try
                  MS.Write(VarArrayLock(Parametros[I])^, MS.Size);
                finally
                  VarArrayUnlock(Parametros[I]);
                  MS.Position := 0;
                end;
              end
              else
                MS := TStringStream.Create(Parametros[I]);
              DBXComand.Parameters[I].Value.SetStream(MS, True);
              DBXComand.Parameters[I].Value.ValueType.ValueTypeFlags := DBXComand.Parameters[I].Value.ValueType.ValueTypeFlags or TDBXValueTypeFlags.ExtendedType;
            end;
        else
          raise Exception.Create('Tipo ' + TDBXValueType.DataTypeName(DBXComand.Parameters[I].DataType) + ' não preparado para o parâmetro ' + DBXComand.Parameters[I].Name);
      end;
    end;

    DBXComand.ExecuteUpdate;

    if (PosRetorno > -1) then
    begin

      case DBXComand.Parameters[PosRetorno].DataType of
          TDBXDataTypes.BooleanType:
            Result := DBXComand.Parameters[PosRetorno].Value.AsBoolean;
          TDBXDataTypes.CurrencyType:
            Result := DBXComand.Parameters[PosRetorno].Value.AsCurrency;
          TDBXDataTypes.DateType,
            TDBXDataTypes.DateTimeType,
            TDBXDataTypes.TimeStampType:
            Result := DBXComand.Parameters[PosRetorno].Value.AsDateTime;
          TDBXDataTypes.DoubleType,
            TDBXDataTypes.BcdType:
            Result := DBXComand.Parameters[PosRetorno].Value.AsDouble;
          TDBXDataTypes.UInt8Type,
            TDBXDataTypes.Int8Type:
            Result := DBXComand.Parameters[PosRetorno].Value.AsInt8;
          TDBXDataTypes.Int16Type:
            Result := DBXComand.Parameters[PosRetorno].Value.AsInt16;
          TDBXDataTypes.Int32Type:
            Result := DBXComand.Parameters[PosRetorno].Value.AsInt32;
          TDBXDataTypes.Int64Type,
            TDBXDataTypes.Uint64Type:
            Result := DBXComand.Parameters[PosRetorno].Value.AsInt64;
          TDBXDataTypes.VariantType:
            Result := DBXComand.Parameters[PosRetorno].Value.AsVariant;
          TDBXDataTypes.AnsiStringType:
            Result := DBXComand.Parameters[PosRetorno].Value.AsString;
          TDBXDataTypes.WideStringType:
            Result := DBXComand.Parameters[PosRetorno].Value.AsString;
        else
          raise Exception.Create('Tipo ' + TDBXValueType.DataTypeName(DBXComand.Parameters[PosRetorno].DataType) + ' não preparado para o parâmetro ' + DBXComand.Parameters[PosRetorno].Name);
        end;
    end;

  finally
    DBXComand.Free;
  end;

end;

function TDMConexao.ExecuteReader(Sql: String): Olevariant;
begin
  Result :=  DmConexao.ExecuteMethods('TSMConexao.ExecuteReader', [Sql])
end;

function TDMConexao.GetServerMethodsClient: TServerMethodsClient;
begin
  if FServerMethodsClient = nil then
  begin
    SQLConnection.Open;
    FServerMethodsClient := TServerMethodsClient.Create(SQLConnection.DBXConnection, FInstanceOwner);
  end;
  Result := FServerMethodsClient;
end;

end.

