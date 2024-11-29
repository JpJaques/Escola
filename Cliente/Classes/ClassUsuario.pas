unit ClassUsuario;

interface

uses
  Data.SqlExpr, Data.DB, ClassPaiCadastro;

type
  TClassUsuario = class(TClassPaiCadastro)
  public
    class function CampoCodigo: String; override;
    class function Tabela: String; override;

    class function SqlCadastro: String; override;
    class function SqlConsulta: string; override;
    class function SqlRelatorio: string; override;

    class procedure ConfigurarPropriedadesDosCampos(Fields: TFields); override;
    class function Descricao: string; override;

  end;

implementation

{ TClassCidade }

class function TClassUsuario.CampoCodigo: String;
begin
  Result := 'COD_USUARIO';
end;

class function TClassUsuario.Tabela: String;
begin
  Result := 'USUARIO';
end;

class procedure TClassUsuario.ConfigurarPropriedadesDosCampos(Fields: TFields);
var
  Field: TField;
begin
  for Field in Fields do
  begin
     if Field.FieldName = 'COD_USUARIO' then
       Field.DisplayLabel := 'Código'
     else if Field.FieldName = 'NOME_USUARIO' then
       Field.DisplayLabel := 'Usuário'
     else if Field.FieldName = 'SENHA_USUARIO' then
       Field.DisplayLabel := 'SENHA';
  end;
  inherited;

end;

class function TClassUsuario.Descricao: string;
begin
  Result := 'Usuário';
end;

class function TClassUsuario.SqlCadastro: String;
begin
  Result := 'select USUARIO.COD_USUARIO,'       +#13+
                   'USUARIO.NOME_USUARIO,'      +#13+
                   'USUARIO.SENHA_USUARIO'      +#13+
              'from USUARIO'                    +#13+
             'where USUARIO.COD_USUARIO = :COD';
end;



class function TClassUsuario.SqlConsulta: string;
begin
  Result := 'select USUARIO.COD_USUARIO,'       +#13+
                   'USUARIO.NOME_USUARIO,'      +#13+
                   'USUARIO.SENHA_USUARIO'      +#13+
              'from USUARIO'                    ;
end;

class function TClassUsuario.SqlRelatorio: string;
begin
  Result := 'select USUARIO.COD_USUARIO,'       +#13+
                   'USUARIO.NOME_USUARIO,'      +#13+
                   'USUARIO.SENHA_USUARIO'      +#13+
              'from USUARIO'                    ;
end;

end.
