unit ClassPaiCadastro;

interface

uses
  Data.SqlExpr, Data.DB;

type
  TClassPaiCadastro = class
  public
    class function CampoCodigo: String; virtual;
    class function Tabela: String; virtual;
    class function Descricao: String; virtual;
    class function SqlCadastro: String; virtual;
    class function SqlConsulta: String; virtual;
    class function SqlRelatorio: String; virtual;
    class procedure ConfigurarPropriedadesDosCampos(Fields: TFields); virtual;
    class procedure CriarParametro(SQLDataSet: TSQLDataSet); virtual;
  end;

implementation

{ TClassPaiCadastro }

{ TClassPaiCadastro }

class function TClassPaiCadastro.CampoCodigo: String;
begin
 //
end;

class procedure TClassPaiCadastro.ConfigurarPropriedadesDosCampos(Fields: TFields);
begin
  //
end;

class procedure TClassPaiCadastro.CriarParametro(SQLDataSet: TSQLDataSet);
begin
  SQLDataSet.Params.Clear;
  SQLDataSet.Params.Add;
  SQLDataSet.Params[0].Name      := 'COD';
  SQLDataSet.Params[0].DataType  := ftInteger;
  SQLDataSet.Params[0].ParamType := ptInput;
  SQLDataSet.Params[0].Value     := 0;
end;

class function TClassPaiCadastro.Descricao: String;
begin
  //
end;

class function TClassPaiCadastro.SqlCadastro: String;
begin
  //
end;

class function TClassPaiCadastro.SqlConsulta: String;
begin
  //
end;

class function TClassPaiCadastro.SqlRelatorio: String;
begin
  //
end;

class function TClassPaiCadastro.Tabela: String;
begin
 //
end;

end.
