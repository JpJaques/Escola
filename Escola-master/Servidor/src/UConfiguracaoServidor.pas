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
Vcl.StdCtrls,
JvExStdCtrls,
JvEdit,
System.IniFiles;

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
    procedure pnlInfoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
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
  DiretorioConfiguracao := ExtractFilePath(Application.ExeName) + 'CONF\';

  if not DirectoryExists(DiretorioConfiguracao) then
    ForceDirectories(DiretorioConfiguracao);

  ArquivoIni := ChangeFileExt(ExtractFilePath(Application.ExeName)+'CONF\Configuracao','.ini');
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

procedure TFConfigServidor.pnlInfoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Screen.Cursor := crSizeAll;
  ReleaseCapture;
  Self.Perform(wm_nclbuttondown,HTCAPTION,0);
  Screen.Cursor := crDefault;
end;

end.
