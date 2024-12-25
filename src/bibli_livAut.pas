unit bibli_livAut;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation,
  FMX.ListBox, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.DateTimeCtrls,
  bibli,udb, FMX.Layouts;

type
  TFAuteur = class(TForm)
    edPren: TEdit;
    edNaiss: TEdit;
    edLNaiss: TEdit;
    edPNaiss: TEdit;
    edDec: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    mOeuv: TMemo;
    ToolBar2: TToolBar;
    btPrec: TButton;
    btRecinit: TButton;
    btRecfin: TButton;
    btQuit: TButton;
    btRec: TButton;
    CbNAut: TComboBox;
    FDQuerySelAut: TFDQuery;
    btAj: TButton;
    btMaj: TButton;
    edNomAut: TEdit;
    FDQAutCompl: TFDQuery;
    cbPays: TComboBox;
    BindSourceDB1: TBindSourceDB;
    BindSourceDB2: TBindSourceDB;
    dedDNaiss: TDateEdit;
    dedDDec: TDateEdit;
    BindSourceDB3: TBindSourceDB;
    BindingsList1: TBindingsList;
    BindSourceDB4: TBindSourceDB;
    BindSourceDB5: TBindSourceDB;
    BindSourceDB6: TBindSourceDB;
    Layout1: TLayout;
    edMaj: TEdit;
    Label7: TLabel;
    ckAutRev: TCheckBox;
    LinkFillControlToField: TLinkFillControlToField;
    LinkFillControlToField2: TLinkFillControlToField;
    procedure btQuitClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);

    procedure FormActivate(Sender: TObject);
    procedure CbNAutClick(Sender: TObject);
    procedure CbNAutChange(Sender: TObject);
    procedure btMajClick(Sender: TObject);
    procedure btAjClick(Sender: TObject);

    procedure btRecClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FAuteur: TFAuteur;
  j:integer;
  crit,req : string;

implementation

{$R *.fmx}
uses bibli_liv1;
var
 Datmaj : String;
 i:integer;

procedure TFAuteur.btAjClick(Sender: TObject);
var
 i:integer;
begin
     CbNAut.Visible:=False;
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
                 if (Components[i] is TDateEdit ) then
                     begin
                       TDateEdit(Components[i]).Text:='';
                     end;
               end;
     edNomAut.Visible:=True;
     edPNaiss.Visible:=False;
     cbPays.Visible:=True;
     btRec.enabled:=True;
     btMaj.Enabled:=false;



end;

procedure TFAuteur.btMajClick(Sender: TObject);
begin
     edNomAut.Text:=  CbNAut.Selected.Text;
     CbNAut.Visible:=True;
     edNomAut.Visible:=False;
     edPNaiss.Visible:=False;
     cbPays.Selected.text:=edPNaiss.Text;
     cbPays.Visible:=True;
     btRec.enabled:=True;
     btAj.Enabled:=false;
     FDQuerySelAut.Close;
     FDQuerySelAut.SQL.Clear;
     FDQuerySelAut.SQL.Text := 'SELECT idauteur FROM auteur where nomauteur= :champSqlite';
     FDQuerySelAut.ParamByName('champSqlite').AsString :=  CbNAut.Selected.Text;
     FDQuerySelAut.Open;
     while not FDQuerySelAut.Eof do
       begin

            j := FDQuerySelAut.FieldByName('idauteur').AsInteger;
            FDQuerySelAut.Next;
       end;
       //ShowMessage(IntToStr(j));
end;

procedure TFAuteur.btPrecClick(Sender: TObject);
begin
  btRec.enabled:=false;
  btAj.Enabled:=true;
  btAj.Enabled:=true;
FLiv.Show;
  fAuteur.Close;
end;

procedure TFAuteur.btQuitClick(Sender: TObject);
begin
  btRec.enabled:=false;
  btAj.Enabled:=true;
  btAj.Enabled:=true;
  close();
end;

procedure TFAuteur.btRecClick(Sender: TObject);
         var
          i,cod: integer;

begin
     FDQAutCompl.SQL.Clear;
     FDQAutCompl.SQL.Text := 'SELECT idnation FROM pays where nom= :champSqlite';
     FDQAutCompl.ParamByName('champSqlite').AsString :=  CbPays.Selected.Text;
     FDQAutCompl.Open;
     if CbPays.Selected.Text.IsEmpty=True then
     cod:=0
     else
     begin
     cod:=0;
     while not FDQAutCompl.Eof do
       begin

            cod := FDQAutCompl.FieldByName('idnation').AsInteger;
            FDQAutCompl.Next;
       end;
     end;
     FDQuerySelAut.SQL.Clear;
     if (j>0) then
     begin
          FDQuerySelAut.SQL.Text:='UPDATE auteur SET nomauteur = :champSqlite1, prenauteur = :champSqlite2, datnaiss = :champSqlite3, vilnaiss = :champSqlite4,idnation= :pays, datdec = :champSqlite5,datmaj =:Datmaj,autrev:rev  WHERE idauteur = :j' ;
          FDQuerySelAut.ParamByName('j').AsInteger := j;
          FDQuerySelAut.ParamByName('champSqlite1').AsString := edNomAut.Text;
          FDQuerySelAut.ParamByName('champSqlite2').AsString := edPren.Text;

          if (not(deddNaiss.IsEmpty) and (deddNaiss.Text<>'01/01/001')) then
                 FDQuerySelAut.ParamByName('champSqlite3').AsDate := deddNaiss.date
                   else
                  FDQuerySelAut.ParamByName('champSqlite3').clear;
          //FDQuerySelAut.ParamByName('champSqlite3').asDate := dedDNaiss.Date;
          FDQuerySelAut.ParamByName('pays').AsInteger := cod;
          FDQuerySelAut.ParamByName('champSqlite4').AsString := edLNaiss.Text;
          //FDQuerySelAut.ParamByName('champSqlite5').AsDate := StrToDate(edDec.Text);
          if (not(deddDec.IsEmpty) and (deddDec.Text<>'01/01/001')) then
            FDQuerySelAut.ParamByName('champSqlite5').AsDate := deddDec.date
                   else
            FDQuerySelAut.ParamByName('champSqlite5').clear;
            if not(ckAutrev.IsChecked) then
               FDQuerySelAut.ParamByName('rev').AsInteger := 0
               else
               FDQuerySelAut.ParamByName('rev').AsInteger := 1;

          FDQuerySelAut.ParamByName('Datmaj').AsDate := StrToDate(Datmaj);
     end
     else
     begin
           FDQuerySelAut.SQL.Text:='INSERT into auteur(nomauteur,prenauteur,datnaiss,vilnaiss,idnation,datdec,datmaj,autrev) VALUES (:champSqlite1,:champSqlite2,:champSqlite3,:champSqlite4,:pays,:champSqlite5,:Datmaj,:rev)';
           FDQuerySelAut.ParamByName('champSqlite1').AsString := edNomAut.Text;
           FDQuerySelAut.ParamByName('champSqlite2').AsString := edPren.Text;
           //FDQuerySelAut.ParamByName('champSqlite3').AsDate := StrToDate(edNaiss.Text);
           if (deddNaiss.IsEmpty or (deddNaiss.Text='01/01/0001')) then
                 FDQuerySelAut.ParamByName('champSqlite3').clear
                 else
                 FDQuerySelAut.ParamByName('champSqlite3').AsDate :=StrToDate(deddNaiss.text);

           //FDQuerySelAut.ParamByName('champSqlite3').AsDate :=dedDNaiss.date;
           FDQuerySelAut.ParamByName('champSqlite4').AsString := edLNaiss.Text;
           FDQuerySelAut.ParamByName('pays').AsInteger := cod;
           //FDQuerySelAut.ParamByName('champSqlite5').AsDate := StrToDate(edDec.Text);
            if (deddDec.IsEmpty and (deddDec.Text='01/01/0001')) then
               FDQuerySelAut.ParamByName('champSqlite5').clear
               else
            FDQuerySelAut.ParamByName('champSqlite5').AsDate :=StrToDate(deddDec.text);
            if not(ckAutrev.IsChecked) then
               FDQuerySelAut.ParamByName('rev').AsInteger := 0
               else
               FDQuerySelAut.ParamByName('rev').AsInteger := 1;
           //FDQuerySelAut.ParamByName('champSqlite5').AsDate := dedDDec.date;
           FDQuerySelAut.ParamByName('Datmaj').AsDate := StrToDate(Datmaj);
     end;
     FDQuerySelAut.ExecSQL;
     cbNaut.Repaint;
      for i := 0 to Componentcount-1 do
          	begin
            		if (Components[i] is TEdit ) then
                     begin
                       TEdit(Components[i]).Text:='';
                     end;
                if (Components[i] is TCheckBox ) then
                     begin
                       TCheckBox(Components[i]).isChecked:=false;
                     end;
                if (Components[i] is TMemo ) then
                     begin
                       TMemo(Components[i]).Text:='';
                     end;
                 if (Components[i] is TDateEdit ) then
                     begin
                       TDateEdit(Components[i]).IsEmpty:=true;
                     end;
                   if (Components[i] is TComboBox ) and (TComboBox(Components[i]).Tag<>1) then
                     begin
                       TComboBox(Components[i]).items.Insert(0,'');
                       TComboBox(Components[i]).Tag:=1;
                       Tcombobox(components[i]).Items[0];
                     end;
               end;
      CbNAut.Visible:=True;
      cbPays.Visible:=False;
      edPNaiss.Visible:=True;
      edNomAut.Visible:=False;
     j:=0;
end;


procedure TFAuteur.CbNAutChange(Sender: TObject);
begin
   cbnaut.selected.Repaint;
     mOeuv.Text :='';
     datamodule2.FDQuerProc.Close;
     datamodule2.FDQuerProc.SQL.Clear;
      req:='SELECT a.idauteur,nomauteur,prenauteur,datnaiss as dnaiss,vilnaiss,datdec as ddec,nom,titre,strftime(''%d-%m-%Y'',datach) as dach,autrev';
      req:=req+ ' from  auteur as a left join pays as b on a.idnation=b.idnation left join livres as c on c.idauteur=a.idauteur left join achat as d on c.idtitre=d.idliv' ;
      req:= req + ' where nomauteur= :champSqlite';
     datamodule2.FDQuerProc.SQL.text:= req;
     datamodule2.FDQuerProc.ParamByName('champSqlite').AsString :=  CbNAut.Selected.Text;
     datamodule2.FDQuerProc.Open;
     while not datamodule2.FDQuerProc.Eof do
       begin
           edPren.Text := datamodule2.FDQuerProc.FieldByName('prenauteur').AsString;
           //edNaiss.Text := FDQuerySelAut.FieldByName('strftime("%d-%m-%Y",datnaiss)').AsString;
           dedDNaiss.date:= datamodule2.FDQuerProc.FieldByName('dnaiss').asDatetime;
           edLNaiss.Text := datamodule2.FDQuerProc.FieldByName('vilnaiss').asstring;
           edPNaiss.Text := datamodule2.FDQuerProc.FieldByName('nom').AsString;
           cbpays.Selected.Text:= datamodule2.FDQuerProc.FieldByName('nom').AsString;
           //edDec.Text := dateToStr(FDQuerySelAut.FieldByName('datdec').AsDatetime);
           dedDDec.date:= datamodule2.FDQuerProc.FieldByName('ddec').asDatetime;
           if datamodule2.FDQuerProc.FieldByName('autrev').AsInteger=0 then
              ckAutrev.IsChecked:=false
              else
              ckAutrev.IsChecked:=true;

           if datamodule2.FDQuerProc.FieldByName('dach').AsString <>'' then
             crit:= 'X'
             else crit:= '';
          mOeuv.Text := mOeuv.Text + chr(13)+ chr(10) +  datamodule2.FDQuerProc.FieldByName('titre').AsString + '   ' + crit;
           datamodule2.FDQuerProc.Next;
         end;
end;

procedure TFAuteur.CbNAutClick(Sender: TObject);
begin
//     
end;

procedure TFAuteur.FormActivate(Sender: TObject);
var
i:integer;
begin
     Datmaj := DateToStr(Date);
     btRec.enabled:=false;

   for i := 0 to Componentcount-1 do
         	begin
            		if (Components[i] is TEdit ) then
                     begin
                      TEdit(Components[i]).Text:='';
                     end;
                if (Components[i] is TCheckBox ) then
                     begin
                       TCheckBox(Components[i]).isChecked:=false;
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
                 if (Components[i] is TDateEdit ) then
                    begin
                       TDateEdit(Components[i]).Text:='';
                     end;
               end;
       
end;

end.
