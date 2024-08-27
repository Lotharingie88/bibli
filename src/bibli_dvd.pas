unit bibli_dvd;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,bibli,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFdvd = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btQuit: TButton;
    btDvdcons: TButton;
    btDvdact: TButton;
    btDvdajo: TButton;
    btDvdreal: TButton;
    btDvdempr: TButton;
    btDvdach: TButton;
    procedure btQuitClick(Sender: TObject);
    procedure btDvdconsClick(Sender: TObject);
    procedure btDvdajoClick(Sender: TObject);
    procedure btDvdactClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);
    procedure btDvdrealClick(Sender: TObject);
    procedure btDvdachClick(Sender: TObject);
    procedure btDvdemprClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Fdvd: TFdvd;

implementation

{$R *.fmx}
uses bibli_dvdcons,bibli_dvdaj,bibli_DvdAct,bibli_dvdrea,bibli_dvdajo,bibli_dvdacha,bibli_livpret;

procedure TFdvd.btDvdachClick(Sender: TObject);
begin
 fdvdacha.show;
end;

procedure TFdvd.btDvdactClick(Sender: TObject);
begin
  fdvdact.tag:=1;
  fdvdact.Caption:='DVD Acteur';
  fdvdact.cbNom.Visible:=true;
 fdvdact.Show;
end;

procedure TFdvd.btDvdajoClick(Sender: TObject);
begin
 //fdvdaj.Show;
 fdvdajo.Show;
end;

procedure TFdvd.btDvdconsClick(Sender: TObject);
begin
 fdvdcons.Show;
end;

procedure TFdvd.btDvdemprClick(Sender: TObject);
begin
  fpret.Tag:=4;
  Fpret.Show;
end;

procedure TFdvd.btDvdrealClick(Sender: TObject);
begin
  fdvdact.tag:=3;
  fdvdact.Caption :='DVD Realisateur_Metteur en Scène';
  fdvdact.cbReal.Visible:=true;
  fdvdact.Show;
end;

procedure TFdvd.btPrecClick(Sender: TObject);
begin
  fbibli.Show;
  fdvd.Close;
end;

procedure TFdvd.btQuitClick(Sender: TObject);
begin
  close;
end;





end.
