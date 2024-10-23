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
UIniConfigServer;


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
    Panel1: TPanel;
    edtPorta: TJvEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FIni : TIniConfigServer;
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
begin
 if not FIni.GetHostName.Equals(edtHostname.Text) then
  FIni.SetHostname(edtHostname.Text);

 if not FIni.GetPorta.ToString.Equals(edtPorta.Text) then
  FIni.SetPorta(edtPorta.Text);

  Self.Close;
end;

procedure TFConfigServidor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FIni.Free;
end;

procedure TFConfigServidor.FormCreate(Sender: TObject);
begin
  FIni := TIniConfigServer.Create;
end;

procedure TFConfigServidor.FormShow(Sender: TObject);
begin
  edtHostname.Text := FIni.GetHostname;
  edtPorta.Text    := FIni.GetPorta.ToString;
end;

procedure TFConfigServidor.Panel1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Screen.Cursor := crDefault;
  ReleaseCapture;
  Self.Perform(wm_nclbuttondown,HTCAPTION,0);
  Screen.Cursor := crDefault;

end;

end.
