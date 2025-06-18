unit bibli_livcons;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  System.Rtti, FMX.Grid.Style, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Grid, FMX.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.Bind.Controls,
  Fmx.Bind.Navigator,uDB;

type
  TFlivcons = class(TForm)
    Layout1: TLayout;
    StringGrid1: TStringGrid;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btQuit: TButton;
    Button3: TButton;
    Button4: TButton;
    BindingsList1: TBindingsList;
    NavigatorBindSourceDB1: TBindNavigator;
    BindSourceDB2: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    procedure btQuitClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Flivcons: TFlivcons;

implementation

{$R *.fmx}
 uses bibli_liv1;
procedure TFlivcons.btPrecClick(Sender: TObject);
begin
  FLiv.Show;
  flivcons.Close;
end;

procedure TFlivcons.btQuitClick(Sender: TObject);
begin
close();
end;

end.
