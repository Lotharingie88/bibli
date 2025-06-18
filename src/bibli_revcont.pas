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
    Label4: TLabel;
    Label5: TLabel;
    cbAut: TComboBox;
    edTitr: TEdit;
    edAut: TEdit;
    ckNew: TCheckBox;
    BindSourceDB3: TBindSourceDB;
    LinkFillControlToField2: TLinkFillControlToField;
    btCons: TButton;
    btNew: TButton;
    procedure btPrecClick(Sender: TObject);
    procedure btQuitClick(Sender: TObject);
    procedure btRecClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbTitreChange(Sender: TObject);
    procedure cbNumChange(Sender: TObject);
    procedure btNewClick(Sender: TObject);
    procedure btConsClick(Sender: TObject);
    procedure ckNewChange(Sender: TObject);
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
procedure TFbibli_revcont.btConsClick(Sender: TObject);
begin
  btrec.Enabled:=false;
  btnew.enabled:=false;
  edAut.Enabled:=false;
  edtitr.Enabled:=false;
  cknew.Enabled:=false;
end;

procedure TFbibli_revcont.btNewClick(Sender: TObject);
begin
  btrec.Enabled:=true;
  btcons.Enabled:=false;
  edAut.Enabled:=true;
  edtitr.Enabled:=true;
  cknew.Enabled:=true;

end;

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
var
    irev,iaut : integer;
begin
  if (cbTitre.Selected.Text<>'') and (cbNum.Selected.Text<>'') then
  begin
    if cknew.IsChecked=false then
      begin
        if cbAut.Selected.Text<>'' then
          begin
                datamodule2.FDQuerProc.Close;
                datamodule2.FDQuerProc.SQL.Clear;
                req:='select idachrev';
                req:=req+ ' from  achrev as a left join revues as b ' ;
                req:=req+ ' on b.idrevue =a.idrev ' ;
                req:= req + ' where b.titrerevue =:tit and a.numrevue=:num ';
                datamodule2.FDQuerProc.SQL.text:= req;
                datamodule2.FDQuerProc.ParamByName('tit').AsString := cbTitre.Selected.Text;
                datamodule2.FDQuerProc.ParamByName('num').AsString := cbnum.Selected.Text;
                datamodule2.FDQuerProc.Open;
                irev:= datamodule2.FDQuerProc.FieldByName('idachrev').asinteger;
                datamodule2.FDQuerProc.Close;
                datamodule2.FDQuerProc.SQL.Clear;
                req:='select idauteur';
                req:=req+ ' from  auteur' ;
                req:= req + ' where nomauteur||" "||prenauteur = :nom';
                datamodule2.FDQuerProc.SQL.text:= req;
                datamodule2.FDQuerProc.ParamByName('nom').AsString := cbAut.Selected.Text;
                datamodule2.FDQuerProc.Open;
                iaut:= datamodule2.FDQuerProc.FieldByName('idauteur').asinteger;
                datamodule2.FDQuerProc.Close;
                datamodule2.FDQuerProc.SQL.Clear;
                req:='INSERT into';
                req:=req+ ' articles(idauteurarticl,idrevuebibli,titrearticle,datmaj)' ;
                req:= req + ' VALUES (:aut,:rev,:titr,:Datmaj)';
                datamodule2.FDQuerProc.SQL.text:= req;
                datamodule2.FDQuerProc.ParamByName('rev').AsInteger := irev;
                datamodule2.FDQuerProc.ParamByName('aut').AsInteger := iaut;
                datamodule2.FDQuerProc.ParamByName('titr').AsString := edtitr.Text;
                datamodule2.FDQuerProc.ParamByName('Datmaj').AsDate := StrToDate(Datmaj);
                datamodule2.FDQuerProc.execSql;
          end;
      end;

  end;
end;

procedure TFbibli_revcont.cbNumChange(Sender: TObject);
begin
   if cbNum.Selected.Text<>'' then
    begin
      if cbtitre.Selected.Text<>'' then
        begin
        // select titrearticle, nomauteur,prenauteur from articles  as a left join auteur as b on a.idauteurarticl=b.idauteur
     //datamodule2.FDQuerContRev.Close;
     //datamodule2.FDQuerContRev.SQL.Clear;
//      req:='select idarticle, titrearticle,b.auteur,datparut,digest,a.datmaj,c.theme';
//      req:=req+ ' from  articles as a left join auteur as b on a.idauteurarticl=b.idauteur left join thematique as c on a.idthem=c.idtheme left join achrev as d on a.idrevuebibli=d.idachev' ;
//      req:= req + ' left join editionpoche as e on a.ideditionpoche=e.ideditionpoche left join editeur as f on a.idediteur=f.idediteur where titre =:tit';
//     datamodule2.FDQuerProc.SQL.text:= req;
//     datamodule2.FDQuerProc.ParamByName('tit').AsString := cbTitre.Selected.Text;
//     datamodule2.FDQuerProc.Open;
//     datamodule2.FDQuerProc.Close;
       end;

    end;
end;

procedure TFbibli_revcont.cbTitreChange(Sender: TObject);
begin
    if cbTitre.Selected.Text<>'' then
  begin

   // select titrearticle, nomauteur,prenauteur from articles  as a left join auteur as b on a.idauteurarticl=b.idauteur
     //datamodule2.FDQuerContRev.Close;
     //datamodule2.FDQuerContRev.SQL.Clear;
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

procedure TFbibli_revcont.ckNewChange(Sender: TObject);
begin
    if btnew.Enabled=true and cknew.IsChecked=true then
      begin
        edAut.Visible:=true;
        cbAut.Visible:=false;
      end;
    if btnew.Enabled=true and cknew.IsChecked=false then
      begin
        edAut.Visible:=false;
        cbAut.Visible:=true;
      end;
end;

procedure TFbibli_revcont.FormActivate(Sender: TObject);
var
 i:integer;
begin
   Datmaj := DateToStr(Date);
   btnew.Enabled:=true;
   btcons.Enabled:=true;
   btRec.enabled:=false;
   cbAut.visible:=false;
   edAut.Enabled:=false;
   edtitr.Enabled:=false;
   cknew.Enabled:=false;
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
