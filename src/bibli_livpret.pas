unit bibli_livpret;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Memo.Types, FMX.Edit, FMX.ListBox,
  FMX.ScrollBox, FMX.Memo, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  FireDAC.Comp.DataSet, Data.Bind.DBScope, FMX.DateTimeCtrls,udb;

type
  TFpret = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btQuit: TButton;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    memObs: TMemo;
    cbCD: TComboBox;
    cbDVD: TComboBox;
    cbRev: TComboBox;
    cbLiv: TComboBox;
    Edit2: TEdit;
    Edit4: TEdit;
    btEmp: TButton;
    btReto: TButton;
    BtUtili: TButton;
    cbNom: TComboBox;
    edNum: TEdit;
    Label9: TLabel;
    dedDpret: TDateEdit;
    Label10: TLabel;
    edMaj: TEdit;
    Label11: TLabel;
    dedRet: TDateEdit;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField2: TLinkFillControlToField;
    BindSourceDB3: TBindSourceDB;
    LinkFillControlToField3: TLinkFillControlToField;
    BindSourceDB4: TBindSourceDB;
    LinkFillControlToField4: TLinkFillControlToField;
    BindSourceDB5: TBindSourceDB;
    LinkFillControlToField5: TLinkFillControlToField;
    btEtat: TButton;
    procedure btQuitClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtUtiliClick(Sender: TObject);
    procedure btEmpClick(Sender: TObject);
    procedure btRetoClick(Sender: TObject);
    procedure btEtatClick(Sender: TObject);
    procedure cbNomChange(Sender: TObject);
    procedure cbCDChange(Sender: TObject);
    procedure cbDVDChange(Sender: TObject);
    procedure cbLivChange(Sender: TObject);
    procedure cbRevChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Fpret: TFpret;

implementation

{$R *.fmx}
 uses bibli_liv1,bibli_revue,bibli_dvd,bibli_cd,bibli_user;
 var
 idcd,iddvd,idliv,idrev,idus,nrev:integer;
 req,datmaj:string;
procedure TFpret.btEmpClick(Sender: TObject);
var
i:integer;
begin

        datamodule2.fdQuerproc.SQL.Clear;
        req:='INSERT into pret(iddvd,idliv,idrev,idcd,';
        req:=req + 'numrev,date,iduser,obser,datret,datmaj)';
        datamodule2.fdQuerproc.SQL.Text:=req + ' VALUES (:dvd,:liv,:rev,:cd,:nre,:dat,:user,:obs,:ret,:datmaj)';
        datamodule2.fdQuerproc.ParamByName('dvd').AsInteger := iddvd;
        datamodule2.fdQuerproc.ParamByName('liv').AsInteger := idliv;
        datamodule2.fdQuerproc.ParamByName('rev').AsInteger := idrev;
        datamodule2.fdQuerproc.ParamByName('cd').AsInteger := idcd;
        datamodule2.fdQuerproc.ParamByName('nre').AsInteger := nrev;
        if (not(dedDpret.IsEmpty) and (dedDpret.Text<>'01/01/001')) then
                 datamodule2.fdQuerproc.ParamByName('dat').AsDate := dedDpret.Date
                  else
                  datamodule2.fdQuerproc.ParamByName('dat').AsString:='NULL';
        datamodule2.fdQuerproc.ParamByName('user').AsInteger := idus;
        datamodule2.fdQuerproc.ParamByName('obs').AsString := memObs.Text;
        if (not(dedRet.IsEmpty) and (dedRet.Text<>'01/01/001')) then
                 datamodule2.fdQuerproc.ParamByName('ret').AsDate := dedRet.Date
                  else
                  datamodule2.fdQuerproc.ParamByName('ret').AsString:='NULL';
        datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
        datamodule2.fdQuerproc.ExecSQL;
        datamodule2.fdQuerproc.Close;
        datamodule2.fdQuerproc.sql.clear;
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
                     end ;
//                     else   if (Components[i] is TComboBox ) and (TComboBox(Components[i]).Tag=1) then
//                      Tcombobox(components[i]).Items[0];
                 if (Components[i] is TDateEdit ) then
                    begin
                       TDateEdit(Components[i]).Text:='';
                     end;
          end;
         // if not assigned(self) then exit;

end;

procedure TFpret.btPrecClick(Sender: TObject);
begin
  if fpret.Tag=2 then
        Fliv.show();
  if fpret.Tag=3 then
        Fbibli_revue.show();
  if fpret.Tag=4 then
        Fdvd.show();
  if fpret.Tag=5 then
        Fcd.show();

   Fpret.Close;

end;

procedure TFpret.btEtatClick(Sender: TObject);
var
  i:integer;
begin
  
//        datamodule2.fdQuerproc.SQL.Clear;
//        req:='INSERT into pret(iddvd,idliv,idrev,idcd,';
//        req:=req + 'numrev,date,iduser,obser,datret,datmaj)';
//        datamodule2.fdQuerproc.SQL.Text:=req + ' VALUES (:dvd,:liv,:rev,:cd,:nre,:dat,:user,:obs,:ret,:datmaj)';
//        datamodule2.fdQuerproc.ParamByName('dvd').AsInteger := iddvd;
//        datamodule2.fdQuerproc.ParamByName('liv').AsInteger := idliv;
//        datamodule2.fdQuerproc.ParamByName('rev').AsInteger := idrev;
//        datamodule2.fdQuerproc.ParamByName('cd').AsInteger := idcd;
//        datamodule2.fdQuerproc.ParamByName('nre').AsInteger := nrev;
//        if (not(dedDpret.IsEmpty) and (dedDpret.Text<>'01/01/001')) then
//                 datamodule2.fdQuerproc.ParamByName('dat').AsDate := dedDpret.Date
//                  else
//                  datamodule2.fdQuerproc.ParamByName('dat').AsString:='NULL';
//        datamodule2.fdQuerproc.ParamByName('user').AsInteger := idus;
//        datamodule2.fdQuerproc.ParamByName('obs').AsString := memObs.Text;
//        if (not(dedRet.IsEmpty) and (dedRet.Text<>'01/01/001')) then
//                 datamodule2.fdQuerproc.ParamByName('ret').AsDate := dedRet.Date
//                  else
//                  datamodule2.fdQuerproc.ParamByName('ret').AsString:='NULL';
//        datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
//        datamodule2.fdQuerproc.ExecSQL;
//        datamodule2.fdQuerproc.Close;
//        datamodule2.fdQuerproc.sql.clear;

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
                       //Tcombobox(components[i]).Selected.Text:='';
                     end;
                    //else   if (Components[i] is TComboBox ) and (TComboBox(Components[i]).Tag=1) then
                      //Tcombobox(components[i]).Selected.Text:='';


//                if (Components[i] is TDateEdit ) then
//                    begin
//                       TDateEdit(Components[i]).Text:='';
//                     end;
          end;
end;

procedure TFpret.btQuitClick(Sender: TObject);
begin
close;
end;

procedure TFpret.btRetoClick(Sender: TObject);
  var
  resu,i:integer;
begin

   if not(cbnom.Selected.Text.IsEmpty)=true  then
      begin
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select count(*) as res  from pret as a left join utilisateur as b on a.iduser=b.iduser where b.nom||" "||b.prenom = :nom and a.datret="NULL"';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := cbnom.Selected.text;
                 datamodule2.fdQuerproc.open;
                 resu:=datamodule2.fdQuerproc.FieldByName('res').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 if resu=0 then
                  begin
                   ShowMessage ('pas de pret encours pour cet utilisateur');
                  end
                 else if resu= 1 then
                     begin
                     ShowMessage ('Restitution de documents');
//                     end
//                      else
//                      begin
//
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
                if (Components[i] is TComboBox ) and (TComboBox(Components[i]).Tag<>1) then
                     begin
                       TComboBox(Components[i]).items.Insert(0,'');
                       TComboBox(Components[i]).Tag:=1;
                       //Tcombobox(components[i]).Selected.Text:='';
                     end;
                     //else   if (Components[i] is TComboBox ) and (TComboBox(Components[i]).Tag=1) then
                     // Tcombobox(components[i]).Selected.Text:='';
//                if (Components[i] is TDateEdit ) then
//                    begin
//                       TDateEdit(Components[i]).Text:='';
//                     end;
          end;

      end;
end;

procedure TFpret.BtUtiliClick(Sender: TObject);
begin
  fbuser.Tag:=0;
   FBuser.Show;
end;

procedure TFpret.cbCDChange(Sender: TObject);
begin
   if Cbcd.Selected.Text.IsEmpty=True then
      idcd:=0
   else
   begin
   datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idcd from cd where cdnom = :nom';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := cbcd.Selected.text;
                 datamodule2.fdQuerproc.open;
                 idcd:=datamodule2.fdQuerproc.FieldByName('idcd').AsInteger ;
                 datamodule2.fdQuerproc.Close;
    end;
end;

procedure TFpret.cbDVDChange(Sender: TObject);
begin
    if Cbdvd.Selected.Text.IsEmpty=True then
      iddvd:=0
   else
   begin
   datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idtitre from dvd where titre = :nom';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := cbDvd.Selected.text;
                 datamodule2.fdQuerproc.open;
                 iddvd:=datamodule2.fdQuerproc.FieldByName('idtitre').AsInteger ;
                 datamodule2.fdQuerproc.Close;
    end;
end;

procedure TFpret.cbLivChange(Sender: TObject);
begin
     if Cbliv.Selected.Text.IsEmpty=True then
      idliv:=0
   else
   begin
   datamodule2.fdQuerproc.SQL.Clear;
                datamodule2.fdQuerproc.SQL.Text:='select idtitre from livres where titre = :nom';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := cbliv.Selected.text;
                 datamodule2.fdQuerproc.open;
                 idliv:=datamodule2.fdQuerproc.FieldByName('idtitre').AsInteger ;
                 datamodule2.fdQuerproc.Close;
    end;
end;

procedure TFpret.cbNomChange(Sender: TObject);
begin
  if not(CbNom.Selected.Text.IsEmpty)=True then
     begin
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select iduser from utilisateur where nom||" "||prenom = :nom';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := cbnom.Selected.text;
                 datamodule2.fdQuerproc.open;
                 idus:=datamodule2.fdQuerproc.FieldByName('iduser').AsInteger ;
                 datamodule2.fdQuerproc.Close;
    end;
end;

procedure TFpret.cbRevChange(Sender: TObject);
begin
    if Cbrev.Selected.Text.IsEmpty=True then
      idrev:=0
   else
   begin
   datamodule2.fdQuerproc.SQL.Clear;
                datamodule2.fdQuerproc.SQL.Text:='select idrevue from revues where titrerevue = :nom';
                 datamodule2.fdQuerproc.ParamByName('nom').AsString := cbrev.Selected.text;
                 datamodule2.fdQuerproc.open;
                 idrev:=datamodule2.fdQuerproc.FieldByName('idrevue').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 nrev:=strtoint(edNum.Text);
    end;
end;

procedure TFpret.FormActivate(Sender: TObject);
var
  i:integer;
begin
  Datmaj := DateToStr(Date);
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
                       //Tcombobox(components[i]).Selected.Text:='';
                     end;
                     //else   if (Components[i] is TComboBox ) and (TComboBox(Components[i]).Tag=1) then
                     // Tcombobox(components[i]).Selected.Text:='';
//                if (Components[i] is TDateEdit ) then
//                    begin
//                       TDateEdit(Components[i]).Text:='';
//                     end;
          end;
end;

end.
