unit bibli_revue;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation,bibli;

type
  TFbibli_revue = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btQuit: TButton;
    btRevaj: TButton;
    btRSuiv: TButton;
    btRAch: TButton;
    btRNum: TButton;
    btEmpr: TButton;
    btAbo: TButton;
    procedure btQuitClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);
    procedure btRevajClick(Sender: TObject);
    procedure btRSuivClick(Sender: TObject);
    procedure btRAchClick(Sender: TObject);
    procedure btRNumClick(Sender: TObject);
    procedure btEmprClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Fbibli_revue: TFbibli_revue;

implementation

{$R *.fmx}

 uses bibli_revaj,bibli_revsuiv,bibli_revach,bibli_revcont,bibli_livpret;
procedure TFbibli_revue.btEmprClick(Sender: TObject);
begin
  fpret.Tag:=3;
  Fpret.Show;
end;

procedure TFbibli_revue.btPrecClick(Sender: TObject);
begin
 FBibli.Show;
end;

procedure TFbibli_revue.btQuitClick(Sender: TObject);
begin
     close;
end;

procedure TFbibli_revue.btRAchClick(Sender: TObject);
begin
     Fbibli_revach.Show();
end;

procedure TFbibli_revue.btRevajClick(Sender: TObject);
begin
  Fbibli_revaj.Show;
end;

procedure TFbibli_revue.btRNumClick(Sender: TObject);
begin
     Fbibli_revcont.Show();
end;

procedure TFbibli_revue.btRSuivClick(Sender: TObject);
begin
  Fbibli_revsuiv.show();
end;

end.
