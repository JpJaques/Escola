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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

end.
