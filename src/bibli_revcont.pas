unit bibli_revcont;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls,bibli, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid, FMX.Edit, FMX.ListBox, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,uDB,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.Memo.Types,
  FMX.Memo, Fmx.Bind.Grid, Data.Bind.Controls, Fmx.Bind.Navigator,
  Data.Bind.Grid;

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
    btRec: TButton;
    FDQuery1: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    memArtic: TMemo;
    BindSourceDB2: TBindSourceDB;
    navRevu: TBindNavigator;
    StringGrid1: TStringGrid;
    cbNum: TComboBox;
    cbPerio: TComboBox;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    procedure btPrecClick(Sender: TObject);
    procedure btQuitClick(Sender: TObject);
    procedure btRecClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbTitreChange(Sender: TObject);
    procedure cbNumChange(Sender: TObject);
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
  var
    req,datmaj:string;
procedure TFbibli_revcont.btPrecClick(Sender: TObject);
begin
     Fbibli_revue.Show();
     Fbibli_revcont.Close;
end;

procedure TFbibli_revcont.btQuitClick(Sender: TObject);
begin
     Close;
end;

procedure TFbibli_revcont.btRecClick(Sender: TObject);
begin
  if cbTitre.Selected.Text<>'' then
  begin
//     datamodule2.FDQuerProc.Close;
//     datamodule2.FDQuerProc.SQL.Clear;
//      req:='select idarticle, titrearticle,b.auteur,datparut,digest,a.datmaj,c.theme';
//      req:=req+ ' from  articles as a left join auteur as b on a.idauteurarticl=b.idauteur left join thematique as c on a.idthem=c.idtheme left join achrev as d on a.idrevuebibli=d.idachev' ;
//      req:= req + ' left join editionpoche as e on a.ideditionpoche=e.ideditionpoche left join editeur as f on a.idediteur=f.idediteur where titre =:tit';
//     datamodule2.FDQuerProc.SQL.text:= req;
//     datamodule2.FDQuerProc.ParamByName('tit').AsString := cbTitre.Selected.Text;
//     datamodule2.FDQuerProc.Open;


  end;
end;

procedure TFbibli_revcont.cbNumChange(Sender: TObject);
begin
   if cbNum.Selected.Text<>'' then
    begin

    end;
end;

procedure TFbibli_revcont.cbTitreChange(Sender: TObject);
begin
    if cbTitre.Selected.Text<>'' then
  begin
//     datamodule2.FDQuerProc.Close;
//     datamodule2.FDQuerProc.SQL.Clear;
//      req:='select idarticle, titrearticle,b.auteur,datparut,digest,a.datmaj,c.theme';
//      req:=req+ ' from  articles as a left join auteur as b on a.idauteurarticl=b.idauteur left join thematique as c on a.idthem=c.idtheme left join achrev as d on a.idrevuebibli=d.idachev' ;
//      req:= req + ' left join editionpoche as e on a.ideditionpoche=e.ideditionpoche left join editeur as f on a.idediteur=f.idediteur where titre =:tit';
//     datamodule2.FDQuerProc.SQL.text:= req;
//     datamodule2.FDQuerProc.ParamByName('tit').AsString := cbTitre.Selected.Text;
//     datamodule2.FDQuerProc.Open;
//     datamodule2.FDQuerProc.Close;
     cbNum.items.clear();
     datamodule2.FDQuerProc.SQL.Clear;
      req:='select numrevue';
      req:=req+ ' from  achrev as a left join revues as b on a.idrev=b.idrevue' ;
      req:= req + ' where b.titrerevue =:tit';
     datamodule2.FDQuerProc.SQL.text:= req;
     datamodule2.FDQuerProc.ParamByName('tit').AsString := cbTitre.Selected.Text;
     datamodule2.FDQuerProc.Open;

    datamodule2.FDQuerProc.First;
    while not datamodule2.FDQuerProc.Eof do
      begin
           cbNum.items.Add( datamodule2.FDQuerProc.FieldByName('numrevue').AsString);
           datamodule2.FDQuerProc.Next;
         end;
      datamodule2.FDQuerProc.Close;
    cbnum.Visible:=true;
  end;
end;

procedure TFbibli_revcont.FormActivate(Sender: TObject);
var
 i:integer;
begin
   Datmaj := DateToStr(Date);
   cbnum.Visible:=false;
   cbPerio.Visible:=false;
    for i := 0 to Componentcount-1 do
          	begin
            		if (Components[i] is TEdit ) then
                     begin
                       TEdit(Components[i]).Text:='';
                     end;
                if (Components[i] is TMemo ) then
                     begin
                       TMemo(Components[i]).Text:='';
                     end;
                 if (Components[i] is TComboBox ) and (TComboBox(Components[i]).Tag<>1) then
                     begin
                       TComboBox(Components[i]).items.Insert(0,'');
                       TComboBox(Components[i]).Tag:=1;
                       Tcombobox(components[i]).Items[0];
                     end
                     else   if (Components[i] is TComboBox ) then
                      Tcombobox(components[i]).Items[0];
                 if (Components[i] is TCheckBox ) then
                     begin
                       TCheckBox(Components[i]).ischecked :=false;

                     end;
//                 if (Components[i] is TDateEdit ) then
//                    begin
//                       TDateEdit(Components[i]).Date:=now;
//                     end;
               end;
end;

end.
