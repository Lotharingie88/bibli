unit bibli_cd;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,bibli,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFcd = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btQuit: TButton;
    btCons: TButton;
    btIntaj: TButton;
    btCdaj: TButton;
    Button6: TButton;
    btPret: TButton;
    btCdach: TButton;
    procedure btPretClick(Sender: TObject);
    procedure btQuitClick(Sender: TObject);
    procedure btIntajClick(Sender: TObject);
    procedure btConsClick(Sender: TObject);
    procedure btCdajClick(Sender: TObject);
    procedure btCdachClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Fcd: TFcd;

implementation

{$R *.fmx}
  uses bibli_livpret,bibli_dvdact,bibli_cdcons,bibli_cdaj,bibli_cdach;
procedure TFcd.btQuitClick(Sender: TObject);
begin
  close;
end;

procedure TFcd.btConsClick(Sender: TObject);
begin
  fcdcons.show;
end;

procedure TFcd.btIntajClick(Sender: TObject);
begin
  fdvdact.tag:=2;
  fdvdact.Caption:='CD Interprète';
  fdvdact.cbInterp.Visible:=true;
  fdvdact.Show;
end;

procedure TFcd.btCdajClick(Sender: TObject);
begin
  fcdaj.show;
end;

procedure TFcd.btCdachClick(Sender: TObject);
begin
  fcdach.show;
end;

procedure TFcd.btPrecClick(Sender: TObject);
begin
  fbibli.Show;
  fcd.Close;
end;

procedure TFcd.btPretClick(Sender: TObject);
begin
  fpret.Tag:=5;
  Fpret.Show;
end;

end.
