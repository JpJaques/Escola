unit UFConfigCliente;

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
Vcl.Grids,
JvExControls,
JvSpeedButton,
Vcl.StdCtrls,
JvExStdCtrls,
JvEdit,
System.IniFiles,
UInicializacao;

type
  TFConfigCliente = class(TForm)
    pnlGeral: TJvPanel;
    btnGravar: TJvSpeedButton;
    btnCancelar: TJvSpeedButton;
    edtHostname: TJvEdit;
    edtPorta: TJvEdit;
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FConfigCliente: TFConfigCliente;

implementation

{$R *.dfm}

procedure TFConfigCliente.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFConfigCliente.btnGravarClick(Sender: TObject);
var
  INI : TIniFile;
  Diretorio, Arquivo : string;
begin
  Diretorio := UInicializacao.RetornaDiretorio(tDiretorio);
  if Not DirectoryExists(Diretorio) then
    ForceDirectories(Diretorio);

  Arquivo   := UInicializacao.RetornaDiretorio(tArquivo);
  INI       := TIniFile.Create(Arquivo);
  try
    if (edtHostname.Text <> INI.ReadString('SERVIDOR','HOSTNAME','')) then
      INI.WriteString('SERVIDOR', 'HOSTNAME',edtHostname.Text)
    else if (edtPorta.Text <> INI.ReadString('SERVIDOR','PORTA','')) then
      INI.WriteString('SERVIDOR', 'PORTA',edtPorta.Text);
  finally
   INI.Free;
  end;

  Close;
end;

procedure TFConfigCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(self);
end;

end.
