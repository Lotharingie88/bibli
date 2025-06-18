unit bibli_revaj;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox, FMX.Edit,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait;

type
  TFbibli_revaj = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btQuit: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edRevu: TEdit;
    edThem: TEdit;
    cbPays: TComboBox;
    cbPeriode: TComboBox;
    edCodrev: TEdit;
    cbThem: TComboBox;
    btAjout: TButton;
    btModif: TButton;
    btValid: TButton;
    FDQreva: TFDQuery;
    cFinp: TCheckBox;
    cbRevu: TComboBox;
    FDQRevComp: TFDQuery;
    edPays: TEdit;
    edPeriod: TEdit;
    FDQrevAj: TFDQuery;
    FDQthem: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField: TLinkFillControlToField;
    procedure btQuitClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);
    procedure btValidClick(Sender: TObject);
    procedure btModifClick(Sender: TObject);
    procedure btAjoutClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbRevuChange(Sender: TObject);
    procedure cbThemChange(Sender: TObject);
    procedure cbPeriodeChange(Sender: TObject);
    procedure cbPaysChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Fbibli_revaj: TFbibli_revaj;

implementation

{$R *.fmx}
 uses bibli_revue;
 var
 Datmaj : String;
procedure TFbibli_revaj.btAjoutClick(Sender: TObject);
begin
     edRevu.Visible:=True;
     cbRevu.Visible:=False;
     cbPays.Visible:=True;
     cbPeriode.Visible:=True;
     cbThem.Visible:=True;
     edthem.Visible:=false;

     btValid.Enabled:=True;
     btModif.Enabled:=False;
end;

procedure TFbibli_revaj.btModifClick(Sender: TObject);
begin
     edrevu.Visible:=false;
     cbrevu.Visible:=True;
     cbPays.Visible:=True;
     cbPeriode.Visible:=True;
     cbThem.Visible:=True;
     edthem.Visible:=false;
     btValid.Enabled:=True;
     btAjout.Enabled:=False;
end;

procedure TFbibli_revaj.btValidClick(Sender: TObject);
var
i:integer;
begin
     //try
         try
         FDQrevaj.Close;
         FDQrevaj.SQL.Clear;
         if (btModif.Enabled=True and btAjout.Enabled=False)  then
           begin
            //update
            FDQrevaj.SQL.Text:='UPDATE revues SET idperiodicite = :perio,idnation=:pay,idtheme=:them,codpress=:cpress,flok=:flo, datmaj = :maj  WHERE titrerevue = :tit' ;
            FDQrevaj.ParamByName('perio').AsInteger := edPeriod.Tag;
            FDQrevaj.ParamByName('pay').AsInteger  := edPays.Tag;
            FDQrevaj.ParamByName('them').AsInteger := edThem.Tag;
            FDQrevaj.ParamByName('cpress').AsString  := edCodrev.Text;
            if cFinp.IsChecked=True then
                     FDQrevaj.ParamByName('flo').AsString := 'N'
                     else
                    FDQrevaj.ParamByName('flo').AsString := 'O';
            FDQrevaj.ParamByName('maj').AsDate := StrToDate(Datmaj);
            FDQrevaj.ParamByName('tit').AsString := edRevu.Text;
           end ;

         if (btModif.Enabled=False and btAjout.Enabled=True) then
           begin
            //insert
            FDQrevaj.SQL.Text:='INSERT into revues(titrerevue,idperiodicite,idnation,idtheme,codpress,flok,datmaj) VALUES (:tit,:perio,:pay,:them,:cpress,:flo,:maj)';
            FDQrevaj.ParamByName('tit').AsString := edRevu.Text;
            FDQrevaj.ParamByName('perio').AsInteger  := edPeriod.Tag;
            FDQrevaj.ParamByName('pay').AsInteger := edPays.Tag;
            FDQrevaj.ParamByName('them').AsInteger  := edThem.Tag;
            if edCodrev.Text <>'' then
              FDQrevaj.ParamByName('cpress').AsString := edCodrev.Text
            else
              FDQrevaj.ParamByName('cpress').AsString :='ND';
            if cFinp.IsChecked=True then
                     FDQrevaj.ParamByName('flo').AsString := 'N'
                     else
                    FDQrevaj.ParamByName('flo').AsString := 'O';

            FDQrevaj.ParamByName('maj').AsDate := StrToDate(Datmaj);
           end;
            FDQrevaj.ExecSQL;
         except
          ShowMessage('Erreur!Mise à jour base non faites');
          end ;
         FDQrevaj.Close;
     //finally
        FDQrevaj.Free;
       for i := 0 to Componentcount-1 do
          	begin
            		if (Components[i] is TEdit ) then
                     begin
                       TEdit(Components[i]).Text:='';
                       TEdit(Components[i]).Tag:=0;
                     end;
                 if (Components[i] is TCheckBox ) then
                     begin
                       TCheckbox(Components[i]).ischecked:=False;
                     end;
                  if (Components[i] is TComboBox ) then
                     begin
                       TComboBox(Components[i]).selected.Text:='';
                     end;
               end;
       btModif.Enabled:=True;
       btValid.Enabled:=False;
       btAjout.Enabled:=True;
       ShowMessage('Base actualisée');
     //end;

end;

procedure TFbibli_revaj.btPrecClick(Sender: TObject);
var
i:integer;
begin
     for i := 0 to Componentcount-1 do
         	begin
            		if (Components[i] is TEdit ) then
                     begin
                      TEdit(Components[i]).Text:='';
                     end;
                if (Components[i] is TCheckBox ) then
                     begin
                      TCheckbox(Components[i]).ischecked:=False;
                    end;
                  if (Components[i] is TComboBox ) then
                     begin
                       TComboBox(Components[i]).Clear;
                     end;
              end;
  Fbibli_revue.show;
 Fbibli_revaj.Close;

end;

procedure TFbibli_revaj.btQuitClick(Sender: TObject);
var
i:integer;
begin
     for i := 0 to Componentcount-1 do
         	begin
            		if (Components[i] is TEdit ) then
                     begin
                      TEdit(Components[i]).Text:='';
                      TEdit(Components[i]).Tag:=0;
                     end;
                if (Components[i] is TCheckBox ) then
                     begin
                      TCheckbox(Components[i]).ischecked:=False;
                    end;
                  if (Components[i] is TComboBox ) then
                     begin
                       TComboBox(Components[i]).Clear;
                     end;
              end;

     Fbibli_revaj.close;
end;

procedure TFbibli_revaj.cbPaysChange(Sender: TObject);
begin
      edPays.text:=cbPays.Selected.text;
      if cbPays.Selected.Text<>'' then
       begin
           FDQRevComp.Close;
           FDQRevComp.SQL.Clear;
           FDQRevComp.SQL.Text := 'SELECT idnation ,nom FROM pays where  nom= :pay';
           FDQRevComp.ParamByName('pay').AsString :=  CbPays.Selected.Text;
           FDQRevComp.Open;
           FDQRevComp.First;
           while not FDQRevComp.Eof do
             begin
                  edPays.tag := FDQRevComp.FieldByName('idnation').AsInteger;

                FDQRevComp.Next;
             end;
        end;
     FDQRevComp.Close;
end;

procedure TFbibli_revaj.cbPeriodeChange(Sender: TObject);
begin
     edPeriod.text:=cbPeriode.Selected.text;
     if cbPeriode.Selected.Text<>'' then
       begin
           FDQRevComp.Close;
           FDQRevComp.SQL.Clear;
           FDQRevComp.SQL.Text := 'SELECT idperiodicite ,periode FROM periodicite where  periode= :perio';
           FDQRevComp.ParamByName('perio').AsString :=  cbPeriode.Selected.Text;
           FDQRevComp.Open;
           FDQRevComp.First;
           while not FDQRevComp.Eof do
             begin
                  edPeriod.tag := FDQRevComp.FieldByName('idperiodicite').AsInteger;

                FDQRevComp.Next;
             end;
        end;
        FDQRevComp.Close;
end;

procedure TFbibli_revaj.cbRevuChange(Sender: TObject);
begin
         edRevu.text:='';
   if cbrevu.Selected.Text<>'' then
       begin
           edRevu.text:=cbRevu.Selected.text;
           FDQRevComp.Close;
           FDQRevComp.SQL.Clear;
           FDQRevComp.SQL.Text := 'SELECT idrevue,titrerevue,codpress,periode,theme ,nom,flok FROM revues,thematique,periodicite,pays where revues.idnation=pays.idnation and revues.idtheme=thematique.idtheme and revues.idperiodicite=periodicite.idperiodicite and titrerevue= :rev';
           FDQRevComp.ParamByName('rev').AsString :=  CbRevu.Selected.Text;
           FDQRevComp.Open;

                   edCodrev.Text := FDQRevComp.FieldByName('codpress').asstring;
                   edPays.Text := FDQRevComp.FieldByName('nom').AsString;
                   edPeriod.Text := FDQRevComp.FieldByName('periode').AsString;
                   edThem.Text := FDQRevComp.FieldByName('theme').AsString;
                   if FDQRevComp.FieldByName('flok').AsString='N' then
                       cFinp.IsChecked:=True;
            FDQRevComp.Close;
           FDQRevComp.SQL.Clear;
           FDQRevComp.SQL.Text := 'SELECT titrerevue,revues.idperiodicite,revues.idnation,revues.idtheme FROM revues,thematique,periodicite,pays where revues.idnation=pays.idnation and revues.idtheme=thematique.idtheme and revues.idperiodicite=periodicite.idperiodicite and titrerevue= :rev';
           FDQRevComp.ParamByName('rev').AsString :=  CbRevu.Selected.Text;
           FDQRevComp.Open;

                   edPays.tag := FDQRevComp.FieldByName('idnation').AsInteger;
                   edPeriod.tag := FDQRevComp.FieldByName('idperiodicite').AsInteger;
                   edThem.tag := FDQRevComp.FieldByName('idtheme').AsInteger;

        end;
        FDQRevComp.Close;
end;



procedure TFbibli_revaj.cbThemChange(Sender: TObject);
begin
     edThem.text:=cbThem.Selected.text;
     if cbThem.Selected.Text<>'' then
       begin
           FDQRevComp.Close;
           FDQRevComp.SQL.Clear;
           FDQRevComp.SQL.Text := 'SELECT idtheme ,theme FROM thematique where  theme= :them';
           FDQRevComp.ParamByName('them').AsString :=  cbThem.Selected.Text;
           FDQRevComp.Open;
           FDQRevComp.First;
           while not FDQRevComp.Eof do
             begin
                  edThem.tag := FDQRevComp.FieldByName('idtheme').AsInteger;

                FDQRevComp.Next;
             end;
        end;
        FDQRevComp.Close;
end;

procedure TFbibli_revaj.FormActivate(Sender: TObject);
begin

     Datmaj := DateToStr(Date);
     FDQreva.Close;
     cbRevu.items.clear();
     //cbRevu.items.Add( ' ');
     FDQreva.SQL.Clear;
     FDQreva.SQL.Text := 'SELECT idrevue,titrerevue FROM revues order by titrerevue';
     FDQreva.Open;
    FDQreva.First;
    while not FDQreva.Eof do
      begin
           cbRevu.items.Add( FDQreva.FieldByName('titrerevue').AsString);
           FDQreva.Next;
         end;
      FDQreva.Close;
//     cbThem.Items.Clear();
//     FDQreva.SQL.Clear;
//     FDQreva.SQL.Text := 'SELECT idtheme,theme FROM thematique  where revue=1 order by theme';
//     FDQreva.Open;
//    FDQreva.First;
//    while not FDQreva.Eof do
//      begin
//           cbThem.items.Add( FDQreva.FieldByName('theme').AsString);
//           FDQreva.Next;
//       end;
       FDQreva.Close;
     cbPeriode.items.clear();
     FDQreva.SQL.Clear;
     FDQreva.SQL.Text := 'SELECT idperiodicite,periode FROM periodicite order by periode';
     FDQreva.Open;
    FDQreva.First;
    while not FDQreva.Eof do
      begin
           cbperiode.items.Add( FDQreva.FieldByName('periode').AsString);
           FDQreva.Next;
         end;
          FDQreva.Close;
     cbPays.items.clear();
     FDQreva.SQL.Clear;
     FDQreva.SQL.Text := 'SELECT idnation,nom FROM pays order by nom';
     FDQreva.Open;
    FDQreva.First;
    while not FDQreva.Eof do
      begin
           cbPays.items.Add( FDQreva.FieldByName('nom').AsString);
           FDQreva.Next;
         end;
      FDQreva.Close;

      cbRevu.Visible:=True;
      cbPays.Visible:=false;
     cbPeriode.Visible:=false;
     cbThem.Visible:=false;
     btAjout.Enabled:=True;
     btModif.Enabled:=True;
     btValid.Enabled:=false;
end;

end.
