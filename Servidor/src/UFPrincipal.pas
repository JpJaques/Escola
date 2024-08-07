unit UFPrincipal;

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
JvImage,
Vcl.Imaging.pngimage,
JvShape,
JvComponentBase,
JvTrayIcon,
JvLabel,
Vcl.Menus,
JvMenus,
UServerContainer,
Vcl.StdCtrls,
UConfiguracaoServidor,
System.ImageList,
Vcl.ImgList,
JvImageList,
USMConexao,
UFConfDatabase,
Data.DB,
Vcl.Grids,
Vcl.DBGrids;

type
  TFPrincipal = class(TForm)
    pnlGeral: TJvPanel;
    pnlTopo: TJvPanel;
    btnFechar: TJvSpeedButton;
    pnlBody: TJvPanel;
    imgConfigServidor: TJvImage;
    shpServidor: TJvShape;
    imgConfigDatabase: TJvImage;
    imgConexoes: TJvImage;
    shpDatabase: TJvShape;
    shpConexoes: TJvShape;
    TrayIcon: TJvTrayIcon;
    lblDireitosReservados: TJvLabel;
    ppMenu: TJvPopupMenu;
    ppmFechar: TMenuItem;
    pnlStatusConexao: TJvPanel;
    JvLabel1: TJvLabel;
    pnlInformacoes: TJvPanel;
    lblMensagem: TLabel;
    lblTitulo: TLabel;
    imgStartPause: TJvImage;
    shpPlayPause: TJvShape;
    lblStatus: TJvLabel;
    imgList: TJvImageList;
    pnlConexoes: TJvPanel;
    lblCompilacao: TJvLabel;
    lblVersao: TJvLabel;
    GradeConexoes: TDBGrid;
    DS: TDataSource;
    procedure btnFecharClick(Sender: TObject);
    procedure ppmFecharClick(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure imgStartPauseMouseEnter(Sender: TObject);
    procedure imgStartPauseMouseLeave(Sender: TObject);
    procedure imgConfigDatabaseClick(Sender: TObject);
    procedure imgStartPauseClick(Sender: TObject);
    procedure imgConexoesClick(Sender: TObject);
    procedure pnlTopoMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure imgConfigServidorClick(Sender: TObject);
  private

    SMConexao         : TSMConexao;
    ServerContainer   : TServerContainer;
    HintTrayIcon      : string;
    FTesteConexao     : string;
    GConexoes         : Boolean;
    FConfirmaDBConf   : Boolean;
    procedure EsconderAplicacao;
    procedure MudaCursorImagem(Sender : TObject);
    procedure Inicializar;
    procedure IniciarAplicacao;
    procedure PararAplicacao;
    procedure MostrarConexoes;
    procedure Travar_Destravar_Imagens;


  public
    property Conexao : TSMConexao read SMConexao;
    property ConfirmaDBConf: Boolean read FConfirmaDBConf write FConfirmaDBConf;
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}


procedure TFPrincipal.btnFecharClick(Sender: TObject);
begin
  EsconderAplicacao;
  TrayIcon.HideApplication;
end;

procedure TFPrincipal.EsconderAplicacao;
begin
  WindowState := wsMinimized;
end;

procedure TFPrincipal.pnlTopoMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin
  Screen.Cursor := crSizeAll;
  ReleaseCapture;
  Self.Perform(wm_nclbuttondown,HTCAPTION,0);
  Screen.Cursor := crDefault;
end;

procedure TFPrincipal.ppmFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFPrincipal.imgStartPauseMouseEnter(Sender: TObject);
begin
 MudaCursorImagem(Sender);
end;

procedure TFPrincipal.imgStartPauseMouseLeave(Sender: TObject);
begin
  MudaCursorImagem(Sender);
end;

procedure TFPrincipal.MudaCursorImagem(Sender : TObject);
begin
  if Sender is TControl then
  begin
    if TControl(Sender).Tag = 0 then  //Mouse Enter
    begin
       TControl(Sender).Cursor := crHandPoint;
       TControl(Sender).Tag := 1;
    end
    else  //TAG VAIR SER 1 VOLTANDO O CURSOR PARA DAFAULT
    begin
      TControl(Sender).Tag := 0;
      TControl(Sender).Cursor := crDefault;
    end;

  end;
end;

procedure TFPrincipal.imgConexoesClick(Sender: TObject);
begin
  MostrarConexoes;
end;

procedure TFPrincipal.imgStartPauseClick(Sender: TObject);
begin
  if ServerContainer.DSServer.Started then
    PararAplicacao
  else
    Inicializar;
end;

procedure TFPrincipal.imgConfigDatabaseClick(Sender: TObject);
var
  FConfigDataBase : TFConfDatabase;
begin
  try
    FConfigDataBase := TFConfDatabase.Create(nil);
    FConfigDataBase.ShowModal;

    if not FConfirmaDBConf then
    Exit;

    FTesteConexao := EmptyStr;
    PararAplicacao;
    Inicializar;
  finally
    FConfigDataBase.Free;
  end;
end;

procedure TFPrincipal.imgConfigServidorClick(Sender: TObject);
var
  FConfServer : TFConfigServidor;
begin
  FConfServer := TFConfigServidor.Create(nil);
  try
    FConfServer.ShowModal;
    PararAplicacao;
    IniciarAplicacao;
  finally
    FConfServer.Free;
  end;
end;

procedure TFPrincipal.PararAplicacao;
begin
  imgStartPause.Picture.Bitmap := imgList.Items[1].Bitmap;
  imgStartPause.Hint           := 'INICIAR APLICAÇÃO';
  ServerContainer.DSServer.Stop;

  lblMensagem.Font.Name  := 'Segoe UI';
  lblMensagem.Font.Color := StringToColor('$2222B2');
  lblMensagem.Font.Size  := 10;
  lblMensagem.WordWrap   := True;
  lblMensagem.Alignment  := taLeftJustify;
  lblMensagem.Align      := alClient;
  lblMensagem.Caption    := FTesteConexao;
  lblStatus.Caption      := 'Servidor Desconectado';

  HintTrayIcon := lblStatus.Caption;
  TrayIcon.Hint  := HintTrayIcon;
end;

procedure TFPrincipal.Inicializar;
begin
  FTesteConexao := EmptyStr;
  FTesteConexao := SMConexao.TestaConexao;

  if (Trim(FTesteConexao).Equals(EmptyStr)) then
    IniciarAplicacao
  else
    PararAplicacao;

end;

procedure TFPrincipal.IniciarAplicacao;
begin
  imgStartPause.Picture.Bitmap := imgList.Items[0].Bitmap;
  imgStartPause.Hint           := 'PAUSAR APLICAÇÃO';

  try

    ServerContainer.DSServer.Start;

    lblStatus.Font.Name  := 'Segoe UI';
    lblStatus.Font.Color := StringToColor('$800000');
    lblStatus.Font.Size  := 12;
    lblStatus.WordWrap   := False;
    lblStatus.Alignment  := taLeftJustify;
    lblStatus.Caption    := 'Servidor Conectado!' + #13 + 'Porta: ' + ServerContainer.DSTCPServerTransport.Port.ToString;
    HintTrayIcon := lblStatus.Caption;
    TrayIcon.Hint  := HintTrayIcon;
  except
    on E:Exception do
    begin
      if Not (FTesteConexao.IsEmpty) then
        FTesteConexao := FTesteConexao + #13 + E.Message
      else
        FTesteConexao := E.Message;

      PararAplicacao;
    end;
  end;

end;

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  SMConexao            := TSMConexao.Create(Self);
  ServerContainer      := TServerContainer.Create(Self);
  Inicializar;
  Application.ShowHint := True;
  GConexoes            := False;
  EsconderAplicacao;
end;

procedure TFPrincipal.TrayIconDblClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Self.Show;
  TrayIcon.ShowApplication;
end;

procedure TFPrincipal.MostrarConexoes;
begin
  if not GConexoes  then
  begin
    Self.Height              := Self.Height + 150;
    pnlConexoes.Height       := 150;
    DS.DataSet               := SMConexao.CDSConexao;
    GradeConexoes.DataSource := DS;
    GConexoes                := True;
    Travar_Destravar_Imagens;

  end
  else
  begin
    Self.Height        := Self.Height - 150;
    pnlConexoes.Height := pnlConexoes.Height - 150;
    GConexoes          := False;
    Travar_Destravar_Imagens;
  end;

end;

procedure TFPrincipal.Travar_Destravar_Imagens;
var
  I : Integer;
begin
  if GConexoes then
  begin
    imgStartPause.Enabled     := False;
    imgConfigDatabase.Enabled := False;
    imgConfigServidor.Enabled := False;
  end
  else
  begin
    imgStartPause.Enabled     := True;
    imgConfigDatabase.Enabled := True;
    imgConfigServidor.Enabled := True;
  end;
end;

end.

