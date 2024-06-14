unit UFSplash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFrmSplash = class(TForm)
    ImagemFundo: TImage;
    ImageLogo: TImage;
    lblLogo: TLabel;
    pb: TProgressBar;
    Label1: TLabel;
    lblSplash: TLabel;
  private
    { Private declarations }
  public
    procedure Passo(Percentual: Integer; S: string);
  end;

var
  FrmSplash: TFrmSplash;

implementation

{$R *.dfm}

{ TForm1 }

procedure TFrmSplash.Passo(Percentual: Integer; S: string);
begin
  pb.Position := Percentual;
  lblSplash.Caption := S;
  lblSplash.Refresh;
  Sleep(400);
end;

end.
