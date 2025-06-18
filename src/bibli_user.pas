unit bibli_user;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,udb, FMX.ListBox,
  FMX.Edit, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,firedac.Stan.Param,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,system.Hash;

type
  TFBuser = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btCre: TButton;
    btRec: TButton;
    btMod: TButton;
    btQuit: TButton;
    edNom: TEdit;
    edPren: TEdit;
    edPhon: TEdit;
    edMel: TEdit;
    edMdp: TEdit;
    edDeb: TEdit;
    edFin: TEdit;
    cbActiv: TComboBox;
    cbProf: TComboBox;
    lbNom: TLabel;
    lbPren: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edMaj: TEdit;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField2: TLinkFillControlToField;
    cbUser: TComboBox;
    BindSourceDB3: TBindSourceDB;
    LinkFillControlToField3: TLinkFillControlToField;
    Label1: TLabel;
    edPseudo: TEdit;
    btMailU: TButton;
    btVal: TButton;
    Label2: TLabel;
    ckValid: TCheckBox;
    cbNom: TComboBox;
    procedure btPrecClick(Sender: TObject);
    procedure btQuitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btCreClick(Sender: TObject);
    procedure btModClick(Sender: TObject);
    procedure btRecClick(Sender: TObject);
    procedure cbUserChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FBuser: TFBuser;

implementation

{$R *.fmx}
 uses bibli,bibli_param,bibli_liv1,bibli_livpret,admin;
 var
  pro,act,id:integer;
  Datmaj,req:string;
procedure TFBuser.btCreClick(Sender: TObject);
begin
     //edTitre.Visible:=false;
     //cbTitre.Visible:=True;
     //cbAuteur.Visible:=false;
     btRec.Enabled:=True;
     btMod.Enabled:=False;
      cbUser.Visible:=false;
      lbPren.Visible:=true;
      lbnom.Text:='Nom :';
      edPren.Visible:=true;
      ednom.Visible:=true;
end;

procedure TFBuser.btModClick(Sender: TObject);
begin
      btRec.Enabled:=True;
      btCre.Enabled:=False;
      cbUser.Visible:=true;
      lbPren.Visible:=false;
      lbnom.Text:='Utilisateur :';
      edPren.Visible:=false;
      ednom.Visible:=false;
end;

procedure TFBuser.btPrecClick(Sender: TObject);
begin
  if fbuser.Tag=1 then
   fadmin.show;
  if fbuser.Tag=0 then
   fpret.show();
  fbuser.Close;
end;


procedure TFBuser.btQuitClick(Sender: TObject);
begin
  close();
end;

procedure TFBuser.btRecClick(Sender: TObject);
begin
    datamodule2.fdQuerproc.sql.clear;
    if btMod.Enabled=true then
      begin
               datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select iduser from utilisateur where nom||" "||prenom = :nom';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := cbuser.Selected.text;
                 datamodule2.fdQuerproc.open;
                 id:=datamodule2.fdQuerproc.FieldByName('iduser').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
              datamodule2.fdQuerproc.SQL.Text:='select cprofil from profil where profil=:pro';
                 datamodule2.fdQuerproc.ParamByName('pro').AsString := cbProf.Selected.text;
                 datamodule2.fdQuerproc.open;
                 pro:=datamodule2.fdQuerproc.FieldByName('cprofil').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select cactiv from activite where metier = :met';
                 datamodule2.fdQuerproc.ParamByName('met').AsString := cbActiv.Selected.text;
                 datamodule2.fdQuerproc.open;
                 act:=datamodule2.fdQuerproc.FieldByName('cactiv').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
              datamodule2.fdQuerproc.SQL.Text:='UPDATE utilisateur SET telephone = :phon,email=:mel,pwd=:mdp,cprofil=:cpro,activite=:cact,pseudo=:pseu, datdeb=:deb,datfin=:fin, datmaj = :maj  WHERE iduser = :id' ;
              if edphon.text<>'' then
                  datamodule2.fdQuerproc.ParamByName('phon').Asstring := edphon.text
                  else
                  datamodule2.fdQuerproc.ParamByName('phon').Asstring :='0';
              datamodule2.fdQuerproc.ParamByName('mel').Asstring  := edmel.text;
              datamodule2.fdQuerproc.ParamByName('pseu').Asstring  := edpseudo.text;
              datamodule2.fdQuerproc.ParamByName('mdp').Asstring :=THashSHA2.GetHashString(edMdp.text,THashSHA2.TSHA2Version.SHA512).ToUpper;
              datamodule2.fdQuerproc.ParamByName('cpro').Asinteger := pro;
              datamodule2.fdQuerproc.ParamByName('cact').AsInteger := act;
              datamodule2.fdQuerproc.ParamByName('deb').AsString := eddeb.Text;
              datamodule2.fdQuerproc.ParamByName('fin').AsString := edfin.Text;
              datamodule2.fdQuerproc.ParamByName('maj').AsDate := StrToDate(Datmaj);
              datamodule2.fdQuerproc.ParamByName('id').Asinteger := id;
      end;
     if btCre.Enabled=true then
      begin
                 datamodule2.fdQuerproc.SQL.Text:='select cprofil from profil where profil=:pro';
                 datamodule2.fdQuerproc.ParamByName('pro').AsString := cbProf.Selected.text;
                 datamodule2.fdQuerproc.open;
                 pro:=datamodule2.fdQuerproc.FieldByName('cprofil').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select cactiv from activite where metier = :met';
                 datamodule2.fdQuerproc.ParamByName('met').AsString := cbActiv.Selected.text;
                 datamodule2.fdQuerproc.open;
                 act:=datamodule2.fdQuerproc.FieldByName('cactiv').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;

                 datamodule2.fdQuerproc.SQL.Text:='INSERT into utilisateur(nom,prenom,telephone,email,pwd,pseudo,cprofil,activite,datdeb,datfin,datmaj) VALUES (:nom,:pren,:phon,:mail,:mdp,:pseu,:cpro,:cact,:deb,:fin,:datmaj)';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := ednom.Text;
                 datamodule2.fdQuerproc.ParamByName('pren').Asstring := edpren.text;
                 datamodule2.fdQuerproc.ParamByName('mail').Asstring := edmel.text;
                 datamodule2.fdQuerproc.ParamByName('mdp').Asstring := THashSHA2.GetHashString(edMdp.text,THashSHA2.TSHA2Version.SHA512).ToUpper;
                 datamodule2.fdQuerproc.ParamByName('pseu').Asstring := edpseudo.text;
                 if edphon.text<>'' then
                  datamodule2.fdQuerproc.ParamByName('phon').Asstring := edphon.text
                  else
                  datamodule2.fdQuerproc.ParamByName('phon').Asstring :='0';
                 datamodule2.fdQuerproc.ParamByName('cpro').Asinteger := pro;
                 datamodule2.fdQuerproc.ParamByName('cact').AsInteger := act;
                 datamodule2.fdQuerproc.ParamByName('deb').AsString := eddeb.text ;
                 datamodule2.fdQuerproc.ParamByName('fin').AsString := edfin.text ;
                 datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
      end;
       datamodule2.fdQuerproc.ExecSQL;
       datamodule2.fdQuerproc.Close;
     btRec.enabled:=false;
     btMod.Enabled:=True;
     btCre.Enabled:=True;
end;

procedure TFBuser.cbUserChange(Sender: TObject);
begin

               datamodule2.fdQuerproc2.Close;
                 datamodule2.fdQuerproc2.SQL.Clear;
                 req:= 'select iduser,telephone,email,pwd,datdeb,datfin,a.datmaj,pseudo,';
                 req:=req+' profil,metier from utilisateur as a';
                 req:=req + ' left join profil as b on a.cprofil=b.cprofil';
                 req:=req + ' left join activite as c on a.activite=c.cactiv';
                 req:=req+ ' where nom||" "||prenom = :nom';
                 datamodule2.fdQuerproc2.SQL.Text:=req;
                 datamodule2.fdQuerproc2.ParamByName('nom').AsString := cbuser.Selected.text;
                 datamodule2.fdQuerproc2.open;
                 id:=datamodule2.fdQuerproc2.FieldByName('iduser').AsInteger ;
                 edphon.Text:= datamodule2.fdQuerproc2.FieldByName('telephone').Asstring ;
                 edmel.Text:= datamodule2.fdQuerproc2.FieldByName('email').Asstring ;
                 edmdp.Text:= datamodule2.fdQuerproc2.FieldByName('pwd').Asstring ;
                 edpseudo.Text:= datamodule2.fdQuerproc2.FieldByName('pseudo').Asstring ;
                 eddeb.Text:= datamodule2.fdQuerproc2.FieldByName('datdeb').Asstring ;
                 edfin.Text:= datamodule2.fdQuerproc2.FieldByName('datfin').Asstring ;
                 edmaj.Text:= datamodule2.fdQuerproc2.FieldByName('datmaj').Asstring ;
                 cbProf.Selected.text:=datamodule2.fdQuerproc2.FieldByName('profil').Asstring ;
                 cbprof.Repaint;
                 cbActiv.Selected.Text:=datamodule2.fdQuerproc2.FieldByName('metier').Asstring ;
                 cbactiv.Repaint;
                 datamodule2.fdQuerproc2.Close;

end;

procedure TFBuser.FormActivate(Sender: TObject);
var
i:integer;
begin

     Datmaj := DateToStr(Date);
     btRec.enabled:=false;
     btMod.Enabled:=True;
     btCre.Enabled:=True;
     cbUser.Visible:=false;
      lbPren.Visible:=true;
      lbnom.Text:='Nom :';
      edPren.Visible:=true;
      ednom.Visible:=true;

   for i := 0 to Componentcount-1 do
         	begin
            		if (Components[i] is TEdit ) then
                     begin
                      TEdit(Components[i]).Text:='';
                     end;
                //if (Components[i] is TMemo ) then
                 //    begin
                 //     TMemo(Components[i]).Text:='';
                 //   end;
                 if (Components[i] is TComboBox ) and (TComboBox(Components[i]).Tag<>1) then
                     begin
                       TComboBox(Components[i]).items.Insert(0,'');
                       TComboBox(Components[i]).Tag:=1;
                       Tcombobox(components[i]).Items[0];
                     end
                     else   if (Components[i] is TComboBox ) then
                      Tcombobox(components[i]).Items[0];
                 //if (Components[i] is TDateEdit ) then
                   // begin
                    //   TDateEdit(Components[i]).Text:='';
                     //end;
          end;
end;

end.
