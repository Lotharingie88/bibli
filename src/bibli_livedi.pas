unit bibli_livedi;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox, FMX.Edit,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  FireDAC.Comp.DataSet, Data.Bind.DBScope,udb;

type
  TFEdit = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btQuit: TButton;
    lbEdit: TLabel;
    Label2: TLabel;
    eNomedit: TEdit;
    Panel1: TPanel;
    rbO: TRadioButton;
    rbN: TRadioButton;
    cbEdit: TComboBox;
    Label3: TLabel;
    cbPays: TComboBox;
    btAjout: TButton;
    btModif: TButton;
    btRec: TButton;
    cbPoch: TComboBox;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    BindSourceDB2: TBindSourceDB;
    BindSourceDB3: TBindSourceDB;
    BindSourceDB4: TBindSourceDB;
    BindSourceDB5: TBindSourceDB;
    BindSourceDB6: TBindSourceDB;
    Label1: TLabel;
    edMaj: TEdit;
    lbInfo: TLabel;
    LinkFillControlToField: TLinkFillControlToField;
    LinkFillControlToField2: TLinkFillControlToField;
    LinkFillControlToField3: TLinkFillControlToField;
    procedure btQuitClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);
    procedure btRecClick(Sender: TObject);
    procedure btAjoutClick(Sender: TObject);
    procedure btModifClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbEditChange(Sender: TObject);
    procedure cbPochChange(Sender: TObject);
    procedure cbPaysChange(Sender: TObject);
    procedure rbNChange(Sender: TObject);
    procedure rbOChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FEdit: TFEdit;


implementation

{$R *.fmx}
  uses bibli_liv1;
 var
 Datmaj : String;
 cod:integer;
procedure TFEdit.btAjoutClick(Sender: TObject);
begin
     eNomedit.Visible:= True;
     if rbO.IsChecked=True then
        begin
        lbEdit.Text :='Edition de Poche :';
        cbPoch.Visible:=False;
         cbEdit.Visible:=False ;
        end
        else
       if rbN.IsChecked=True then
       begin
          lbEdit.Text :='Edition :';
          cbEdit.Visible:=False ;
           cbPoch.Visible:=False;
       end
       else
       begin
         ShowMessage('il faut selectionner un choix sur edition de poche');
       end;

     btAjout.enabled:=True;
     btModif.enabled:=False;
     btRec.enabled:=True;
end;

procedure TFEdit.btModifClick(Sender: TObject);
begin
     //eNomedit.Visible:= False;
     if rbO.IsChecked=True then

     begin
        lbEdit.Text :='Edition de Poche :';

        cbPoch.Visible:=True;
        cbEdit.Visible:=False;
        eNomedit.Visible:= False;
     end
        else
       if rbN.IsChecked=True then
       begin
          lbEdit.Text :='Edition :';
          
          cbEdit.Visible:=True;
          cbPoch.Visible:=False;
          eNomedit.Visible:= False;
       end
       else
       begin
         ShowMessage('il faut selectionner un choix sur edition de poche');
       end;
       //eNomedit.Visible:= False;
    btAjout.enabled:=False;
     btModif.enabled:=True;
     btRec.enabled:=True;
end;

procedure TFEdit.btPrecClick(Sender: TObject);
begin
  FEdit.Close;
  Fliv.Show;
end;

procedure TFEdit.btQuitClick(Sender: TObject);
begin
close;
end;

procedure TFEdit.btRecClick(Sender: TObject);
//var
//cod:Integer;
begin
//       datamodule2.fdQuerproc.SQL.Clear;
//       datamodule2.fdQuerproc.SQL.Text:='SELECT idnation from pays where nom =:nation ' ;
//       datamodule2.fdQuerproc.ParamByName('nation').AsString := cbPays.Selected.Text;
//       datamodule2.fdQuerproc.Open;
//       cod:=datamodule2.fdQuerproc.FieldByName('idnation').AsInteger;
       lbinfo.Text:='';
      datamodule2.fdQuerproc.SQL.Clear;
      if btAjout.enabled=True then
        begin
           if rbO.IsChecked=True then
            begin
                 datamodule2.fdQuerproc.SQL.Text:='INSERT into editionpoche(editpoch,idnation,datmaj) VALUES (:champSqlite,:champSqlite2,:datmaj)';
                 datamodule2.fdQuerproc.ParamByName('champSqlite').AsString := eNomedit.Text;
                 datamodule2.fdQuerproc.ParamByName('champSqlite2').AsInteger := cod;
                 datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
            end;
           if rbN.IsChecked=True then
            begin
                 datamodule2.fdQuerproc.SQL.Text:='INSERT into editeur(nomedit,idnation,datmaj) VALUES (:champSqlite,:champSqlite2,:datmaj)';
                 datamodule2.fdQuerproc.ParamByName('champSqlite').AsString := eNomedit.Text;
                 datamodule2.fdQuerproc.ParamByName('champSqlite2').AsInteger := cod;
                 datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
            end;
        end;
     if btModif.enabled=True then
      begin
      if rbO.IsChecked=True then
       begin
             //update
              datamodule2.fdQuerproc.SQL.Text:='UPDATE editionpoche SET (idnation = :champSqlite,datmaj=:maj)  WHERE editpoch = :index' ;
              datamodule2.fdQuerproc.ParamByName('index').AsString := cbPoch.Selected.Text;
              datamodule2.fdQuerproc.ParamByName('maj').AsDate := StrToDate(Datmaj);
              datamodule2.fdQuerproc.ParamByName('champSqlite').AsInteger := cod;
          end;
       if rbN.IsChecked=True then
       begin
             //update
              datamodule2.fdQuerproc.SQL.Text:='UPDATE editeur SET idnation = :champSqlite, datmaj = :maj  WHERE nomedit = :index' ;
              datamodule2.fdQuerproc.ParamByName('index').AsString := cbEdit.Selected.Text;
              datamodule2.fdQuerproc.ParamByName('maj').AsDate := StrToDate(Datmaj);
              datamodule2.fdQuerproc.ParamByName('champSqlite').AsInteger := cod;
       end;
      end;
     datamodule2.fdQuerproc.ExecSQL;
     lbInfo.Text:='Mise à jour ou insertion effectuée';
     btAjout.enabled:=True;
     btModif.enabled:=True;
     btRec.enabled:=False;
end;

procedure TFEdit.cbEditChange(Sender: TObject);
begin
  if rbN.IsChecked=True then
       begin
       datamodule2.fdQuerproc.SQL.Clear;
       datamodule2.fdQuerproc.SQL.Text:='SELECT nom,a.datmaj from editeur as a inner join pays as b on b.idnation=a.idnation where a.nomedit =:editeur ' ;
       datamodule2.fdQuerproc.ParamByName('editeur').AsString := cbEdit.Selected.Text;
       datamodule2.fdQuerproc.Open;
       cbPays.Selected.Text := datamodule2.fdQuerproc.FieldByName('nom').AsString;
       cbpays.Repaint;
       edMaj.Text:=datamodule2.fdQuerproc.FieldByName('datmaj').AsString ;
       end;

end;

procedure TFEdit.cbPaysChange(Sender: TObject);
//var
  //cod:Integer;
begin
       datamodule2.fdQuerproc.SQL.Clear;
       datamodule2.fdQuerproc.SQL.Text:='SELECT idnation from pays where nom =:nation ' ;
       datamodule2.fdQuerproc.ParamByName('nation').AsString := cbPays.Selected.Text;
       datamodule2.fdQuerproc.Open;
       cod:=datamodule2.fdQuerproc.FieldByName('idnation').AsInteger;

      datamodule2.fdQuerproc.SQL.Clear;
end;

procedure TFEdit.cbPochChange(Sender: TObject);
begin
   if rbO.IsChecked=True then
       begin
       datamodule2.fdQuerproc.SQL.Clear;
       datamodule2.fdQuerproc.SQL.Text:='SELECT nom, a.datmaj from editionpoche as a inner join pays as b on b.idnation=a.idnation where a.editpoch =:editeur ' ;
       datamodule2.fdQuerproc.ParamByName('editeur').AsString := cbPoch.Selected.Text;
       datamodule2.fdQuerproc.Open;
       cbPays.Selected.Text := datamodule2.fdQuerproc.FieldByName('nom').AsString;
       cbpays.Repaint;
       edMaj.Text:=datamodule2.fdQuerproc.FieldByName('datmaj').AsString ;
       end;
end;

procedure TFEdit.FormActivate(Sender: TObject);
var
i:integer;
begin
 Datmaj := DateToStr(Date);
   btAjout.enabled:=True;
     btModif.enabled:=True;
     btRec.enabled:=False;
     lbInfo.Text:='';
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
//                 if (Components[i] is TComboBox ) then
//                     begin
//                       TComboBox(Components[i]).selected.text :='';
//
//                     end;
                 if (Components[i] is TCheckBox ) then
                     begin
                       TCheckBox(Components[i]).ischecked :=false;

                     end;
                   //if (Components[i] is TLabel ) then
                    // begin
                     //  TLabel(Components[i]).Text:='';
                    // end;
//                 if (Components[i] is TDateEdit ) then
//                    begin
//                       TDateEdit(Components[i]).Date:=now;
//                     end;
               end;
end;

procedure TFEdit.rbNChange(Sender: TObject);
begin
  if rbN.IsChecked=true  then
    lbedit.Text:= 'Editeur :';
    if (btmodif.enabled=true and btrec.Enabled=true) then
     begin
      cbEdit.Visible:=true;
      cbPoch.Visible:=false;
     end;
end;

procedure TFEdit.rbOChange(Sender: TObject);
begin
   if rbO.IsChecked=true then
    lbedit.Text:= 'Edition de Poche :';
    if (btmodif.enabled=true and btrec.Enabled=true) then
     begin
      cbEdit.Visible:=false;
      cbPoch.Visible:=true;
     end;
end;

end.
