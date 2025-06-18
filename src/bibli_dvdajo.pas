unit bibli_dvdajo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox, FMX.Memo.Types,
  FMX.Edit, FMX.ScrollBox, FMX.Memo,uDb, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope,firedac.Stan.Param;

type
  TfDvdAjo = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btAjo: TButton;
    btRec: TButton;
    btModif: TButton;
    btQuit: TButton;
    cbTitre: TComboBox;
    cbPays: TComboBox;
    cbGenre: TComboBox;
    cbAct1: TComboBox;
    cbAct2: TComboBox;
    cbAct3: TComboBox;
    cbReal: TComboBox;
    cbMes: TComboBox;
    memResu: TMemo;
    memAvi: TMemo;
    edDuree: TEdit;
    edAnnee: TEdit;
    edNot: TEdit;
    edDatmaj: TEdit;
    edTitre: TEdit;
    Label1: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField2: TLinkFillControlToField;
    BindSourceDB3: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    BindSourceDB4: TBindSourceDB;
    LinkFillControlToField3: TLinkFillControlToField;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    BindSourceDB2: TBindSourceDB;
    BindSourceDB5: TBindSourceDB;
    BindSourceDB6: TBindSourceDB;
    LinkFillControlToField9: TLinkFillControlToField;
    BindSourceDB8: TBindSourceDB;
    BindSourceDB7: TBindSourceDB;
    LinkFillControlToField: TLinkFillControlToField;
    LinkFillControlToField4: TLinkFillControlToField;
    LinkFillControlToField5: TLinkFillControlToField;
    LinkFillControlToField6: TLinkFillControlToField;
    LinkFillControlToField7: TLinkFillControlToField;
    procedure btQuitClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btAjoClick(Sender: TObject);
    procedure btModifClick(Sender: TObject);
    procedure btRecClick(Sender: TObject);
    procedure cbTitreChange(Sender: TObject);
    procedure cbAct1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  fDvdAjo: TfDvdAjo;

implementation

{$R *.fmx}
  uses bibli_dvd;
  var
    datmaj: string;
procedure TfDvdAjo.btAjoClick(Sender: TObject);
begin
  btRec.Enabled:=true;
  btModif.Enabled:=false;
  cbTitre.Visible:=false;
  edTitre.Visible:=true;
  //cbact1.ItemIndex:=-1;
end;

procedure TfDvdAjo.btModifClick(Sender: TObject);
begin
  btRec.Enabled:=true;
  cbTitre.Visible:=true;
  edTitre.Visible:=false;
  btAjo.Enabled:=false;
end;

procedure TfDvdAjo.btPrecClick(Sender: TObject);
begin
  fdvd.show();
  fdvdajo.Close;
end;

procedure TfDvdAjo.btQuitClick(Sender: TObject);
begin
  close;
end;

procedure TfDvdAjo.btRecClick(Sender: TObject);
  var
  nb , i:integer;
  act1,act2,act3,real,ms,cpays,cthem : integer;
begin
  if btAjo.Enabled=true then
    begin
       if edTitre.Text<>'' then
        begin
           datamodule2.fdQuerproc.Close;
            datamodule2.fdQuerproc.SQL.Clear;
            datamodule2.fdQuerproc.SQL.Text:='SELECT count(*) as nb from dvd where titre =:tit ' ;
            datamodule2.fdQuerproc.ParamByName('tit').AsString := edTitre.Text;
            datamodule2.fdQuerproc.Open;
            nb:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger;
            datamodule2.fdQuerproc.Close;
            if nb=0 then
              begin
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idnation from pays where nom = :pays';
                 datamodule2.fdQuerproc.ParamByName('pays').AsString := cbPays.Selected.text;
                 datamodule2.fdQuerproc.open;
                 cpays:=datamodule2.fdQuerproc.FieldByName('idnation').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idtheme from thematique where theme = :them and dvd=1';
                 datamodule2.fdQuerproc.ParamByName('them').AsString := cbGenre.Selected.text;
                 datamodule2.fdQuerproc.open;
                 cthem:=datamodule2.fdQuerproc.FieldByName('idtheme').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idactreal from actreal where nomactreal||" "||prenactreal = :nom and acteur=1';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := cbAct1.Selected.text;
                 datamodule2.fdQuerproc.open;
                 act1:=datamodule2.fdQuerproc.FieldByName('idactreal').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idactreal from actreal where nomactreal||" "||prenactreal = :nom and acteur=1';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := cbAct2.Selected.text;
                 datamodule2.fdQuerproc.open;
                 act2:=datamodule2.fdQuerproc.FieldByName('idactreal').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idactreal from actreal where nomactreal||" "||prenactreal = :nom and acteur=1';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := cbAct3.Selected.text;
                 datamodule2.fdQuerproc.open;
                 act3:=datamodule2.fdQuerproc.FieldByName('idactreal').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idactreal from actreal where nomactreal||" "||prenactreal = :nom and menscene=1';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := cbMes.Selected.text;
                 datamodule2.fdQuerproc.open;
                 ms:=datamodule2.fdQuerproc.FieldByName('idactreal').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idactreal from actreal where nomactreal||" "||prenactreal = :nom and realisateur=1';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := cbReal.Selected.text;
                 datamodule2.fdQuerproc.open;
                 real:=datamodule2.fdQuerproc.FieldByName('idactreal').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='INSERT into dvd(titre,datsort,duree,datmaj,idnation,idact1,idact2,idact3,idms,idrealisateur,resume,avis,note,idthem) VALUES (:tit,:sort,:dure,:datmaj,:nat,:acte1,:acte2,:acte3,:mes,:real,:res,:avi,:nota,:them)';
                 datamodule2.fdQuerproc.ParamByName('tit').AsString := edTitre.Text;
                 datamodule2.fdQuerproc.ParamByName('sort').AsString := edAnnee.Text;
                 datamodule2.fdQuerproc.ParamByName('dure').AsString := edDuree.Text;
                 datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
                 datamodule2.fdQuerproc.ParamByName('nat').AsInteger := cpays;
                 datamodule2.fdQuerproc.ParamByName('acte1').AsInteger := act1;
                 datamodule2.fdQuerproc.ParamByName('acte2').AsInteger := act2;
                 datamodule2.fdQuerproc.ParamByName('acte3').AsInteger := act3;
                 datamodule2.fdQuerproc.ParamByName('mes').AsInteger := ms;
                 datamodule2.fdQuerproc.ParamByName('real').AsInteger := real;
                 datamodule2.fdQuerproc.ParamByName('res').AsString :=memResu.Text;
                 datamodule2.fdQuerproc.ParamByName('avi').AsString := memAvi.Text;
                 datamodule2.fdQuerproc.ParamByName('nota').AsInteger := strtoint(ednot.text);
                 datamodule2.fdQuerproc.ParamByName('them').AsInteger := cthem;
                 datamodule2.fdQuerproc.ExecSQL;
                 datamodule2.fdQuerproc.Close;
              end;

        end;

    end;
    if btModif.Enabled=true then
    begin
       if cbtitre.selected.Text<>'' then
        begin
           datamodule2.fdQuerproc.Close;
            datamodule2.fdQuerproc.SQL.Clear;
            datamodule2.fdQuerproc.SQL.Text:='SELECT count(*) as nb from dvd where titre =:tit ' ;
            datamodule2.fdQuerproc.ParamByName('tit').AsString := cbtitre.selected.Text;
            datamodule2.fdQuerproc.Open;
            nb:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger;
            datamodule2.fdQuerproc.Close;
            if nb=1 then
              begin
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idnation from pays where nom = :pays';
                 datamodule2.fdQuerproc.ParamByName('pays').AsString := cbPays.Selected.text;
                 datamodule2.fdQuerproc.open;
                 cpays:=datamodule2.fdQuerproc.FieldByName('idnation').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idtheme from thematique where theme = :them and dvd=1';
                 datamodule2.fdQuerproc.ParamByName('them').AsString := cbGenre.Selected.text;
                 datamodule2.fdQuerproc.open;
                 cthem:=datamodule2.fdQuerproc.FieldByName('idtheme').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idactreal from actreal where nomactreal||" "||prenactreal = :nom and acteur=1';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := cbAct1.Selected.text;
                 datamodule2.fdQuerproc.open;
                 act1:=datamodule2.fdQuerproc.FieldByName('idactreal').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idactreal from actreal where nomactreal||" "||prenactreal = :nom and acteur=1';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := cbAct2.Selected.text;
                 datamodule2.fdQuerproc.open;
                 act2:=datamodule2.fdQuerproc.FieldByName('idactreal').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idactreal from actreal where nomactreal||" "||prenactreal = :nom and acteur=1';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := cbAct3.Selected.text;
                 datamodule2.fdQuerproc.open;
                 act3:=datamodule2.fdQuerproc.FieldByName('idactreal').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idactreal from actreal where nomactreal||" "||prenactreal = :nom and menscene=1';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := cbMes.Selected.text;
                 datamodule2.fdQuerproc.open;
                 ms:=datamodule2.fdQuerproc.FieldByName('idactreal').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idactreal from actreal where nomactreal||" "||prenactreal = :nom and realisateur=1';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := cbReal.Selected.text;
                 datamodule2.fdQuerproc.open;
                 real:=datamodule2.fdQuerproc.FieldByName('idactreal').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='UPDATE dvd SET idact1 = :act1,idact2=:act2,idact3=:act3,idrealisateur=:real,idms=:mes,idthem=:them,duree=:dure,datsort=:sort,resume=:res,avis=:avi,note=:nota,idnation=:nat, datmaj = :datmaj  WHERE titre =:tit ' ;
                 datamodule2.fdQuerproc.ParamByName('tit').AsString := cbTitre.selected.Text;
                 datamodule2.fdQuerproc.ParamByName('sort').AsString := edAnnee.Text;
                 datamodule2.fdQuerproc.ParamByName('dure').AsString := edDuree.Text;
                 datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
                 datamodule2.fdQuerproc.ParamByName('nat').AsInteger := cpays;
                 datamodule2.fdQuerproc.ParamByName('them').AsInteger := cthem;
                 datamodule2.fdQuerproc.ParamByName('act1').AsInteger := act1;
                 datamodule2.fdQuerproc.ParamByName('act2').AsInteger := act2;
                 datamodule2.fdQuerproc.ParamByName('act3').AsInteger := act3;
                 datamodule2.fdQuerproc.ParamByName('mes').AsInteger := ms;
                 datamodule2.fdQuerproc.ParamByName('real').AsInteger := real;
                 datamodule2.fdQuerproc.ParamByName('res').AsString :=memResu.Text;
                 datamodule2.fdQuerproc.ParamByName('avi').AsString := memAvi.Text;
                 if ednot.Text <>'' then
                 datamodule2.fdQuerproc.ParamByName('nota').AsInteger := strtoint(ednot.text)
                 else
                 datamodule2.fdQuerproc.ParamByName('nota').AsInteger :=0;
                 datamodule2.fdQuerproc.ExecSQL;
                 datamodule2.fdQuerproc.Close;
              end;

        end;

    end;
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
                 if (Components[i] is TComboBox ) then
                     begin
                      if TComboBox(Components[i]).items[0]<>''  then
                       TComboBox(Components[i]).items.Insert(0,'');
                       TComboBox(Components[i]).Repaint;
                     end;
                // if (Components[i] is TDateEdit ) then
                    //begin
                       //TDateEdit(Components[i]).Text:='';
                     //end;
               end;
    cbTitre.Visible:=False;
    edTitre.Visible:=true;
    btAjo.Enabled:=true;
    btModif.Enabled:=true;
    btRec.Enabled:=false;
end;

procedure TfDvdAjo.cbAct1Click(Sender: TObject);
begin
  //cbact1.ItemIndex:=cbact1.Selected.Index;

end;

procedure TfDvdAjo.cbTitreChange(Sender: TObject);
   var
  nb:integer;
  req:string;
  //act1,act2,act3,real,mes,them,cpays : integer;
begin

       datamodule2.fdQuerproc.Close;
       datamodule2.fdQuerproc.SQL.Clear;
            datamodule2.fdQuerproc.SQL.Text:='SELECT count(*) as nb from dvd where titre =:tit ' ;
            datamodule2.fdQuerproc.ParamByName('tit').AsString := cbTitre.Selected.Text;
            datamodule2.fdQuerproc.Open;
            nb:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger;
            datamodule2.fdQuerproc.Close;
            if nb=1 then
             begin
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 req:= 'select datsort,duree,a.datmaj,b.nom as lpays,c.theme as them,(h.nomactreal||" "||h.prenactreal) as real,(e.nomactreal||" "||e.prenactreal) as act1,(f.nomactreal||" "||f.prenactreal) as act2 ';
                 req:=req+',(g.nomactreal||" "||g.prenactreal) as act3,(d.nomactreal||" "||d.prenactreal) as ms,resume,avis,note from dvd as a ';

                 req:= req + ' left join pays as b on a.idnation = b.idnation left join thematique as c on a.idthem=c.idtheme';
                 req:= req + ' left join actreal as d on a.idms=d.idactreal  ';
                 req := req+ ' left join actreal as e on a.idact1=e.idactreal ';
                 req:= req + ' left join actreal as f on a.idact2=f.idactreal ';
                 req:= req + ' left join actreal as g on a.idact3=g.idactreal ';
                 req:= req + ' left join actreal as h on a.idrealisateur=h.idactreal ';
                 datamodule2.fdQuerproc.SQL.Text:=req+ ' where a.titre = :tit';
                 datamodule2.fdQuerproc.ParamByName('tit').AsString := cbTitre.Selected.Text;
                 datamodule2.fdQuerproc.open;
                 edAnnee.Text:=datamodule2.fdQuerproc.FieldByName('datsort').AsString ;
                 edDuree.Text:=datamodule2.fdQuerproc.FieldByName('duree').AsString ;
                 edDatmaj.text:=datamodule2.fdQuerproc.FieldByName('datmaj').AsString ;
                 memResu.Text:=datamodule2.fdQuerproc.FieldByName('resume').AsString ;
                 memAvi.Text:=datamodule2.fdQuerproc.FieldByName('avis').AsString ;
                 edNot.text:=datamodule2.fdQuerproc.FieldByName('note').AsString ;
                  //if not(datamodule2.fdQuerproc.FieldByName('ms').IsNull)  then
                 cbMes.Selected.Text:= datamodule2.fdQuerproc.FieldByName('ms').AsString;
                 //else cbMes.ItemIndex:=-1;
                  //if not(datamodule2.fdQuerproc.FieldByName('act1').IsNull)  then
                 cbAct1.Selected.Text:= datamodule2.fdQuerproc.FieldByName('act1').AsString;
                 //else cbact1.ItemIndex:=-1 ;
                  //if not(datamodule2.fdQuerproc.FieldByName('act2').IsNull)  then
                 cbAct2.Selected.Text:= datamodule2.fdQuerproc.FieldByName('act2').AsString;
                 //else cbact2.ItemIndex:=-1;
                  //if not(datamodule2.fdQuerproc.FieldByName('act3').IsNull)  then
                 cbAct3.Selected.Text:= datamodule2.fdQuerproc.FieldByName('act3').AsString;
                 //else cbact3.ItemIndex:=-1 ;
                 //if not(datamodule2.fdQuerproc.FieldByName('real').IsNull)  then
                 cbReal.Selected.Text:= datamodule2.fdQuerproc.FieldByName('real').AsString;
                 //else
                 //cbreal.ItemIndex:=-1;
                  //if not(datamodule2.fdQuerproc.FieldByName('them').IsNull)  then
                 cbGenre.Selected.Text:= datamodule2.fdQuerproc.FieldByName('them').AsString;
                 //else cbgenre.ItemIndex:=-1 ;
                  //if not(datamodule2.fdQuerproc.FieldByName('lpays').IsNull)  then
                 cbPays.Selected.Text:=datamodule2.fdQuerproc.FieldByName('lpays').AsString;
                 //else cbpays.ItemIndex:=-1 ;
                 datamodule2.fdQuerproc.Close;
//                // DATE_FORMAT(datnaiss,"%d/%m/%Y")
//
             end;
end;


procedure TfDvdAjo.FormActivate(Sender: TObject);
var
  i:integer;
begin
    Datmaj := DateToStr(Date);
  cbTitre.Hint := cbtitre.Selected.Text;
//  cbAct1.Hint:=cbact1.Selected.Text;
//  cbact2.Hint:=cbact2.Selected.Text;
//  cbact3.Hint:=cbact3.Selected.Text;
//  cbmes.Hint:=cbmes.Selected.Text;
//  cbreal.Hint:=cbreal.Selected.Text;
  cbTitre.Visible:=False;
  edTitre.Visible:=true;
  btAjo.Enabled:=true;
  btModif.Enabled:=true;
  btRec.Enabled:=false;
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
                 if (Components[i] is TComboBox ) then
                     begin
                      if TComboBox(Components[i]).items[0]<>''  then
                       TComboBox(Components[i]).items.Insert(0,'');
                       TComboBox(Components[i]).Repaint;
                     end;
//                 if (Components[i] is TDateEdit ) then
//                     begin
//                       TDateEdit(Components[i]).Text:='';
//                     end;
               end;
end;

end.
