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
UInicializacao,
Data.DB,
Vcl.Grids,
Vcl.DBGrids,
UMensagens;

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
    procedure TrayIconDblClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgConfigServidorMouseEnter(Sender: TObject);
    procedure imgConfigServidorMouseLeave(Sender: TObject);
    procedure imgConfigServidorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgConfigDatabaseMouseEnter(Sender: TObject);
    procedure imgConfigDatabaseMouseLeave(Sender: TObject);
    procedure imgConexoesMouseLeave(Sender: TObject);
    procedure imgConexoesMouseEnter(Sender: TObject);
    procedure imgStartPauseMouseEnter(Sender: TObject);
    procedure imgStartPauseMouseLeave(Sender: TObject);
    procedure imgConfigDatabaseClick(Sender: TObject);
    procedure imgStartPauseClick(Sender: TObject);
    procedure imgConexoesClick(Sender: TObject);
    procedure pnlTopoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    MsgRetornoInicializacao : string;
    AplicacaoIniciada       : Boolean;
    SMConexao               : TSMConexao;
    ServerContainer         : TServerContainer;
    HintTrayIcon            : string;
    GConexoes           : Boolean;
    procedure EsconderAplicacao;
    procedure ExibirMensagensStatus;
    procedure MudaCursorImagem(Sender : TObject);
    procedure Inicializar;
    procedure PararAplicacao;
    procedure MostrarConexoes;
    procedure Travar_Destravar_Imagens;


  public

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

procedure TFPrincipal.ExibirMensagensStatus;
begin
  if (Trim(lblMensagem.Caption) <> '') then
    lblMensagem.Caption := '';

  if (Trim(lblStatus.Caption) <> '') then
    lblStatus.Caption := '';

  if not (ServerContainer.DSServer.Started) or
    (Trim(MsgRetornoInicializacao) <> Conexao_Realizada) then
  begin
    lblMensagem.Font.Name  := 'Segoe UI';
    lblMensagem.Font.Color := StringToColor('$2222B2');
    lblMensagem.Font.Size  := 10;
    lblMensagem.WordWrap   := True;
    lblMensagem.Alignment  := taLeftJustify;
    lblMensagem.Align      := alClient;
    lblMensagem.Caption    := MsgRetornoInicializacao;
    lblStatus.Caption      := ServidorDesconectado;

  end
  else
  begin

      lblStatus.Font.Name  := 'Segoe UI';
      lblStatus.Font.Color := StringToColor('$800000');
      lblStatus.Font.Size  := 12;
      lblStatus.WordWrap   := False;
      lblStatus.Alignment  := taLeftJustify;
      lblStatus.Caption    := Format(ServidorConectado,[IntToStr(ServerContainer.DSTCPServerTransport.Port)]);
  end;
  HintTrayIcon := lblStatus.Caption;
  TrayIcon.Hint  := HintTrayIcon;
end;

procedure TFPrincipal.pnlTopoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
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

{$REGION ' Configuração CURSOR MOUSE BOTOES'}

procedure TFPrincipal.imgConfigServidorMouseEnter(Sender: TObject);
begin
  MudaCursorImagem(Sender);
end;

procedure TFPrincipal.imgConfigServidorMouseLeave(Sender: TObject);
begin
  MudaCursorImagem(Sender);
end;

procedure TFPrincipal.imgStartPauseClick(Sender: TObject);
begin
  if ServerContainer.DSServer.Started then
    PararAplicacao
  else
    Inicializar;
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
  if Sender is TJvImage then
  begin
    if TJvImage(Sender).Tag = 0 then  //Mouse Enter
    begin
       TJvImage(Sender).Cursor := crHandPoint;
       TJvImage(Sender).Tag := 1;
    end
    else  //TAG VAIR SER 1 VOLTANDO O CURSOR PARA DAFAULT
    begin
      TJvImage(Sender).Tag := 0;
      TJvImage(Sender).Cursor := crDefault;
    end;

  end;

end;

procedure TFPrincipal.imgConexoesClick(Sender: TObject);
begin
  MostrarConexoes;
end;

procedure TFPrincipal.imgConexoesMouseEnter(Sender: TObject);
begin
  MudaCursorImagem(Sender);
end;

procedure TFPrincipal.imgConexoesMouseLeave(Sender: TObject);
begin
  MudaCursorImagem(Sender);
end;

procedure TFPrincipal.imgConfigDatabaseMouseEnter(Sender: TObject);
begin
  MudaCursorImagem(Sender);
end;

procedure TFPrincipal.imgConfigDatabaseMouseLeave(Sender: TObject);
begin
  MudaCursorImagem(Sender);
end;

{$ENDREGION}

procedure TFPrincipal.imgConfigDatabaseClick(Sender: TObject);
var
  FConfigDataBase : TFConfDatabase;
begin
  try
    FConfigDataBase := TFConfDatabase.Create(nil);
    PararAplicacao;
    FConfigDataBase.ShowModal;
    Inicializar;
  finally
    FConfigDataBase.Free;
  end;
end;

procedure TFPrincipal.PararAplicacao;
begin
  imgStartPause.Picture.Bitmap := imgList.Items[1].Bitmap;
  imgStartPause.Hint           := 'INICIAR APLICAÇÃO';
  ServerContainer.DSServer.Stop;
  ExibirMensagensStatus;
end;

procedure TFPrincipal.Inicializar;
begin
  MsgRetornoInicializacao := '';
  MsgRetornoInicializacao := Inicializacao;

  if (Trim(MsgRetornoInicializacao) = Conexao_Realizada) then
  begin
    imgStartPause.Picture.Bitmap := imgList.Items[0].Bitmap;
    imgStartPause.Hint           := 'PAUSAR APLICAÇÃO';
    ServerContainer.DSServer.Start;
  end
  else
    PararAplicacao;

  ExibirMensagensStatus;
end;

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  SMConexao            := TSMConexao.Create(Self);
  ServerContainer      := TServerContainer.Create(Self);
  //AplicacaoIniciada    := True;
  Inicializar;
  Application.ShowHint := True;
  //AplicacaoIniciada    := False;
  GConexoes            := False;
  EsconderAplicacao;
end;

procedure TFPrincipal.imgConfigServidorClick(Sender: TObject);
var
  FConfServer : TFConfigServidor;
begin
  FConfServer := TFConfigServidor.Create(nil);
  try
    PararAplicacao;
    FConfServer.ShowModal;
    Inicializar;
  finally
    FConfServer.Free;
  end;
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
    {
    for I := 0 to FPrincipal.ComponentCount do
      if FPrincipal.Components[I] is TJvImage then
        if not (FPrincipal.Components[I].Name = 'imgConexoes') then
          TJvImage(FPrincipal.Components[I]).Enabled := False;
     }//CODIGO ACIMA DÁ OUT OF ARGUMENT --- ANALISANDO

    imgStartPause.Enabled     := False;
    imgConfigDatabase.Enabled := False;
    imgConfigServidor.Enabled := False;
  end
  else
  begin
    {
    for I:= 0 to FPrincipal.ComponentCount do
      if FPrincipal.Components[I] is TJvImage then
        if not (FPrincipal.Components[I].Name = 'imgConexoes') then
          TJvImage(I).Enabled := True;
    } //CODIGO ACIMA DÁ OUT OF ARGUMENT --- ANALISANDO

    imgStartPause.Enabled     := True;
    imgConfigDatabase.Enabled := True;
    imgConfigServidor.Enabled := True;
  end;
end;

end.

