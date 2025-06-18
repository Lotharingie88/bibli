unit uDB;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.FMXUI.Wait, FireDAC.Comp.ScriptCommands,
  FireDAC.Stan.Util, FireDAC.Comp.Script, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL;

type
  TDataModule2 = class(TDataModule)
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDQuerProc: TFDQuery;
    FDScript1: TFDScript;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDConnectMysql: TFDConnection;
    FDQuerThem: TFDQuery;
    FDQuerFilm: TFDQuery;
    FDQuerAct: TFDQuery;
    FDQuerReal: TFDQuery;
    FDQuerMes: TFDQuery;
    FDTabPays: TFDTable;
    FDTabGenre: TFDTable;
    FDConnectSqlite: TFDConnection;
    FDQuerNomAct: TFDQuery;
    FDQuerLivr: TFDQuery;
    FDQuerEdit: TFDQuery;
    FDQuerEdiP: TFDQuery;
    FDQuerThemL: TFDQuery;
    FDQuerCd: TFDQuery;
    FDQuerRev: TFDQuery;
    FDQuerUser: TFDQuery;
    FDQuerAuteur: TFDQuery;
    FDQuerDvdActRealGenre: TFDQuery;
    FDQuerNomRealScec: TFDQuery;
    FDQuerAct2: TFDQuery;
    FDQuerActiv: TFDQuery;
    FDQuerProf: TFDQuery;
    FDQuerProc2: TFDQuery;
    FDQuerAct3: TFDQuery;
    FDQuerLivBas: TFDQuery;
    FDQuerChant: TFDQuery;
    FDQuerPerio: TFDQuery;
    FDQuerThemCd: TFDQuery;
    FDQuerCdGlob: TFDQuery;
    FDQuerContRev: TFDQuery;
    FDStoredProc1: TFDStoredProc;
    FDQuerAutrev: TFDQuery;
    procedure FDConnectMysqlBeforeConnect(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DataModule2: TDataModule2;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDataModule2.FDConnectMysqlBeforeConnect(Sender: TObject);
begin
  {$IFDEF WIN32}
    FDPhysMySQLDriverLink1.Vendorlib:='C:\user\GitLocal\bibli\src\libmysql.dll'

  {$ELSE WIN64}
    FDPhysMySQLDriverLink1.Vendorlib:='C:\user\GitLocal\bibli\src\libmysql.dll';
    {$ENDIF}
  //{$ELSE}
  //{$MESSAGE};
end;

end.
