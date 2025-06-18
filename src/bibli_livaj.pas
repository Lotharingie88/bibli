unit bibli_livaj;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox, FMX.Edit, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  FireDAC.Comp.DataSet, Data.Bind.DBScope,udb;

type
  TFlivaj = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btValid: TButton;
    btQuit: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edTitre: TEdit;
    edNom: TEdit;
    edPren: TEdit;
    cbThem: TComboBox;
    cbPoch: TComboBox;
    edCPoch: TEdit;
    edIsbn: TEdit;
    cbEdit: TComboBox;
    Panel1: TPanel;
    rbO: TRadioButton;
    rbN: TRadioButton;
    mDigest: TMemo;
    edNot: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    mAvis: TMemo;
    BindingsList1: TBindingsList;
    btAjou: TButton;
    btModif: TButton;
    cbTitre: TComboBox;
    fdqLivA: TFDQuery;
    edParut: TEdit;
    Label12: TLabel;
    fdqCompl: TFDQuery;
    BindSourceDB2: TBindSourceDB;
    BindSourceDB3: TBindSourceDB;
    BindSourceDB4: TBindSourceDB;
    BindSourceDB1: TBindSourceDB;
    BindSourceDB5: TBindSourceDB;
    BindSourceDB6: TBindSourceDB;
    BindSourceDB7: TBindSourceDB;
    Label13: TLabel;
    edMaj: TEdit;
    cbAuteur: TComboBox;
    BindSourceDB8: TBindSourceDB;
    LinkFillControlToField: TLinkFillControlToField;
    LinkFillControlToField2: TLinkFillControlToField;
    LinkFillControlToField3: TLinkFillControlToField;
    LinkFillControlToField4: TLinkFillControlToField;
    LinkFillControlToField5: TLinkFillControlToField;
    procedure btQuitClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);
    procedure btModifClick(Sender: TObject);
    procedure btAjouClick(Sender: TObject);
    procedure btValidClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbTitreChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Flivaj: TFlivaj;

implementation

{$R *.fmx}
 uses bibli_liv1;
 var
 Datmaj : String;
 req:string;
 cod,coda,codn,codn2,coded,codedp,codt : integer;
procedure TFlivaj.btAjouClick(Sender: TObject);
begin
     edTitre.Visible:=True;
     cbTitre.Visible:=False;
     edNom.Visible:=false;
     edPren.Visible:=false;
     edMaj.Text:='';
     cbAuteur.Visible:=true;
     btValid.Enabled:=True;
     btModif.Enabled:=False;
end;

procedure TFlivaj.btModifClick(Sender: TObject);
begin
     edTitre.Visible:=false;
     cbTitre.Visible:=True;
     cbAuteur.Visible:=false;
     btValid.Enabled:=True;
     btAjou.Enabled:=False;
end;

procedure TFlivaj.btPrecClick(Sender: TObject);
begin
  Fliv.show();
  Flivaj.Close;

end;

procedure TFlivaj.btQuitClick(Sender: TObject);
begin
  close();

end;

procedure TFlivaj.btValidClick(Sender: TObject);
var
  i: integer;
begin
   fdqCompl.Close;
     fdqCompl.SQL.Clear;
     fdqCompl.SQL.Text := 'SELECT idauteur,idnation FROM auteur where nomauteur= :naut and prenauteur =:prenaut';
     fdqCompl.ParamByName('naut').AsString := edNom.Text ;
     fdqCompl.ParamByName('prenaut').AsString := edPren.Text ;
     fdqCompl.Open;
     coda:=fdqCompl.FieldByName('idauteur').AsInteger;
     codn:=fdqCompl.FieldByName('idnation').AsInteger;
     fdqCompl.SQL.Clear;
     fdqCompl.Close;
     fdqCompl.SQL.Clear;
     fdqCompl.SQL.Text := 'SELECT idauteur,idnation FROM auteur where nomauteur||" "||prenauteur = :nom';
     fdqCompl.ParamByName('nom').AsString := cbAuteur.Selected.Text ;
     fdqCompl.Open;
     cod:=fdqCompl.FieldByName('idauteur').AsInteger;
     codn2:=fdqCompl.FieldByName('idnation').AsInteger;
     fdqCompl.SQL.Clear;
     fdqCompl.SQL.Text := 'SELECT idediteur FROM editeur where nomedit= :nedi ';
     fdqCompl.ParamByName('nedi').AsString := cbEdit.Selected.Text ;
     fdqCompl.Open;
     coded:=fdqCompl.FieldByName('idediteur').AsInteger;
     fdqCompl.SQL.Clear;
     fdqCompl.SQL.Text := 'SELECT ideditionpoche FROM editionpoche where editpoch= :nedip ';
     fdqCompl.ParamByName('nedip').AsString := cbPoch.Selected.Text ;
     fdqCompl.Open;
     codedp:=fdqCompl.FieldByName('ideditionpoche').AsInteger;
     fdqCompl.SQL.Clear;
     fdqCompl.SQL.Text := 'SELECT idtheme FROM thematique where theme= :them ';
     fdqCompl.ParamByName('them').AsString := cbThem.Selected.Text ;
     fdqCompl.Open;
     codt:=fdqCompl.FieldByName('idtheme').AsInteger;
     fdqLivA.close;
     fdqLivA.SQL.Clear;
    if btAjou.Enabled=True then
     begin
      //insert
      fdqLivA.SQL.Text:='INSERT into livres(titre,idauteur,idediteur,ideditionpoche,codepoche,idthem,isbn,datparut,idnation,resume,avis,note,poss,datmaj) VALUES (:tit,:aut,:nedi,:nedip,:cpoch,:them,:isb,:dpar,:nat,:res,:av,:nota,:ai,:datmaj)';
                 fdqLivA.ParamByName('tit').AsString := edTitre.Text;
                 fdqLivA.ParamByName('aut').AsInteger := cod;
                 fdqLivA.ParamByName('nedi').AsInteger := coded;
                 fdqLivA.ParamByName('nedip').AsInteger := codedp;
                 fdqLivA.ParamByName('cpoch').AsString := edCPoch.Text;
                 fdqLivA.ParamByName('them').AsInteger := codt;
                 fdqLivA.ParamByName('isb').AsString := edIsbn.text ;
                 if edParut.Text<>'' then
                 fdqLivA.ParamByName('dpar').AsInteger := StrToInt(edParut.Text)
                 else
                 fdqLivA.ParamByName('dpar').Asstring :='';
                 fdqLivA.ParamByName('nat').AsInteger := codn2;
                 fdqLivA.ParamByName('res').AsString := mDigest.Text ;
                 fdqLivA.ParamByName('av').AsString := mAvis.Text ;
                 if (edNot.text.IsEmpty=True) then
                    fdqLivA.ParamByName('nota').AsInteger := -0
                    else
                    fdqLivA.ParamByName('nota').AsInteger := strtoint(edNot.Text) ;
                 if rbO.IsChecked=true then
                     fdqLivA.ParamByName('ai').AsInteger := 1 ;
                  if rbN.IsChecked=true then
                     fdqLivA.ParamByName('ai').AsInteger := 0 ;

                 fdqLivA.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
    end
    else
    if btModif.Enabled=True then
    begin
      //update
       //fdqCompl.SQL.Clear;
      // fdqCompl.SQL.Text:='SELECT idtitre,prix,datach,nomauteur,prenauteur from livres,achat,auteur where titre =:tit and achat.idliv=livres.idtitre and livres.idauteur =auteur.idauteur ' ;
      // fdqCompl.ParamByName('tit').AsString := cbTitre.Selected.Text;
      // fdqCompl.Open;
       //edPrix.Text:=fdqCompl.FieldByName('prix').AsString;


              req:='UPDATE livres SET idauteur = :aut,idediteur=:nedi,ideditionpoche=:nedip,';
              req:=req + 'codepoche=:cpoch,idthem=:them,isbn=:isb,datparut=:dpar,idnation=:nat,';
              req:= req + 'resume=:res,avis=:av,note=:nota,poss=:ai, datmaj = :maj  WHERE titre = :tit' ;
              fdqLivA.SQL.Text:=req;

              fdqLivA.ParamByName('aut').AsInteger := coda;
              fdqLivA.ParamByName('nedi').AsInteger  := coded;
              fdqLivA.ParamByName('nedip').AsInteger := codedp;
              fdqLivA.ParamByName('cpoch').AsString := edcpoch.Text;
              fdqLivA.ParamByName('them').AsInteger := codt;
              fdqLivA.ParamByName('isb').AsString := edisbn.Text;
              if edparut.Text <>'' then
              fdqLivA.ParamByName('dpar').AsInteger := strtoint(edParut.Text)
              else
               fdqLivA.ParamByName('dpar').AsString :='' ;
              fdqLivA.ParamByName('nat').AsInteger  := codn;
              fdqLivA.ParamByName('res').AsString := mDigest.Text ;
              fdqLivA.ParamByName('av').AsString := mavis.Text;
              if (edNot.text.IsEmpty=True) then
                    fdqLivA.ParamByName('nota').AsInteger := -0
                    else
                    fdqLivA.ParamByName('nota').AsInteger := strtoint(edNot.Text) ;
              if rbO.IsChecked=true then
                     fdqLivA.ParamByName('ai').AsInteger := 1 ;
              if rbN.IsChecked=true then
                     fdqLivA.ParamByName('ai').AsInteger := 0 ;
              fdqLivA.ParamByName('maj').AsDate := StrToDate(Datmaj);
              fdqLivA.ParamByName('tit').AsString := cbTitre.Selected.Text;
    end;
    fdqLivA.ExecSQL;
    fdqliva.Close;
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


     btModif.Enabled:=True;
     btValid.Enabled:=False;
     btAjou.Enabled:=True;

end;

procedure TFlivaj.cbTitreChange(Sender: TObject);
begin
  if cbTitre.Selected.Text<>'' then
  begin
     datamodule2.FDQuerProc.Close;
     datamodule2.FDQuerProc.SQL.Clear;
      req:='select idtitre, b.nomauteur,b.prenauteur,isbn,datparut,resume,avis,note,a.datmaj,c.theme,codepoche,e.editpoch,f.nomedit,d.idach,poss';
      req:=req+ ' from  livres as a left join auteur as b on a.idauteur=b.idauteur left join thematique as c on a.idthem=c.idtheme left join achat as d on a.idtitre=d.idliv' ;
      req:= req + ' left join editionpoche as e on a.ideditionpoche=e.ideditionpoche left join editeur as f on a.idediteur=f.idediteur where titre =:tit';
     datamodule2.FDQuerProc.SQL.text:= req;
     datamodule2.FDQuerProc.ParamByName('tit').AsString := cbTitre.Selected.Text;
     datamodule2.FDQuerProc.Open;
     edNom.Text:=datamodule2.FDQuerProc.FieldByName('nomauteur').AsString;
     edPren.Text:=datamodule2.FDQuerProc.FieldByName('prenauteur').AsString;
      edIsbn.Text:=datamodule2.FDQuerProc.FieldByName('isbn').AsString;
      edMaj.Text:=datamodule2.FDQuerProc.FieldByName('datmaj').AsString ;
      edParut.text:=datamodule2.FDQuerProc.FieldByName('datparut').AsString ;
      edCPoch.Text:= datamodule2.FDQuerProc.FieldByName('codepoche').AsString ;
      mAvis.Text:=datamodule2.FDQuerProc.FieldByName('avis').AsString;
      mDigest.Text:=datamodule2.FDQuerProc.FieldByName('resume').AsString;
      cbThem.selected.Text:=datamodule2.FDQuerProc.FieldByName('theme').AsString;
      cbPoch.selected.Text:=datamodule2.FDQuerProc.FieldByName('editpoch').AsString;
      cbEdit.selected.Text:=datamodule2.FDQuerProc.FieldByName('nomedit').AsString;
      if datamodule2.FDQuerProc.FieldByName('poss').asinteger=0 then
        begin
           rbN.IsChecked:=true;
        end;
      if datamodule2.FDQuerProc.FieldByName('poss').AsInteger=1 then
        begin
           rbO.IsChecked:=true;
        end;

     datamodule2.FDQuerProc.Close;
  end;
end;

procedure TFlivaj.FormActivate(Sender: TObject);
  var
  i :integer;
begin
    Datmaj := DateToStr(Date);
    edTitre.Visible:=false;
    cbTitre.Visible:=True;
    cbAuteur.Visible:=false;
    btModif.Enabled:=True;
    btValid.Enabled:=False;
    btAjou.Enabled:=True;
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
