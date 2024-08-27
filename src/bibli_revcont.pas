unit bibli_revcont;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls,bibli, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid, FMX.Edit, FMX.ListBox, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,uDB;

type
  TFbibli_revcont = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btQuit: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cbTitre: TComboBox;
    edNum: TEdit;
    edPeriode: TEdit;
    Grid1: TGrid;
    Button1: TButton;
    FDQuery1: TFDQuery;
    procedure btPrecClick(Sender: TObject);
    procedure btQuitClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Fbibli_revcont: TFbibli_revcont;

implementation

{$R *.fmx}
  uses bibli_revue;
procedure TFbibli_revcont.btPrecClick(Sender: TObject);
begin
     Fbibli_revue.Show();
     Fbibli_revcont.Close;
end;

procedure TFbibli_revcont.btQuitClick(Sender: TObject);
begin
     Close;
end;

end.
