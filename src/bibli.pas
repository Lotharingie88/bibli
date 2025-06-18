unit bibli;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Phys.MySQLDef, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.TabControl,uDB, FireDAC.FMXUI.Login,
  FireDAC.Comp.UI, FMX.Edit, FMX.Layouts,FMX.Platform,System.Hash;

type
  TFBibli = class(TForm)
    FDQueryMYSQL: TFDQuery;
    Panel1: TPanel;
    btQuit: TButton;
    btCreate: TButton;
    btSync: TButton;
    ToolBar1: TToolBar;
    TabControl1: TTabControl;
    TabLivr: TTabItem;
    TabRevu: TTabItem;
    TabDVD: TTabItem;
    TabCD: TTabItem;
    btBudg: TButton;
    btAdmin: TButton;
    FDQuerySQLITE: TFDQuery;
    FDQuerySQLITE2: TFDQuery;
    FDQuerySQLITE3: TFDQuery;
    layConnect: TLayout;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edLog: TEdit;
    EdMdp: TEdit;
    edMel: TEdit;
    btNouvU: TButton;
    btConnect: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edNom: TEdit;
    edPren: TEdit;
    edPmdp: TEdit;
    Label8: TLabel;
    TabAide: TTabItem;
    TabAprop: TTabItem;
    procedure btSyncClick(Sender: TObject);
    procedure btQuitClick(Sender: TObject);
    procedure TabLivrClick(Sender: TObject);
    procedure btBudgClick(Sender: TObject);
    procedure TabRevuClick(Sender: TObject);
    procedure TabDVDClick(Sender: TObject);
    procedure TabCDClick(Sender: TObject);
    procedure btAdminClick(Sender: TObject);
    procedure btConnectClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btNouvUClick(Sender: TObject);
    procedure TabApropClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FBibli: TFBibli;


implementation

{$R *.fmx}



uses bibli_liv1,bibli_revue,bibli_budget,bibli_dvd,bibli_cd,bibli_user,admin,bibli_aprop;
  var
    datmaj:string;
procedure TFBibli.btSyncClick(Sender: TObject);
var
 i,j,card,ind  : integer;
//champMysql: Variant;
 nomchps,nomchpsind,table,champs,champsMysql,typch,paramconv,paramtyp,valel : string ;
 element : array of array[0..4] of string;
begin
     //SetLength(element,0,4);
     //ind:=0;
    FDQuerySQLITE.SQL.Clear;
    FDQuerySQLITE.SQL.Text:='SELECT name from sqlite_master where type= "table" and name not like "sqlite_%" order by name';
    FDQuerySQLITE.Open;
    FDQuerySQLITE.First;
    while not FDQuerySQLITE.Eof do
         begin
             table := FDQuerySQLITE.FieldByName('name').AsString;
             FDQuerySQLITE2.SQL.Clear;
             FDQuerySQLITE2.SQL.Text:='pragma table_info('+table+')';
             FDQuerySQLITE2.Open;
             FDQuerySQLITE2.First;
             i:=0;
             while not FDQuerySQLITE2.Eof do
                         begin
                           champs:= FDQuerySQLITE2.FieldByName('name').AsString;
                           typch:= FDQuerySQLITE2.FieldByName('type').AsString;
                            if typch = 'INTEGER'then
                                 begin
                                 paramconv:='AsInteger' ;
                                 paramtyp:='2';
                                 end
                                 else  if typch = 'TEXT'then
                                 begin
                                 paramconv:='AsString';
                                 paramtyp:='1' ;
                                 end
                                 else  if typch = 'REAL'then
                                 begin
                                 paramconv:='AsFloat';
                                 paramtyp:='3';
                                 end
                                 else  if typch = 'BLOB'then
                                 begin
                                 paramconv:='AsString';
                                 paramtyp:='4';
                                 end
                                 else  if typch = 'NUMERIC'then
                                 begin
                                 paramconv:='AsDatetime';
                                 paramtyp:='5';
                                 end
                                 else  if typch = 'DATE'then
                                 begin
                                 paramconv:='AsDate';
                                 paramtyp:='6';
                                 end
                                 else  if typch = 'DATETIME'then
                                 begin
                                 paramconv:='AsDatetime';
                                 paramtyp:='7';
                                 end;
                            //ShowMessage ('table :' + table +' champ : ' + champs + ' type :'+typch + ' '+ IntToStr(i));
                            //champsMysql:=FDQueryMYSQL.FieldByName(champs).AsVariant;

                            card:=Length(element);
                            setlength(element,card+1);
                            element[i,0]:=champs;
                            element[i,1]:=typch;
                            element[i,2]:=paramconv;
                            element[i,3]:=paramtyp;
                            valel:=element[i,3];
                             i:=i+1;

                             //showmessage(valel);
                            FDQuerySQLITE2.next;
                         end;
                       //idauteur:=FDQueryMYSQL.FieldByName('idauteur').AsInteger;
                       card:=Length(element);
                       ShowMessage ('Table : '+table +' Nombre de champs : ' + IntToStr(card));
             ind:=0;
             FDQueryMYSQL.SQL.Clear;
             FDQueryMYSQL.SQL.Text:='SELECT * from ' + table ;
             FDQueryMYSQL.Open;
             FDQueryMYSQL.First;
               //j:=0;
             while not FDQueryMYSQL.Eof do
                   begin
                       //indchps:= element[0][0];
                       //ind:=FDQueryMYSQL.FieldByName(indchps).AsInteger;
                       j:=0;
                       while j<=card-1 do
                       begin
                       nomchps:= element[j,0];
                       //ind:=FDQueryMYSQL.FieldByName(indchps).AsInteger;
                       //champdata:=FDQueryMYSQL.FieldByName(indchps).element[j][2];
                       if FDQueryMYSQL.FieldByName(nomChps).IsNull then
                        champsMysql:='0'
                        else
                       champsMysql:=FDQueryMYSQL.FieldByName(nomChps).AsVariant;
                       FDQuerySQLITE3.SQL.Clear;
                        //ShowMessage ('Table :' + table +'Lignes dans la table : ' + IntToStr(ind)  + ' data :' + VarToStr(champsMysql) + ' Nb de champs dans table :'+ IntToStr(card) );
                       if j=0 then
                        begin
                            nomchpsind:= element[j,0];
                             //ShowMessage ('Index : ' + IntToStr(ind) + ' champs: ' + element[j,0] + ' data :' + VarToStr(champsMysql) + ' card :'+ IntToStr(card) );
                             FDQuerySQLITE3.SQL.Text:='INSERT into ' + table +'('+ element[j,0] +') VALUES (:champSqlite)';
                             FDQuerySQLITE3.ParamByName('champSqlite').AsInteger := StrtoInt(champsMysql);
                             ind:= FDQuerySQLITE3.ParamByName('champSqlite').AsInteger;
                        end
                        else
                        begin
                            // ShowMessage (' champs: ' + element[j,0] + ' data :' + champsMysql + 'type :' + element[j,2] +','+  element[j,3]+  ' card :'+ IntToStr(card) );
                             FDQuerySQLITE3.SQL.Text:='UPDATE ' + table +' SET '+ element[j,0] +' = :champSqlite  WHERE ' + nomchpsind +' = :index' ;
                             FDQuerySQLITE3.ParamByName('index').AsInteger := ind;
                             case StrtoInt(element[j,3]) of
                               1: FDQuerySQLITE3.ParamByName('champSqlite').AsString :=  champsMysql;
                               2: FDQuerySQLITE3.ParamByName('champSqlite').AsInteger :=  strtoint(champsMysql);
                               3: FDQuerySQLITE3.ParamByName('champSqlite').AsFloat :=  StrtoFloat(champsMysql);
                               4: FDQuerySQLITE3.ParamByName('champSqlite').AsString :=  champsMysql;
                               5: FDQuerySQLITE3.ParamByName('champSqlite').AsDatetime :=  StrToDateTime(champsMysql);
                               6: if champsMysql<>'00:00:00' then FDQuerySQLITE3.ParamByName('champSqlite').AsDate := StrToDate(champsMysql) else FDQuerySQLITE3.ParamByName('champSqlite').AsString := '0000-00-00';
                               //6: FDQuerySQLITE3.ParamByName('champSqlite').AsDate := StrToDate(champsMysql);
                               7: FDQuerySQLITE3.ParamByName('champSqlite').AsDatetime :=  StrToDateTime(champsMysql);
                             end;
                             //FDQuerySQLITE3.ParamByName('champSqlite').AsInteger :=  strtoint(champsMysql);

                        end;
                         FDQuerySQLITE3.ExecSQL;

                        j:=j+1;
                        end;
                       FDQueryMYSQL.Next;
                       //ShowMessage ('Table :' + table +' Lignes dans la table : ' + IntToStr(ind)  + ' data :' + VarToStr(champsMysql) + ' Nb de champs dans table :'+ IntToStr(card) );
                   end;
                   ShowMessage ('Table : ' + table +' , Lignes dans la table : ' + IntToStr(ind)  +  ' , Nb de champs dans table :'+ IntToStr(card) + chr(13) + chr(10) + 'Table locale : "' + table + '" synchronisée' );
                   SetLength(element,0);

                   FDQuerySQLITE.Next;
        end;
end;

procedure TFBibli.btNouvUClick(Sender: TObject);
  var
    id, nb:integer;
    prof,pseu:string;
begin
    if (edNom.Text<>'') and (edPren.Text<>'') then
                 begin
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select count(*) as nb from utilisateur where nom=:nom and prenom=:pren';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := edNom.text;
                 datamodule2.fdQuerproc.ParamByName('pren').AsString := edPren.text;
                 datamodule2.fdQuerproc.open;
                 nb:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 if nb=0 then
                    begin
                        if edpmdp.text ='' then
                          begin
                            showmessage('Il faut saisir un mot de passe (8 caract. minimum). ');
                            exit;
                          end;
                        if edMel.Text='' then
                          begin
                            showmessage('Il faut saisir une adresse mail. ');
                            exit;
                          end;
                    //begin
                         datamodule2.fdQuerproc.SQL.Text:='INSERT into utilisateur(nom,prenom,email,pwd,datdeb, datmaj) VALUES (:nom,:pren,:mel,:mdp,:deb,:maj)';
                       datamodule2.fdQuerproc.ParamByName('nom').AsString := ednom.Text;
                       datamodule2.fdQuerproc.ParamByName('pren').Asstring := edpren.text;
                       datamodule2.fdQuerproc.ParamByName('mel').Asstring := edMel.text;
                       datamodule2.fdQuerproc.ParamByName('mdp').AsString := THashSHA2.GetHashString(edMdp.text,THashSHA2.TSHA2Version.SHA512).ToUpper ;
                       datamodule2.fdQuerproc.ParamByName('deb').AsDate := StrToDate(Datmaj);
                       datamodule2.fdQuerproc.ParamByName('maj').AsDate := StrToDate(Datmaj);
                       datamodule2.fdQuerproc.ExecSQL;
                       datamodule2.fdQuerproc.Close;
                       showmessage('Un message de confirmation va être envoyé sur votre mail ');
                       layConnect.Visible:=false;
                    end
                    else
                    begin
                       showMessage('Il existe déjà un utilisateur avec ce nom!');
                    end;
                 end
                 else
                 begin
                   showMessage('Saisissez votre nom et prénom!');
                 end;
end;

procedure TFBibli.FormActivate(Sender: TObject);
  var
    i:integer;
begin
  Datmaj := DateToStr(Date);
  btCreate.Enabled:=false;
  btSync.Enabled:=false;
  for i := 0 to Componentcount-1 do
          	begin
            		if (Components[i] is TEdit ) then
                     begin
                       TEdit(Components[i]).Text:='';
                     end;
//                if (Components[i] is TMemo ) then
//                     begin
//                       TMemo(Components[i]).Text:='';
//                     end;
//                 if (Components[i] is TComboBox ) and (TComboBox(Components[i]).Tag<>1) then
//                     begin
//                       TComboBox(Components[i]).items.Insert(0,'');
//                       TComboBox(Components[i]).Tag:=1;
//                       Tcombobox(components[i]).Items[0];
//                     end
//                     else   if (Components[i] is TComboBox ) then
//                      Tcombobox(components[i]).Items[0];
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

procedure TFBibli.btConnectClick(Sender: TObject);
  var
    id, nb:integer;
    prof,pseu:string;
begin
    if (edLog.text<>'') and (edMdp.text<>'') then
      begin
                datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select count(*) as nb from utilisateur where pseudo=:nom and pwd=:mdp';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := edLog.text;
                 datamodule2.fdQuerproc.ParamByName('mdp').AsString := THashSHA2.GetHashString(edMdp.text,THashSHA2.TSHA2Version.SHA512).ToUpper ;
                 datamodule2.fdQuerproc.open;
                 nb:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 if nb=1 then
                    begin
                      datamodule2.fdQuerproc.SQL.Clear;
                      datamodule2.fdQuerproc.SQL.Text:='select  iduser,pseudo,b.profil from utilisateur as a left join profil as b on a.cprofil=b.cprofil where pseudo=:nom and pwd=:mdp';
                      datamodule2.fdQuerproc.ParamByName('nom').AsString := edLog.text;
                      datamodule2.fdQuerproc.ParamByName('mdp').AsString := THashSHA2.GetHashString(edMdp.text,THashSHA2.TSHA2Version.SHA512).ToUpper ;
                      datamodule2.fdQuerproc.open;
                      id:=datamodule2.fdQuerproc.FieldByName('iduser').AsInteger ;
                      pseu:= datamodule2.fdQuerproc.FieldByName('pseudo').AsString ;
                      prof:=datamodule2.fdQuerproc.FieldByName('profil').AsString ;
                      datamodule2.fdQuerproc.Close;
                      datamodule2.fdQuerproc.SQL.Clear;
                      if prof='ADMIN' then
                        begin
                           btAdmin.visible:=true;
                           btBudg.Visible:=true;
                           tabLivr.Enabled:=true;
                           tabCd.Enabled:=true;
                           tabDvd.Enabled:=true;
                           tabRevu.Enabled:=true;
                           btCreate.enabled:=true;
                           btSync.enabled:=true;
                        end;
                      If prof='UTILISATEUR' then
                       begin
                            btAdmin.visible:=false;
                            btBudg.Visible:=false;
                            tabLivr.Enabled:=true;
                           tabCd.Enabled:=true;
                           tabDvd.Enabled:=true;
                           tabRevu.Enabled:=true;
                           btCreate.enabled:=false;
                           btSync.enabled:=false;
                       end;
                      If prof='EMPRUNTEUR' then
                        begin
                            btAdmin.visible:=false;
                            btBudg.Visible:=false;
                            tabLivr.Enabled:=true;
                           tabCd.Enabled:=true;
                           tabDvd.Enabled:=true;
                           tabRevu.Enabled:=true;
                           btCreate.enabled:=false;
                           btSync.enabled:=false;
                        end;
                       //datamodule2.fdQuerproc.SQL.Text:='INSERT into session(idsession,nom,prenom,pseudo,datdeb) VALUES (:idsess,:nom,:pren,:pseu,:deb)';
                       datamodule2.fdQuerproc.SQL.Text:='INSERT into session(nom,prenom,pseudo,datdeb) VALUES (:nom,:pren,:pseu,:deb)';
                       datamodule2.fdQuerproc.ParamByName('nom').AsString := ednom.Text;
                       datamodule2.fdQuerproc.ParamByName('pren').Asstring := edpren.text;
                       datamodule2.fdQuerproc.ParamByName('pseu').Asstring := pseu;
                       //datamodule2.fdQuerproc.ParamByName('deb').AsString := eddeb.text ;
                       datamodule2.fdQuerproc.ParamByName('deb').AsDate := StrToDate(Datmaj);
                       datamodule2.fdQuerproc.ExecSQL;
                       datamodule2.fdQuerproc.Close;
                       layConnect.Visible:=false;
                    end;
                    if nb=0 then
                      begin
                          showmessage('Votre login et/ou mot de passe est erroné ! Réessayez ou enregistrez vous ! ');
                          edlog.Text:='';
                          edmdp.Text:='';
                          edlog.CanFocus:=true;
                      end;
      end
      else
      begin
         showmessage('Certains champs ne sont pas renseignés ! Réessayez ! ');
      end;

    //layConnect.Visible:=false;
end;

procedure TFBibli.TabLivrClick(Sender: TObject);
begin
 Fliv.show;
end;

procedure TFBibli.TabRevuClick(Sender: TObject);
begin
     Fbibli_revue.Show;
end;

procedure TFBibli.TabDVDClick(Sender: TObject);
begin
 Fdvd.show;
end;

procedure TFBibli.TabApropClick(Sender: TObject);
begin
  FAprop.Show;
end;

procedure TFBibli.TabCDClick(Sender: TObject);
begin
  Fcd.Show;
end;

procedure TFBibli.btAdminClick(Sender: TObject);
begin
    fadmin.show;
end;

procedure TFBibli.btBudgClick(Sender: TObject);
begin
     FBudget.Show;
end;

procedure TFBibli.btQuitClick(Sender: TObject);
begin
  close();
end;

end.
