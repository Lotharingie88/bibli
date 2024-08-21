unit bibli_DvdRea;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,uDB, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo, FMX.DateTimeCtrls, FMX.ListBox, FMX.Edit, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt,firedac.Stan.Param, Data.Bind.Components, Data.Bind.DBScope;

type
  Tfdvdrea = class(TForm)
    Layout: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    Button2: TButton;
    btAjo: TButton;
    btRec: TButton;
    btMaj: TButton;
    Button6: TButton;
    btQuit: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ckAct: TCheckBox;
    ckRea: TCheckBox;
    ckMes: TCheckBox;
    ckChant: TCheckBox;
    memRea: TMemo;
    Label8: TLabel;
    btCons: TButton;
    edNom: TEdit;
    edPren: TEdit;
    edNaiss: TEdit;
    cbPays: TComboBox;
    cbNom: TComboBox;
    DedNaiss: TDateEdit;
    dedDec: TDateEdit;
    edMaj: TEdit;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField2: TLinkFillControlToField;
    procedure btPrecClick(Sender: TObject);
    procedure btQuitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btAjoClick(Sender: TObject);
    procedure btMajClick(Sender: TObject);
    procedure btRecClick(Sender: TObject);
    procedure cbNomChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  fdvdrea: Tfdvdrea;

implementation

{$R *.fmx}
  uses bibli_dvd;
    var
  nb:integer;
  datmaj:string;
  pays:integer;
  req:string;
procedure Tfdvdrea.btAjoClick(Sender: TObject);
begin
  btMaj.Enabled:=false;
  btRec.Enabled:=True;
  edNom.Visible:=true;
  cbNom.Visible:=false;
end;

procedure Tfdvdrea.btMajClick(Sender: TObject);
begin
   btAjo.Enabled:=false;
  btRec.Enabled:=True;
  edNom.Visible:=false;
  cbNom.Visible:=true;
end;

procedure Tfdvdrea.btPrecClick(Sender: TObject);
begin
  fdvd.Show;
  fdvdRea.close;
end;


procedure Tfdvdrea.btQuitClick(Sender: TObject);
begin
  btRec.Enabled:=false;
  btAjo.Enabled:=true;
  btMaj.Enabled:=true;
  close;
end;


procedure Tfdvdrea.btRecClick(Sender: TObject);
  var
  i:integer;
begin
            datamodule2.fdQuerProc.SQL.Clear;
            datamodule2.fdQuerProc.SQL.Text:='SELECT idnation as pays from pays where nom =:npays ' ;
            datamodule2.fdQuerProc.ParamByName('npays').AsString := cbPays.Selected.Text;
            datamodule2.fdQuerProc.Open;
            pays:=datamodule2.fdQuerProc.FieldByName('pays').AsInteger;
            datamodule2.fdQuerProc.Close;
  if btMaj.Enabled=true then
    begin
            datamodule2.fdQuerProc.SQL.Clear;
            datamodule2.fdQuerProc.SQL.Text:='SELECT count(*) as nb from actreal where nomactreal =:nom  and acteur=1' ;
            datamodule2.fdQuerProc.ParamByName('nom').AsString := cbNom.selected.Text;
            datamodule2.fdQuerProc.Open;
            nb:=datamodule2.fdQuerProc.FieldByName('nb').AsInteger;
            datamodule2.fdQuerProc.Close;
            if nb=1 then
              begin
                 datamodule2.fdQuerProc.Close;
                 datamodule2.fdQuerProc.SQL.Clear;
                 datamodule2.fdQuerProc.SQL.Text:='UPDATE actreal SET prenactreal = :pren,acteur=:act,realisateur=:real,menscene=:mes,chant=:chant,datnaiss=:dnaiss,datdec=:dec,idnation=:lpays,lnaiss=:naiss, datmaj = :maj  WHERE nomactreal =:nom  and acteur=1' ;
                 datamodule2.fdQuerProc.ParamByName('pren').AsString := edPren.Text;
                 if ckAct.IsChecked=true then
                 datamodule2.fdQuerProc.ParamByName('act').AsInteger := 1
                 else
                 datamodule2.fdQuerProc.ParamByName('act').AsInteger := 0;
                 if ckRea.IsChecked=true then
                 datamodule2.fdQuerProc.ParamByName('real').AsInteger := 1
                 else
                 datamodule2.fdQuerProc.ParamByName('real').AsInteger := 0;
                 if ckMes.IsChecked=true then
                 datamodule2.fdQuerProc.ParamByName('mes').AsInteger := 1
                 else
                 datamodule2.fdQuerProc.ParamByName('mes').AsInteger := 0;
                 if ckChant.IsChecked=true then
                 datamodule2.fdQuerProc.ParamByName('chant').AsInteger := 1
                 else
                 datamodule2.fdQuerProc.ParamByName('chant').AsInteger := 0;
                 datamodule2.fdQuerProc.ParamByName('lpays').AsInteger := pays;
                 datamodule2.fdQuerProc.ParamByName('naiss').AsString := edNaiss.Text;
                  if (not(dedNaiss.IsEmpty) and (dedNaiss.Text<>'01/01/001')) then
                 datamodule2.fdQuerProc.ParamByName('dnaiss').AsDate := StrToDate(dedNaiss.Text)
                   else
                  datamodule2.fdQuerProc.ParamByName('dnaiss').AsString:='NULL';
                 if (not(deddec.IsEmpty) and (deddec.Text<>'01/01/001')) then
                 datamodule2.fdQuerProc.ParamByName('dec').AsDate := dedDec.Date
                  else
                  datamodule2.fdQuerProc.ParamByName('dec').AsString:='NULL';
                 datamodule2.fdQuerProc.ParamByName('maj').AsDate := StrToDate(Datmaj);
                 datamodule2.fdQuerProc.ParamByName('nom').AsString := cbNom.selected.Text;
                 datamodule2.fdQuerProc.ExecSQL;
                 datamodule2.fdQuerProc.Close;
              end;


    end;
  if btAjo.Enabled=true then
    begin
       if edNom.Text<>'' then
        begin
           datamodule2.fdQuerProc.SQL.Clear;
            datamodule2.fdQuerProc.SQL.Text:='SELECT count(*) as nb from actreal where nomactreal =:nom ' ;
            datamodule2.fdQuerProc.ParamByName('nom').AsString := edNom.Text;
            datamodule2.fdQuerProc.Open;
            nb:=datamodule2.fdQuerProc.FieldByName('nb').AsInteger;
            datamodule2.fdQuerProc.Close;
            if nb=0 then
              begin
                 datamodule2.fdQuerProc.Close;
                 datamodule2.fdQuerProc.SQL.Clear;
                 datamodule2.fdQuerProc.SQL.Text:='INSERT into actreal(nomactreal,prenactreal,acteur,realisateur,menscene,chant,datnaiss,datdec,lnaiss,idnation,datmaj) VALUES (:nom,:pren,:act,:real,:mes,:chant,:naiss,:dec,:lnaiss,:cpays,:datmaj)';
                 datamodule2.fdQuerProc.ParamByName('nom').AsString := edNom.Text;
                 datamodule2.fdQuerProc.ParamByName('pren').AsString := edPren.Text;
                 if ckAct.IsChecked=true then
                 datamodule2.fdQuerProc.ParamByName('act').AsInteger := 1
                 else
                 datamodule2.fdQuerProc.ParamByName('act').AsInteger := 0;
                 if ckRea.IsChecked=true then
                 datamodule2.fdQuerProc.ParamByName('real').AsInteger := 1
                 else
                 datamodule2.fdQuerProc.ParamByName('real').AsInteger := 0;
                 if ckMes.IsChecked=true then
                 datamodule2.fdQuerProc.ParamByName('mes').AsInteger := 1
                 else
                 datamodule2.fdQuerProc.ParamByName('mes').AsInteger := 0;
                 if ckChant.IsChecked=true then
                 datamodule2.fdQuerProc.ParamByName('chant').AsInteger := 1
                 else
                 datamodule2.fdQuerProc.ParamByName('chant').AsInteger := 0;
                 if (not(dedNaiss.IsEmpty) and (dedNaiss.Text<>'01/01/001')) then
                 datamodule2.fdQuerProc.ParamByName('naiss').AsDate := StrToDate(dedNaiss.Text)
                   else
                  datamodule2.fdQuerProc.ParamByName('naiss').AsString:='NULL';
                 if (not(deddec.IsEmpty) and (deddec.Text<>'01/01/001')) then
                 datamodule2.fdQuerProc.ParamByName('dec').AsDate := dedDec.Date
                  else
                  datamodule2.fdQuerProc.ParamByName('dec').AsString:='NULL';
                 datamodule2.fdQuerProc.ParamByName('lnaiss').AsString := edNaiss.Text;
                 datamodule2.fdQuerProc.ParamByName('cpays').AsInteger := pays;
                 datamodule2.fdQuerProc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
                 datamodule2.fdQuerProc.ExecSQL;
                 datamodule2.fdQuerProc.Close;
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

procedure Tfdvdrea.cbNomChange(Sender: TObject);
 var
  id:integer;
begin
            datamodule2.fdQuerProc.SQL.Clear;
            datamodule2.fdQuerProc.SQL.Text:='SELECT count(*) as nb from actreal where nomactreal =:nom  and realisateur=1' ;
            datamodule2.fdQuerProc.ParamByName('nom').AsString := cbNom.selected.Text;
            datamodule2.fdQuerProc.Open;
            nb:=datamodule2.fdQuerProc.FieldByName('nb').AsInteger;
            datamodule2.fdQuerProc.Close;
            if nb=1 then
              begin
                memrea.Text:='';
                memrea.Repaint;
                 datamodule2.fdQuerProc.Close;
                 datamodule2.fdQuerProc.SQL.Clear;
                 req :=  'select idactreal,nomactreal,prenactreal,acteur,realisateur,menscene,chant,iif(c.idact1 isnull,"",c.titre) as titre,iif(d.idact2 isnull,"",d.titre) as titre2,iif(e.idact3 isnull,"",e.titre) as titre3,datnaiss as naiss' ;
                 req:=req + ' ,datdec as dec,b.nom as lpays,lnaiss,a.datmaj from actreal as a inner join dvd as c on c.idact1=a.idactreal or c.idact1 isnull inner join dvd as d on d.idact2=a.idactreal or d.idact2 isnull inner join dvd as e on e.idact3=a.idactreal or e.idact3 isnull' ;
                 datamodule2.fdQuerProc.SQL.Text:=req+' inner join pays as b on a.idnation=b.idnation where nomactreal=:nom';
                 datamodule2.fdQuerProc.ParamByName('nom').AsString := cbNom.selected.Text;
                 datamodule2.fdQuerProc.Open;
                 edPren.Text:=datamodule2.fdQuerProc.FieldByName('prenactreal').AsString;
                 edMaj.Text:=datamodule2.fdQuerProc.FieldByName('datmaj').AsString;
                 dedNaiss.Text :=datamodule2.fdQuerProc.FieldByName('naiss').AsString;
                 dedDec.Text :=datamodule2.fdQuerProc.FieldByName('dec').AsString;
                 ednaiss.Text:=datamodule2.fdQuerProc.FieldByName('lnaiss').AsString;
                 if datamodule2.fdQuerProc.FieldByName('acteur').AsInteger=1 then
                    ckAct.IsChecked:=true
                    else
                    ckAct.IsChecked:=false;
                 if datamodule2.fdQuerProc.FieldByName('realisateur').AsInteger=1 then
                    ckRea.IsChecked:=true
                    else
                    ckRea.IsChecked:=false;
                 if datamodule2.fdQuerProc.FieldByName('menscene').AsInteger=1 then
                    ckMes.IsChecked:=true
                    else
                    ckMes.IsChecked:=false;
                 if datamodule2.fdQuerProc.FieldByName('chant').AsInteger=1 then
                    ckChant.IsChecked:=true
                    else
                    ckChant.IsChecked:=false;
                 id:=datamodule2.fdQuerProc.FieldByName('idactreal').AsInteger;
                 cbPays.selected.text:=datamodule2.fdQuerProc.FieldByName('lpays').AsString;
                 cbpays.Repaint;
                 memrea.Text:= datamodule2.fdQuerProc.FieldByName('titre').AsString ;
                 memrea.Text:=memrea.Text + datamodule2.fdQuerProc.FieldByName('titre2').AsString ;
                 memrea.Text:=memrea.Text + datamodule2.fdQuerProc.FieldByName('titre3').AsString ;
                  memrea.Repaint;
                 datamodule2.fdQuerProc.Close;
                datamodule2.fdQuerProc.SQL.Clear;
//                 fdQuerDvdAct.SQL.Text:='SELECT count(*) as nb from actreal where nomactreal =:nom  and acteur=1' ;
//                 fdQuerDvdAct.ParamByName('nom').AsString := cbNom.selected.Text;
//                 fdQuerDvdAct.Open;


              end;
end;

procedure Tfdvdrea.FormActivate(Sender: TObject);
var
  i:integer;
begin
    Datmaj := DateToStr(Date);
  btRec.Enabled:=false;
  cbNom.Hint := cbNom.Selected.Text;
  cbNom.Visible:=true;

  edNom.Visible:=false;
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

end.
