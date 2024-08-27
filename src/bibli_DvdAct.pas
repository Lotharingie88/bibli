unit bibli_DvdAct;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo, FMX.DateTimeCtrls, FMX.Edit, FMX.ListBox, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,uDB, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TfDvdact = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btAnt: TButton;
    btRec: TButton;
    btAjo: TButton;
    BtMaj: TButton;
    btPost: TButton;
    BtQuit: TButton;
    cbNom: TComboBox;
    edPren: TEdit;
    edLieu: TEdit;
    dedNaiss: TDateEdit;
    dedDeces: TDateEdit;
    memFilm: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    cbPays: TComboBox;
    FDQuerDvdAct: TFDQuery;
    BindingsList1: TBindingsList;
    edNom: TEdit;
    Label7: TLabel;
    edMaj: TEdit;
    Label8: TLabel;
    ckAct: TCheckBox;
    ckReal: TCheckBox;
    ckMes: TCheckBox;
    ckChant: TCheckBox;
    BindSourceDB3: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    BindSourceDB4: TBindSourceDB;
    LinkFillControlToField2: TLinkFillControlToField;
    BindingsList2: TBindingsList;
    btCons: TButton;
    cbInterp: TComboBox;
    cbReal: TComboBox;
    BindSourceDB1: TBindSourceDB;
    LinkFillControlToField3: TLinkFillControlToField;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField4: TLinkFillControlToField;
    procedure BtQuitClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btAjoClick(Sender: TObject);
    procedure BtMajClick(Sender: TObject);
    procedure btRecClick(Sender: TObject);
    procedure cbNomChange(Sender: TObject);
    procedure btConsClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  fDvdact: TfDvdact;

implementation

{$R *.fmx}
uses bibli_dvd,bibli_dvdajo,bibli_cd;

var
  nb:integer;
  datmaj:string;
  //naiss:string;
  //dec:string;
  pays:integer;
  req:string;

procedure TfDvdact.btAjoClick(Sender: TObject);
begin
  btMaj.Enabled:=false;
  btRec.Enabled:=True;
  edNom.Visible:=true;
  cbNom.Visible:=false;
  cbinterp.Visible:=false;
  cbreal.Visible:=false;
end;

procedure TfDvdact.btConsClick(Sender: TObject);
begin
  btrec.Enabled:=false;
  ednom.visible:=false;
  if fdvdact.Tag=1 then
    begin
    cbNom.Visible:=true;
    cbReal.Visible:=False;
    cbInterp.Visible:=False;
    end;
  if fdvdact.Tag=3 then
    begin
    cbNom.Visible:=false;
    cbReal.Visible:=true;
    cbInterp.Visible:=False;
    end;
  if fdvdact.Tag=2 then
    begin
    cbNom.Visible:=false;
    cbReal.Visible:=False;
    cbInterp.Visible:=true;
    end;
  edpren.Enabled:=false;
  deddeces.Enabled:=false;
  dednaiss.Enabled:=false;


end;

procedure TfDvdact.BtMajClick(Sender: TObject);
begin
   btAjo.Enabled:=false;
  btRec.Enabled:=True;
  edNom.Visible:=false;
  if fdvdact.Tag=1 then
    begin
    cbNom.Visible:=true;
    cbReal.Visible:=False;
    cbInterp.Visible:=False;
    end;
  if fdvdact.Tag=3 then
    begin
    cbNom.Visible:=false;
    cbReal.Visible:=true;
    cbInterp.Visible:=False;
    end;
  if fdvdact.Tag=2 then
    begin
    cbNom.Visible:=false;
    cbReal.Visible:=False;
    cbInterp.Visible:=true;
    end;
end;

procedure TfDvdact.btPrecClick(Sender: TObject);
begin
if fdvdact.tag=1 then
  fdvd.Show;
if fdvdact.tag=2 then
   fcd.show;
 if fdvdact.tag=3 then
   fdvd.show;
  fdvdact.close;
end;

procedure TfDvdact.BtQuitClick(Sender: TObject);
begin
  edPren.Text:='';
  btRec.Enabled:=false;
  btAjo.Enabled:=true;
  btMaj.Enabled:=true;
  close;
end;

procedure TfDvdact.btRecClick(Sender: TObject);
var
i:integer;
begin
  //if (ckAct.IsChecked=false and ckReal.IsChecked=false and ckMes.IsChecked=false and ckChant.IsChecked=false) then
    //            ShowMessage ('Erreur ! un rôle minimum doit obligatoirement être coché !');
   fdQuerDvdAct.SQL.Clear;
            fdQuerDvdAct.SQL.Text:='SELECT idnation as pays from pays where nom =:npays ' ;
            fdQuerDvdAct.ParamByName('npays').AsString := cbPays.Selected.Text;
            fdQuerDvdAct.Open;
            pays:=fdQuerDvdAct.FieldByName('pays').AsInteger;
            fdQuerDvdAct.Close;
  if btMaj.Enabled=true then
    begin
            fdQuerDvdAct.SQL.Clear;
            req:= 'SELECT count(*) as nb from actreal where nomactreal =:nom';
            if fdvdact.tag=1 then
             req:=req + '  and acteur=1' ;
            if fdvdact.tag=2 then
             req:=req + '  and chant=1' ;
            if fdvdact.tag=3 then
             req:=req + '  and realisateur=1 or menscene=1' ;
            fdQuerDvdAct.SQL.Text:=req;
            fdQuerDvdAct.ParamByName('nom').AsString := cbNom.selected.Text;
            fdQuerDvdAct.Open;
            nb:=fdQuerDvdAct.FieldByName('nb').AsInteger;
            fdQuerDvdAct.Close;
            if nb=1 then
              begin
                 fdQuerDvdAct.Close;
                 fdQuerDvdAct.SQL.Clear;
                 fdQuerDvdAct.SQL.Text:='UPDATE actreal SET prenactreal = :pren,acteur=:act,realisateur=:real,menscene=:mes,chant=:chant,datnaiss=:dnaiss,datdec=:dec,idnation=:lpays,lnaiss=:naiss, datmaj = :maj  WHERE nomactreal =:nom  and acteur=1' ;
                 fdQuerDvdAct.ParamByName('pren').AsString := edPren.Text;
                 if ckAct.IsChecked=true then
                 fdQuerDvdAct.ParamByName('act').AsInteger := 1
                 else
                 fdQuerDvdAct.ParamByName('act').AsInteger := 0;
                 if ckReal.IsChecked=true then
                 fdQuerDvdAct.ParamByName('real').AsInteger := 1
                 else
                 fdQuerDvdAct.ParamByName('real').AsInteger := 0;
                 if ckMes.IsChecked=true then
                 fdQuerDvdAct.ParamByName('mes').AsInteger := 1
                 else
                 fdQuerDvdAct.ParamByName('mes').AsInteger := 0;
                 if ckChant.IsChecked=true then
                 fdQuerDvdAct.ParamByName('chant').AsInteger := 1
                 else
                 fdQuerDvdAct.ParamByName('chant').AsInteger := 0;
                 fdQuerDvdAct.ParamByName('lpays').AsInteger := pays;
                 fdQuerDvdAct.ParamByName('naiss').AsString := edLieu.Text;
                  if (not(dedNaiss.IsEmpty) and (dedNaiss.Text<>'01/01/001')) then
                 fdQuerDvdAct.ParamByName('dnaiss').AsDate := StrToDate(dedNaiss.Text)
                   else
                  fdQuerDvdAct.ParamByName('dnaiss').AsString:='NULL';
                 if (not(deddeces.IsEmpty) and (deddeces.Text<>'01/01/001')) then
                 fdQuerDvdAct.ParamByName('dec').AsDate := dedDeces.Date
                  else
                  fdQuerDvdAct.ParamByName('dec').AsString:='NULL';
                 fdQuerDvdAct.ParamByName('maj').AsDate := StrToDate(Datmaj);
                 fdQuerDvdAct.ParamByName('nom').AsString := cbNom.selected.Text;
                 fdQuerDvdAct.ExecSQL;
                 fdQuerDvdAct.Close;
              end;


    end;
  if btAjo.Enabled=true then
    begin
       if edNom.Text<>'' then
        begin
           fdQuerDvdAct.SQL.Clear;
            fdQuerDvdAct.SQL.Text:='SELECT count(*) as nb from actreal where nomactreal =:nom ' ;
            fdQuerDvdAct.ParamByName('nom').AsString := edNom.Text;
            fdQuerDvdAct.Open;
            nb:=fdQuerDvdAct.FieldByName('nb').AsInteger;
            fdQuerDvdAct.Close;
            if nb=0 then
              begin
                 fdQuerDvdAct.Close;
                 fdQuerDvdAct.SQL.Clear;
                 fdQuerDvdAct.SQL.Text:='INSERT into actreal(nomactreal,prenactreal,acteur,realisateur,menscene,chant,datnaiss,datdec,lnaiss,idnation,datmaj) VALUES (:nom,:pren,:act,:real,:mes,:chant,:naiss,:dec,:lnaiss,:cpays,:datmaj)';
                 fdQuerDvdAct.ParamByName('nom').AsString := edNom.Text;
                 fdQuerDvdAct.ParamByName('pren').AsString := edPren.Text;
                 if ckAct.IsChecked=true then
                 fdQuerDvdAct.ParamByName('act').AsInteger := 1
                 else
                 fdQuerDvdAct.ParamByName('act').AsInteger := 0;
                 if ckReal.IsChecked=true then
                 fdQuerDvdAct.ParamByName('real').AsInteger := 1
                 else
                 fdQuerDvdAct.ParamByName('real').AsInteger := 0;
                 if ckMes.IsChecked=true then
                 fdQuerDvdAct.ParamByName('mes').AsInteger := 1
                 else
                 fdQuerDvdAct.ParamByName('mes').AsInteger := 0;
                 if ckChant.IsChecked=true then
                 fdQuerDvdAct.ParamByName('chant').AsInteger := 1
                 else
                 fdQuerDvdAct.ParamByName('chant').AsInteger := 0;
                 if (not(dedNaiss.IsEmpty) and (dedNaiss.Text<>'01/01/001')) then
                 fdQuerDvdAct.ParamByName('naiss').AsDate := StrToDate(dedNaiss.Text)
                   else
                  fdQuerDvdAct.ParamByName('naiss').AsString:='NULL';
                 if (not(deddeces.IsEmpty) and (deddeces.Text<>'01/01/001')) then
                 fdQuerDvdAct.ParamByName('dec').AsDate := dedDeces.Date
                  else
                  fdQuerDvdAct.ParamByName('dec').AsString:='NULL';
                 fdQuerDvdAct.ParamByName('lnaiss').AsString := edLieu.Text;
                 fdQuerDvdAct.ParamByName('cpays').AsInteger := pays;
                 fdQuerDvdAct.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
                 fdQuerDvdAct.ExecSQL;
                 fdQuerDvdAct.Close;
              end;
        end;
    end;
     btRec.Enabled:=false;
     btAjo.Enabled:=true;
     btMaj.Enabled:=true;
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
                       Tcombobox(components[i]).Repaint;
                     end;
                 if (Components[i] is TCheckBox ) then
                     begin
                       TCheckBox(Components[i]).ischecked :=false;

                     end;
                 if (Components[i] is TDateEdit ) then
                    begin
                       TDateEdit(Components[i]).IsEmpty:=true;
                     end;
               end;

end;

procedure TfDvdact.cbNomChange(Sender: TObject);
var
  id:integer;
begin
            

            fdQuerDvdAct.SQL.Clear;
            req:= 'SELECT count(*) as nb from actreal where nomactreal =:nom';
            if fdvdact.tag=1 then
             req:=req + '  and acteur=1' ;
            if fdvdact.tag=2 then
             req:=req + '  and chant=1' ;
            if fdvdact.tag=3 then
             req:=req + '  and realisateur=1 or menscene=1' ;

            fdQuerDvdAct.SQL.Text:=req ;
            fdQuerDvdAct.ParamByName('nom').AsString := cbNom.selected.Text;
            fdQuerDvdAct.Open;
            nb:=fdQuerDvdAct.FieldByName('nb').AsInteger;
            fdQuerDvdAct.Close;
            if nb=1 then
              begin
                memfilm.Text:='';
                memfilm.Repaint;
                 fdQuerDvdAct.Close;
                 fdQuerDvdAct.SQL.Clear;
                 req :=  'select idactreal,nomactreal,prenactreal,acteur,realisateur,menscene,chant,iif(c.idact1 isnull,"",c.titre) as titre,iif(d.idact2 isnull,"",d.titre) as titre2,iif(e.idact3 isnull,"",e.titre) as titre3,datnaiss as naiss' ;
                 req:=req + ' ,datdec as dec,b.nom as lpays,lnaiss,a.datmaj from actreal as a left join dvd as c on a.idactreal=c.idact1 left join dvd as d on a.idactreal=d.idact2 isnull left join dvd as e on a.idactreal=e.idact3' ;
                 fdQuerDvdAct.SQL.Text:=req+' left join pays as b on a.idnation=b.idnation where nomactreal=:nom';
                 fdQuerDvdAct.ParamByName('nom').AsString := cbNom.selected.Text;
                 fdQuerDvdAct.Open;
                 edPren.Text:=fdQuerDvdAct.FieldByName('prenactreal').AsString;
                 edMaj.Text:=fdQuerDvdAct.FieldByName('datmaj').AsString;
                 dedNaiss.Text :=fdQuerDvdAct.FieldByName('naiss').AsString;
                 dedDeces.Text :=fdQuerDvdAct.FieldByName('dec').AsString;
                 edLieu.Text:=fdQuerDvdAct.FieldByName('lnaiss').AsString;
                 if fdQuerDvdAct.FieldByName('acteur').AsInteger=1 then
                    ckAct.IsChecked:=true
                    else
                    ckAct.IsChecked:=false;
                 if fdQuerDvdAct.FieldByName('realisateur').AsInteger=1 then
                    ckReal.IsChecked:=true
                    else
                    ckReal.IsChecked:=false;
                 if fdQuerDvdAct.FieldByName('menscene').AsInteger=1 then
                    ckMes.IsChecked:=true
                    else
                    ckMes.IsChecked:=false;
                 if fdQuerDvdAct.FieldByName('chant').AsInteger=1 then
                    ckChant.IsChecked:=true
                    else
                    ckChant.IsChecked:=false;
                 id:=fdQuerDvdAct.FieldByName('idactreal').AsInteger;
                 cbPays.selected.text:=fdQuerDvdAct.FieldByName('lpays').AsString;
                 cbpays.Repaint;
                 memfilm.Text:= fdQuerDvdAct.FieldByName('titre').AsString ;
                 memfilm.Text:=memfilm.Text + fdQuerDvdAct.FieldByName('titre2').AsString ;
                 memfilm.Text:=memfilm.Text + fdQuerDvdAct.FieldByName('titre3').AsString ;
                  memfilm.Repaint;
                 fdQuerDvdAct.Close;
                fdQuerDvdAct.SQL.Clear;
//                 fdQuerDvdAct.SQL.Text:='SELECT count(*) as nb from actreal where nomactreal =:nom  and acteur=1' ;
//                 fdQuerDvdAct.ParamByName('nom').AsString := cbNom.selected.Text;
//                 fdQuerDvdAct.Open;


              end;
end;

procedure TfDvdact.FormActivate(Sender: TObject);
var
  i:integer;
begin
   Datmaj := DateToStr(Date);
   edPren.Text:='';
   edMaj.Text:='';
   edNom.Visible:=true;
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
                     end;
                 if (Components[i] is TCheckBox ) then
                     begin
                       TCheckBox(Components[i]).ischecked :=false;

                     end;
                 if (Components[i] is TDateEdit ) then
                    begin
                       TDateEdit(Components[i]).IsEmpty:=true;
                     end;
               end;
  btRec.Enabled:=false;
  btAjo.Enabled:=true;
  btMaj.Enabled:=true;
end;

end.
