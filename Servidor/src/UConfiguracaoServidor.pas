unit UConfiguracaoServidor;

interface

uses
Winapi.Windows,
Winapi.Messages,
System.SysUtils,
System.Variants,
System.Classes,
Vcl.Graphics,
Vcl.Controls,
Vcl.Forms,
Vcl.Dialogs,
Vcl.ExtCtrls,
JvExExtCtrls,
JvExtComponent,
JvPanel,
JvExControls,
JvSpeedButton,
UServerContainer,
Vcl.StdCtrls,
JvExStdCtrls,
JvEdit,
System.IniFiles,
UInicializacao;

type
  TFConfigServidor = class(TForm)
    pvlGeral: TJvPanel;
    pnlRodape: TJvPanel;
    btnConfirmar: TJvSpeedButton;
    btnCancelar: TJvSpeedButton;
    pnlInfo: TJvPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtHostname: TJvEdit;
    edtPorta: TJvEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
  public
    iniAlterado : Boolean;

  end;

var
  FConfigServidor: TFConfigServidor;

implementation

{$R *.dfm}

procedure TFConfigServidor.btnCancelarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFConfigServidor.btnConfirmarClick(Sender: TObject);
var
  iniConfig:             TIniFile;
  DiretorioConfiguracao: string;
  ArquivoIni:            string;
begin
  DiretorioConfiguracao := UInicializacao.Retorna_Dir_Arq_Configuracao(tDiretorio);

  if not DirectoryExists(DiretorioConfiguracao) then
    ForceDirectories(DiretorioConfiguracao);

  ArquivoIni := UInicializacao.Retorna_Dir_Arq_Configuracao(tArquivo);
  iniConfig  := TIniFile.Create(ArquivoIni);
  try
    if not iniConfig.SectionExists('SERVER') then
    begin
      iniConfig.WriteString('SERVER','HOSTNAME',edtHostname.Text);
      iniConfig.WriteString('SERVER','PORTA',edtPorta.Text);
    end
    else
    begin
      if (Trim(edtPorta.Text) <> Trim(iniConfig.ReadString('SERVER','PORTA',''))) then
        iniConfig.WriteString('SERVER','PORTA',edtPorta.Text);
    end;
  finally
    iniConfig.Free;
  end;

  Self.Close;
end;


end.
