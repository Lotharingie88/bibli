unit bibli_revach;

interface

uses
  System.SysUtils,System.StrUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls,bibli, System.Rtti,System.DateUtils,FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid, FMX.ListBox, FMX.Edit, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.Grid,
  Data.Bind.DBScope, Data.Bind.Controls, Fmx.Bind.Navigator,uDB;

type
  TFbibli_revach = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    BtPrec: TButton;
    btQuit: TButton;
    Label1: TLabel;
    Label2: TLabel;
    cbAnn: TComboBox;
    cbMois: TComboBox;
    gRecach: TGrid;
    btAjout: TButton;
    edAn: TEdit;
    edMois: TEdit;
    FDQRach: TFDQuery;
    edTitre: TEdit;
    edPrix: TEdit;
    lbTit: TLabel;
    lbPri: TLabel;
    cbTit: TComboBox;
    FDQRcomp: TFDQuery;
    FDMemTable1: TFDMemTable;
    NavigatorBindSourceDB2: TBindNavigator;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    lbNum: TLabel;
    edNum: TEdit;
    ckAbo: TCheckBox;
    lbAbo: TLabel;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure BtPrecClick(Sender: TObject);
    procedure btQuitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbAnnChange(Sender: TObject);
    procedure edAnChange(Sender: TObject);

    procedure edMoisChange(Sender: TObject);
    procedure btAjoutClick(Sender: TObject);
    procedure cbTitChange(Sender: TObject);

    procedure cbMoisChange(Sender: TObject);
    procedure cbAnnClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Fbibli_revach: TFbibli_revach;
  ann,jour: Word;
  anm1,Mois,Moisn,moi0,moip1,moim1,moim2,moim3,Datmaj,actu,actuan: String;
  tot,idrevu: Integer;
  pri: Float64;

implementation

{$R *.fmx}
  uses bibli_revue;
procedure TFbibli_revach.btAjoutClick(Sender: TObject);
begin
      moi0:=ReplaceStr(LowerCase(edMois.text),'é','e');
      moi0:=ReplaceStr(LowerCase(moi0),'è','e');
      moi0:=ReplaceStr(LowerCase(moi0),'û','u');
      actu:=moi0;
      actuan:=edAn.text;
     if btAjout.Text='Ajouter' then
        begin
             lbTit.Visible:=True;
             lbPri.Visible:=True;
             lbNum.Visible:=True;
             lbAbo.Visible:=true;
             ckAbo.Visible:=true;
             edTitre.Visible:=True;
             edPrix.Visible:=True;
             edNum.Visible:=True;
             cbTit.Visible:=True;
             btAjout.Text:='Enregistrer';
        end
     else if btAjout.Text='Enregistrer' then
        begin
            if (edTitre.Text<>'') and (edPrix.text<>'') then
             begin
                  FDQRach.Close;
                  FDQRach.SQL.Clear;
                  FDQRach.SQL.Add('SELECT idrevue from revues where titrerevue=:tit');
                  FDQRach.ParamByName('tit').AsString :=edTitre.text;
                  FDQRach.Open;
                  idrevu:=FDQRach.FieldByName('idrevue').AsInteger;
                  FDQRach.Close;
                  FDQRach.SQL.Clear;
                  FDQRach.SQL.Add('SELECT count(*) as "Nb" from revues,achrev where titrerevue=:tit and annee=:an and idrevue=idrev');
                  FDQRach.ParamByName('an').AsInteger :=StrToInt(actuan ) ;
                  FDQRach.ParamByName('tit').AsString :=edTitre.text;
                  FDQRach.Open;
                  tot:=FDQRach.FieldByName('Nb').AsInteger;
                  FDQRach.Close;
                  FDQRach.SQL.Clear;
                  if tot=0 then
                     begin
                       //ShowMessage('insert'+inttostr(tot));
                        //insert
                          FDQRach.SQL.Add('INSERT into achrev(idrev');
                          FDQRach.SQL.Add(','+ actu);
                          FDQRach.SQL.Add(',annee,datmaj,numrevue) VALUES (:idtit,:pri,:an,:maj,:num)');
                          FDQRach.ParamByName('idtit').AsInteger := idrevu;
                          FDQRach.ParamByName('pri').AsFloat := StrToFloat(edPrix.text) ;
                          FDQRach.ParamByName('an').AsInteger :=StrToInt(actuan ) ;
                          FDQRach.ParamByName('maj').AsDate := StrToDate(Datmaj);
                          FDQRach.ParamByName('num').AsInteger := StrToInt(edNum.text);
                          FDQRach.ExecSQL;
                          edMois.text:=actu;
                          edAn.Text:=actuan;
                     end;
                   if tot=1 then
                     begin
                       ShowMessage(inttostr(idrevu) + 'update'+ inttostr(tot) + ','+ moi0);
                       //update
                       FDQRach.SQL.Clear;
                          FDQRach.SQL.Add('UPDATE achrev SET ' + actu);
                          FDQRach.SQL.Add('= :pri,datmaj= :maj,numrevue=:num  WHERE idrev= :idtit and annee=:an');
                          FDQRach.ParamByName('pri').AsString := edPrix.text ;
                          FDQRach.ParamByName('maj').AsDate := StrToDate(Datmaj);
                          FDQRach.ParamByName('idtit').AsInteger := idrevu;
                          FDQRach.ParamByName('num').AsInteger := StrToInt(edNum.text);
                          FDQRach.ParamByName('an').AsInteger :=StrToInt(actuan) ;
                          FDQRach.ExecSQL;
                          edMois.text:=actu;
                          edAn.Text:=actuan;
                     end;
                  
             end
             else
             begin
               ShowMessage('il faut sélectionner une revue ET saisir un prix');
             end;
             edMois.text:=actu;
             edAn.Text:=actuan;
             lbTit.Visible:=False;
             lbPri.Visible:=False;
             lbNum.Visible:=False;
             lbAbo.Visible:=false;
             ckAbo.Visible:=false;
             edTitre.Visible:=False;
             edPrix.Visible:=False;
             edNum.Visible:=False;
             edTitre.text:='';
             edPrix.text:='';
             edNum.text:='';
             cbTit.Visible:=False;
             btAjout.text:='Ajouter';
        end;

end;

procedure TFbibli_revach.BtPrecClick(Sender: TObject);
begin
    fbibli_revue.Show();
    fbibli_revach.Close;
end;

procedure TFbibli_revach.btQuitClick(Sender: TObject);
begin
     close;
end;

procedure TFbibli_revach.cbAnnChange(Sender: TObject);
begin
 if not(cbann.Selected.Text.IsEmpty) then
   begin
   edAn.text:= cbAnn.Selected.Text;
   cbann.tag:=strtoint(cbann.Selected.Text);
   end;
end;



procedure TFbibli_revach.cbAnnClick(Sender: TObject);
begin
   //cbann.tag:=strtoint(cbann.Selected.Text);
   moi0:=ReplaceStr(LowerCase(edMois.text),'é','e');
      moi0:=ReplaceStr(LowerCase(moi0),'è','e');
      moi0:=ReplaceStr(LowerCase(moi0),'û','u');
    if edAn.text<>'' then
       begin
            FDQRcomp.SQL.text:='';
            FDQRcomp.Close;
            FDQRcomp.SQL.Clear;
            FDQRcomp.SQL.text:='SELECT idrevue as "T" ,titrerevue as "Titre",' + moim3 +' ,'+ moim2 +' ,'+ moim1 + ' ,' + moi0 +' ,'+ moip1
             +' FROM revues,achrev where annee=:an and idrev=idrevue order by titrerevue' ;
             //FDQRcomp.ParamByName('an').AsInteger :=StrToInt(edAn.text)  ;
             FDQRcomp.ParamByName('an').AsInteger :=cbann.tag  ;
            FDQRcomp.Open;
        end;
//        gRecach.Columns[0].Width:=20;
//        gRecach.Columns[1].Width:=175;
//        gRecach.Columns[2].Width:=40;
//        gRecach.Columns[3].Width:=40;
//        gRecach.Columns[4].Width:=40;
//        gRecach.Columns[5].Width:=40;
//        gRecach.Columns[6].Width:=40;
    //gRecach.Columns[0].Width:=20;
    //gRecach.Columns[1].Width:=200;
end;

procedure TFbibli_revach.cbMoisChange(Sender: TObject);
begin
       edMois.text:= cbMois.Selected.Text;
end;

procedure TFbibli_revach.cbTitChange(Sender: TObject);
begin
  if cbTit.Selected.Text<>'' then
  begin
    edTitre.Text:= cbTit.Selected.Text;

  end
  else
  begin
     edTitre.Text:= '';
  end;

end;

procedure TFbibli_revach.edAnChange(Sender: TObject);
begin

      moi0:=ReplaceStr(LowerCase(edMois.text),'é','e');
      moi0:=ReplaceStr(LowerCase(moi0),'è','e');
      moi0:=ReplaceStr(LowerCase(moi0),'û','u');
      if edMois.text<>'' then
       begin
               if moi0='janvier' then
                    begin
                      moim3:='octobre';
                      moim2:='novembre' ;
                      moim1:= 'decembre';
                      moip1:= 'fevrier';
                      anm1:= inttostr(CurrentYear -1) ;
                    end
                    else if moi0='fevrier' then
                         begin
                              moim3:='novembre' ;
                              moim2:='decembre' ;
                              moim1:='janvier' ;
                              moip1:= 'mars';
                              anm1:= inttostr(CurrentYear -1);
                         end
                         else if moi0='mars' then
                              begin
                                moim3:='decembre' ;
                                moim2:= 'janvier';
                                moim1:='fevrier' ;
                                moip1:= 'avril';
                                anm1:=inttostr(CurrentYear -1) ;
                              end
                              else if moi0='avril' then
                                   begin
                                      moim3:='janvier' ;
                                      moim2:='fevrier' ;
                                      moim1:= 'mars';
                                      moip1:= 'mai';

                                    end
                                   else if moi0='mai' then
                                        begin
                                          moim3:='fevrier' ;
                                          moim2:= 'mars';
                                          moim1:='avril' ;
                                          moip1:='juin' ;

                                        end
                                        else if moi0='juin' then
                                             begin
                                                moim3:= 'mars';
                                                moim2:= 'avril';
                                                moim1:= 'mai';
                                                moip1:= 'juillet';

                                              end
                                             else if moi0='juillet' then
                                                 begin
                                                    moim3:= 'avril';
                                                    moim2:= 'mai';
                                                    moim1:= 'juin';
                                                    moip1:= 'aout';

                                                  end
                                                  else if moi0='aout' then
                                                      begin
                                                        moim3:= 'mai';
                                                        moim2:= 'juin';
                                                        moim1:= 'juillet';
                                                        moip1:= 'septembre';

                                                      end
                                                       else if moi0='septembre' then
                                                            begin
                                                              moim3:='juin' ;
                                                              moim2:='juillet' ;
                                                              moim1:= 'aout';
                                                              moip1:= 'octobre';

                                                            end
                                                            else if moi0='octobre' then
                                                                 begin
                                                                    moim3:= 'juillet';
                                                                    moim2:= 'aout';
                                                                    moim1:= 'septembre';
                                                                    moip1:= 'novembre';

                                                                  end
                                                                 else if moi0='novembre' then
                                                                     begin
                                                                        moim3:= 'aout';
                                                                        moim2:= 'septembre';
                                                                        moim1:='octobre' ;
                                                                        moip1:= 'decembre';

                                                                      end
                                                                      else if moi0='decembre' then
                                                                          begin
                                                                                  moim3:='septembre' ;
                                                                                  moim2:='octobre' ;
                                                                                  moim1:='novembre' ;
                                                                                  moip1:='janvier' ;
                                                                                  anm1:=inttostr(CurrentYear +1) ;
                                                                                end;
       end;
    if edAn.text<>'' then
       begin
            FDQRcomp.SQL.text:='';
            FDQRcomp.Close;
            FDQRcomp.SQL.Clear;
            FDQRcomp.SQL.text:='SELECT idrevue as "T" ,titrerevue as "Titre",' + moim3 +' ,'+ moim2 +' ,'+ moim1 + ' ,' + moi0 +' ,'+ moip1
             +' FROM revues,achrev where annee=:an and idrev=idrevue order by titrerevue' ;
             FDQRcomp.ParamByName('an').AsInteger :=StrToInt(edAn.text)  ;
            FDQRcomp.Open;
        end;
//        gRecach.Columns[0].Width:=20;
//        gRecach.Columns[1].Width:=175;
//        gRecach.Columns[2].Width:=40;
//        gRecach.Columns[3].Width:=40;
//        gRecach.Columns[4].Width:=40;
//        gRecach.Columns[5].Width:=40;
//        gRecach.Columns[6].Width:=40;
    //gRecach.Columns[0].Width:=20;
    //gRecach.Columns[1].Width:=200;
end;

procedure TFbibli_revach.edMoisChange(Sender: TObject);
begin
    //fdqrcomp.Active:=false;
     moi0:=ReplaceStr(LowerCase(edMois.text),'é','e');
     moi0:=ReplaceStr(LowerCase(moi0),'è','e');
     moi0:=ReplaceStr(LowerCase(moi0),'û','u');
     edMois.text:=moi0;
    if edMois.text<>'' then
       begin
               if moi0='janvier' then
                    begin
                      moim3:='octobre';
                      moim2:='novembre' ;
                      moim1:= 'decembre';
                      moip1:= 'fevrier';
                      anm1:= inttostr(CurrentYear -1) ;
                    end
                    else if moi0='fevrier' then
                         begin
                              moim3:='novembre' ;
                              moim2:='decembre' ;
                              moim1:='janvier' ;
                              moip1:= 'mars';
                              anm1:= inttostr(CurrentYear -1);
                         end
                         else if moi0='mars' then
                              begin
                                moim3:='decembre' ;
                                moim2:= 'janvier';
                                moim1:='fevrier' ;
                                moip1:= 'avril';
                                anm1:=inttostr(CurrentYear -1) ;
                              end
                              else if moi0='avril' then
                                   begin
                                      moim3:='janvier' ;
                                      moim2:='fevrier' ;
                                      moim1:= 'mars';
                                      moip1:= 'mai';

                                    end
                                   else if moi0='mai' then
                                        begin
                                          moim3:='fevrier' ;
                                          moim2:= 'mars';
                                          moim1:='avril' ;
                                          moip1:='juin' ;

                                        end
                                        else if moi0='juin' then
                                             begin
                                                moim3:= 'mars';
                                                moim2:= 'avril';
                                                moim1:= 'mai';
                                                moip1:= 'juillet';

                                              end
                                             else if moi0='juillet' then
                                                 begin
                                                    moim3:= 'avril';
                                                    moim2:= 'mai';
                                                    moim1:= 'juin';
                                                    moip1:= 'aout';

                                                  end
                                                  else if moi0='aout' then
                                                      begin
                                                        moim3:= 'mai';
                                                        moim2:= 'juin';
                                                        moim1:= 'juillet';
                                                        moip1:= 'septembre';

                                                      end
                                                       else if moi0='septembre' then
                                                            begin
                                                              moim3:='juin' ;
                                                              moim2:='juillet' ;
                                                              moim1:= 'aout';
                                                              moip1:= 'octobre';

                                                            end
                                                            else if moi0='octobre' then
                                                                 begin
                                                                    moim3:= 'juillet';
                                                                    moim2:= 'aout';
                                                                    moim1:= 'septembre';
                                                                    moip1:= 'novembre';

                                                                  end
                                                                 else if moi0='novembre' then
                                                                     begin
                                                                        moim3:= 'aout';
                                                                        moim2:= 'septembre';
                                                                        moim1:='octobre' ;
                                                                        moip1:= 'decembre';

                                                                      end
                                                                      else if moi0='decembre' then
                                                                          begin
                                                                                  moim3:='septembre' ;
                                                                                  moim2:='octobre' ;
                                                                                  moim1:='novembre' ;
                                                                                  moip1:='janvier' ;
                                                                                  anm1:=inttostr(CurrentYear +1) ;
                                                                                end;
           FDQRcomp.Close;
           FDQRcomp.SQL.Clear;
           FDQRcomp.SQL.text:='SELECT idrevue as "T" ,titrerevue as "Titre" ,'+ moim3 ;
           FDQRcomp.SQL.Add(' ,'+ moim2) ;
           FDQRcomp.SQL.Add(' ,'+ moim1) ;
           FDQRcomp.SQL.Add(' ,'+ moi0) ;
           FDQRcomp.SQL.Add(' ,'+ moip1) ;
           FDQRcomp.SQL.Add(' FROM revues,achrev where annee=:an and idrevue=idrev order by titrerevue') ;
           FDQRcomp.ParamByName('an').AsInteger :=StrToInt(edAn.text ) ;
           FDQRcomp.Open;
           FDQRcomp.FieldByName('T').AsInteger;
           FDQRcomp.FieldByName('Titre').AsString;
        end;
    gRecach.Columns[0].Width:=20;
    gRecach.Columns[1].Width:=175;
    gRecach.Columns[2].Width:=40;
    gRecach.Columns[3].Width:=40;
    gRecach.Columns[4].Width:=40;
    gRecach.Columns[5].Width:=40;
    gRecach.Columns[6].Width:=40;

end;

procedure TFbibli_revach.FormActivate(Sender: TObject);
begin
        anm1:='';
        Datmaj := DateToStr(Date);
        edAn.text:=inttostr(CurrentYear);
        DateTimetoString(Mois,'mmmm',date);
        Mois:=ReplaceStr(LowerCase(Mois),'é','e');
        Mois:=ReplaceStr(LowerCase(Mois),'è','e');
        Mois:=ReplaceStr(LowerCase(Mois),'û','u');
        edMois.text:=Mois;
        //edMois.text:=FormatDateTime('mmmm',now);
//        cbTit.Items.Add('');
//        FDQRach.Close;
//        FDQRach.SQL.Clear;
//        FDQRach.SQL.text:='SELECT titrerevue FROM revues where flok="O" order by titrerevue' ;
//        FDQRach.Open;
//        FDQRach.First;
//            while not FDQRach.Eof do
//             begin
//               cbTit.Items.Add( FDQRach.FieldByName('titrerevue').AsString);
//               FDQRach.Next;
//             end;

    if edMois.text<>'' then
       begin
         moi0:=Mois;
               if moi0='janvier' then
                    begin
                      moim3:='octobre';
                      moim2:='novembre' ;
                      moim1:='decembre';
                      moip1:='fevrier';
                      anm1:= inttostr(CurrentYear -1) ;
                    end
                    else if moi0='fevrier' then
                         begin
                              moim3:='novembre' ;
                              moim2:='decembre' ;
                              moim1:='janvier' ;
                              moip1:='mars';
                              anm1:= inttostr(CurrentYear -1);
                         end
                         else if moi0='mars' then
                              begin
                                moim3:='decembre' ;
                                moim2:='janvier';
                                moim1:='fevrier' ;
                                moip1:='avril';
                                anm1:=inttostr(CurrentYear -1) ;
                              end
                              else if moi0='avril' then
                                   begin
                                      moim3:='janvier' ;
                                      moim2:='fevrier' ;
                                      moim1:='mars';
                                      moip1:='mai';
                                      anm1:='' ;
                                    end
                                   else if moi0='mai' then
                                        begin
                                          moim3:='fevrier' ;
                                          moim2:='mars';
                                          moim1:='avril' ;
                                          moip1:='juin' ;
                                          anm1:='' ;
                                        end
                                        else if moi0='juin' then
                                             begin
                                                moim3:='mars';
                                                moim2:='avril';
                                                moim1:='mai';
                                                moip1:='juillet';
                                                anm1:='' ;
                                              end
                                             else if moi0='juillet' then
                                                 begin
                                                    moim3:='avril';
                                                    moim2:='mai';
                                                    moim1:='juin';
                                                    moip1:='aout';
                                                    anm1:='' ;
                                                  end
                                                  else if moi0='aout' then
                                                      begin
                                                        moim3:='mai';
                                                        moim2:='juin';
                                                        moim1:='juillet';
                                                        moip1:='septembre';
                                                        anm1:='' ;
                                                      end
                                                       else if moi0='septembre' then
                                                            begin
                                                              moim3:='juin' ;
                                                              moim2:='juillet' ;
                                                              moim1:= 'aout';
                                                              moip1:= 'octobre';
                                                              anm1:='' ;
                                                            end
                                                            else if moi0='octobre' then
                                                                 begin
                                                                    moim3:= 'juillet';
                                                                    moim2:= 'aout';
                                                                    moim1:= 'septembre';
                                                                    moip1:= 'novembre';
                                                                    anm1:='' ;
                                                                  end
                                                                 else if moi0='novembre' then
                                                                     begin
                                                                        moim3:= 'aout';
                                                                        moim2:= 'septembre';
                                                                        moim1:='octobre' ;
                                                                        moip1:= 'decembre';
                                                                        anm1:='' ;
                                                                      end
                                                                      else if moi0='decembre' then
                                                                          begin
                                                                                  moim3:='septembre' ;
                                                                                  moim2:='octobre' ;
                                                                                  moim1:='novembre' ;
                                                                                  moip1:='janvier' ;
                                                                                  anm1:=inttostr(CurrentYear +1) ;
                                                                                end;
       end;
//      if (edAn.text<>'') and (edMois.text<>'') then
//       begin
//           FDQRcomp.Close;
//           FDQRcomp.SQL.Clear;
//           FDQRcomp.SQL.Add('SELECT idrevue as "T",titrerevue as "Titre"');
//           FDQRcomp.SQL.Add(' ,'+ moim3) ;
//           FDQRcomp.SQL.Add(' ,'+ moim2) ;
//           FDQRcomp.SQL.Add(' ,'+ moim1) ;
//           FDQRcomp.SQL.Add(' ,'+ moi0) ;
//           FDQRcomp.SQL.Add(' ,'+ moip1) ;
//           FDQRcomp.SQL.Add(' FROM revues,achrev where annee=:an');
//           //if anm1<>'' then
//             // begin
//             //      FDQRcomp.SQL.Add(' or annee=:anm1');
//              // end;
//           FDQRcomp.SQL.Add(' and idrevue=idrev order by titrerevue') ;
//           FDQRcomp.ParamByName('an').AsInteger := StrToInt(edAn.text)  ;
//           //if anm1<>'' then
//             // begin
//              //     FDQRcomp.ParamByName('anm1').AsInteger := StrToInt(anm1);
//              // end;
//           FDQRcomp.Open;
//           FDQRcomp.FieldByName('T').AsInteger;
//           FDQRcomp.FieldByName('Titre').AsString;
//        end;
//    gRecach.Columns[0].Width:=20;
//    gRecach.Columns[1].Width:=200;
//    gRecach.Columns[2].Width:=40;
//    gRecach.Columns[3].Width:=40;
//    gRecach.Columns[4].Width:=40;
//    gRecach.Columns[5].Width:=40;
//    gRecach.Columns[6].Width:=40;
//     gRecach.UpdateContentSize;
end;



end.
