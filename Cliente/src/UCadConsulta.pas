unit UCadConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  ClassPaiCadastro, UDMConexao;

type
  TFConsulta = class(TForm)
    Painel_Superior: TPanel;
    Pesquisabutton: TSpeedButton;
    BOTAOCONFIRMAR: TSpeedButton;
    ccbPEQUISA: TComboBox;
    edtvalor: TEdit;
    JvDBGrid1: TJvDBGrid;
    DS: TDataSource;
    CDSPESQUISA: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure BOTAOCONFIRMARClick(Sender: TObject);
    procedure PesquisabuttonClick(Sender: TObject);

  private
    FclassConsulta: TClassPaiCadastro;
    FretornoConsulta: Integer;
    Function MontarSQLConsulta: String;
    Function GETCampoBD: TField;

  public
    FclassFilha: TClassPaiCadastro;
    property ClassConsulta: TClassPaiCadastro read FclassConsulta write FclassConsulta;
    Property RetornoConsulta: Integer read FretornoConsulta write FretornoConsulta;
  end;

var
  FConsulta: TFConsulta;

implementation

{$R *.dfm}

procedure TFConsulta.FormShow(Sender: TObject);
var
  Field: TField;
begin
  Self.Caption := Self.Caption + FclassFilha.Tabela;
  CDSPESQUISA.Data:= DMConexao.ExecuteReader(FclassFilha.SQlConsulta + ' where ' + FclassFilha.CampoCodigo + ' < 0');
  FclassFilha.ConfigurarPropriedadesDosCampos(CDSPESQUISA.Fields);
  ccbPEQUISA.Items.Clear;
    for Field in CDSPESQUISA.Fields do
     ccbPEQUISA.Items.Add(Field.Displaylabel);
  ccbPEQUISA.ItemIndex:= 0;
end;

function TFConsulta.GETCampoBD: TField;
var
  Field: TField;
begin
  for Field in CDSPESQUISA.Fields do
   begin
    if Field.DisplayName = ccbPEQUISA.Text then
    begin
      Result := Field;
      exit
    end;

  end;

end;

function TFConsulta.MontarSQLConsulta: String;
var
  SQL,TESTE, Valor: String;
  Field: TField;
begin
 SQL:= FclassFilha.SQlConsulta +#13;
 if edtvalor.Text <> '' then
 begin
   Field:= GETCampoBD;
   if (Field.DataType = ftInteger) then BEGIN
   Valor:= edtvalor.Text;
   SQL:= SQL + 'where ' + Field.fieldname + ' = ' + Valor
   END
   else if (Field.DataType = ftString) then BEGIN
   valor:= (edtvalor.Text);
   SQL:= SQL + 'where ' + Field.fieldname + ' like ' + quotedStr('%' + Valor + '%');
   TESTE:= sql;
   END;
  // SQL:= SQL + 'where ' + Field.fieldname + ' = ' + Valor;
 end;
 Result := SQL;


end;

procedure TFConsulta.PesquisabuttonClick(Sender: TObject);
begin
  CDSPESQUISA.Data := DMConexao.ExecuteReader(MontarSQLConsulta);
 // FclassFilha.ConfigurarNomesCampos(CDSPESQUISA.Fields);
 // for Field in CDSPESQUISA.Fields do
 //   ccbPEQUISA.Items.Add(Field.Displaylabel);
end;

procedure TFConsulta.BOTAOCONFIRMARClick(Sender: TObject);
begin
  FretornoConsulta:= CDSPESQUISA.FieldByName(FclassFilha.CampoCodigo).AsInteger;
  Close;
end;

end.
