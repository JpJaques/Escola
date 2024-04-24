unit UFLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JvExStdCtrls, JvEdit,
  Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmLogin = class(TForm)
    PnlPrincipal: TPanel;
    gbxPrincipal: TGroupBox;
    Image1: TImage;
    imgSenha: TImage;
    btnLogar: TSpeedButton;
    edtLogin: TJvEdit;
    edtSenha: TJvEdit;
    procedure btnLogarClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  UFPrincipal, UDMConexao;

{$R *.dfm}


procedure TfrmLogin.btnLogarClick(Sender: TObject);
var
  FPrincipal: TFPrincipal;
  Usuario: String;
begin
  Usuario := edtLogin.Text;

  if (DMConexao.Logar(edtLogin.Text, edtSenha.Text) = True) then
  begin
    frmLogin.Close;
    Application.CreateForm(TFPrincipal, FPrincipal);
  end ;

end;

end.
