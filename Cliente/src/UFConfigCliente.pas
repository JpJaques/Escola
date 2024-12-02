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
UInicializacao, Vcl.ValEdit;

type
  TFConfigCliente = class(TForm)
    pnlGeral: TJvPanel;
    btnGravar: TJvSpeedButton;
    btnCancelar: TJvSpeedButton;
    Panel1: TPanel;
    VlServer: TValueListEditor;
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    const
      SERVER = 'SERVIDOR';
      PORT   = 'PORTA';
      HOST   = 'HOSTNAME';

    var

      FINI: TIniFile;
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
  I: Integer;
begin
  for I := Low(VlServer.RowCount) to High(VlServer.RowCount) do
  begin
     FINI.DeleteKey(SERVER,VlServer.Keys[I]);
     FINI.WriteString(SERVER,VlServer.Keys[I], VlServer.Values[VlServer.Keys[I]]);
  end;

  Close;
end;

procedure TFConfigCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FINI.Free;
  Action := caFree;
end;

procedure TFConfigCliente.FormCreate(Sender: TObject);
var  Diretorio, Arquivo : string;
begin
  Diretorio := UInicializacao.RetornaDiretorio(tDiretorio);
  if Not DirectoryExists(Diretorio) then
    ForceDirectories(Diretorio);

  Arquivo := UInicializacao.RetornaDiretorio(tArquivo);
  FINI    := TIniFile.Create(Arquivo);
end;

procedure TFConfigCliente.FormShow(Sender: TObject);
begin
  VlServer.Strings.Clear;
  VlServer.Strings.Add('HostName=' + FINI.ReadString(SERVER,HOST,'LocalHost'));
  VlServer.Strings.Add('Port=' + FINI.ReadString(SERVER,PORT,'3055'));
end;

end.
