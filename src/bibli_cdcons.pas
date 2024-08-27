unit bibli_cdcons;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid,udb, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, Data.Bind.Controls,
  Fmx.Bind.Navigator;

type
  TFcdcons = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btQuit: TButton;
    Button3: TButton;
    Button4: TButton;
    sgCD: TStringGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    NavigatorBindSourceDB1: TBindNavigator;
    procedure btQuitClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Fcdcons: TFcdcons;

implementation

{$R *.fmx}
 uses bibli_cd;
procedure TFcdcons.btPrecClick(Sender: TObject);
begin
  fcd.show;
  fcdcons.close;
end;

procedure TFcdcons.btQuitClick(Sender: TObject);
begin
  Fcdcons.close;
end;

end.
