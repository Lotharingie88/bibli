unit bibli_revsuiv;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls,bibli, System.Rtti, FMX.Grid.Style,
  FMX.ListBox, FMX.Header, FMX.Grid, FMX.ScrollBox,uDB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFbibli_revsuiv = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btQuit: TButton;
    Grid1: TGrid;
    Header1: THeader;
    Label1: TLabel;
    cbAnn: TComboBox;
    FDQuery1: TFDQuery;
    procedure btPrecClick(Sender: TObject);
    procedure btQuitClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Fbibli_revsuiv: TFbibli_revsuiv;

implementation

{$R *.fmx}
 uses bibli_revue;
procedure TFbibli_revsuiv.btPrecClick(Sender: TObject);
begin
     Fbibli_revue.Show();
     Fbibli_revsuiv.Close;
end;

procedure TFbibli_revsuiv.btQuitClick(Sender: TObject);
begin
     close;
end;

end.
