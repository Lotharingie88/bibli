unit bibli_liv1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts,bibli;

type
  TFLiv = class(TForm)
    btLivBas: TButton;
    btAuteur: TButton;
    btEditMaj: TButton;
    btLivMaj: TButton;
    btPret: TButton;
    btAcha: TButton;
    btPrec: TButton;
    btQuit: TButton;
    Layout1: TLayout;
    ToolBar1: TToolBar;
    procedure btQuitClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);

    procedure btLivBasClick(Sender: TObject);
    procedure btAuteurClick(Sender: TObject);
    procedure btLivMajClick(Sender: TObject);
    procedure btEditMajClick(Sender: TObject);
    procedure btPretClick(Sender: TObject);
    procedure btAchaClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FLiv: TFLiv;

implementation

{$R *.fmx}
uses bibli_livAut,bibli_livcons,bibli_livaj,bibli_livedi,bibli_livpret,bibli_livachat;
procedure TFLiv.btAchaClick(Sender: TObject);
begin
FLacha.Show;
end;

procedure TFLiv.btAuteurClick(Sender: TObject);
begin

Fauteur.CbNAut.Visible:=True;
FAuteur.edNomAut.Visible:=False;
FAuteur.btrec.enabled:=False;
FAuteur.Show;
end;

procedure TFLiv.btEditMajClick(Sender: TObject);
begin
FEdit.Show;
end;

procedure TFLiv.btLivBasClick(Sender: TObject);
begin
Flivcons.show;
end;



procedure TFLiv.btLivMajClick(Sender: TObject);
begin
 Flivaj.Show;
end;

procedure TFLiv.btPrecClick(Sender: TObject);
begin
 FBibli.Show;
 fLiv.Close;
end;

procedure TFLiv.btPretClick(Sender: TObject);
begin
  fpret.Tag:=2;
 Fpret.Show;
end;

procedure TFLiv.btQuitClick(Sender: TObject);
begin
close();
end;

end.
