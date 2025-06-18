unit bibli_param;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit, FMX.ListBox,udb,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,FireDAC.Stan.Param;

type
  TFbparam = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    btAjP: TButton;
    btAjT: TButton;
    btAjA: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    cbPays: TComboBox;
    cbThem: TComboBox;
    cbAct: TComboBox;
    edAct: TEdit;
    edThem: TEdit;
    edPays: TEdit;
    Panel5: TPanel;
    Panel6: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    btAjPe: TButton;
    btAjPr: TButton;
    edPerio: TEdit;
    cbPerio: TComboBox;
    edProf: TEdit;
    cbProf: TComboBox;
    ckCd: TCheckBox;
    ckDvd: TCheckBox;
    ckLiv: TCheckBox;
    ckrev: TCheckBox;
    btPrec: TButton;
    btQuit: TButton;
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
    procedure btQuitClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btAjAClick(Sender: TObject);
    procedure btAjPClick(Sender: TObject);
    procedure btAjTClick(Sender: TObject);
    procedure btAjPeClick(Sender: TObject);
    procedure btAjPrClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Fbparam: TFbparam;

implementation

{$R *.fmx}
 uses admin;
 var
  nb,i:integer;
  datmaj: string;
procedure TFbparam.btAjAClick(Sender: TObject);
begin
  if not(edAct.Text.IsEmpty) then
      begin
           datamodule2.fdQuerproc.Close;
            datamodule2.fdQuerproc.SQL.Clear;
            datamodule2.fdQuerproc.SQL.Text:='SELECT count(*) as nb from activite where metier =:met ' ;
            datamodule2.fdQuerproc.ParamByName('met').AsString := edAct.Text;
            datamodule2.fdQuerproc.open;
            nb:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger;
            datamodule2.fdQuerproc.Close;
      end;
      if nb=0 then
        begin
           datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='INSERT into activite(metier,datmaj) VALUES (:met,:datmaj)';
                 datamodule2.fdQuerproc.ParamByName('met').AsString := edAct.Text;
                 datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
                 datamodule2.fdQuerproc.ExecSQL;
                 datamodule2.fdQuerproc.Close;
                 edAct.Text:='';
        end
        else
        begin

        end;
end;

procedure TFbparam.btAjPClick(Sender: TObject);
begin
   if not(edPays.Text.IsEmpty) then
      begin
           datamodule2.fdQuerproc.Close;
            datamodule2.fdQuerproc.SQL.Clear;
            datamodule2.fdQuerproc.SQL.Text:='SELECT count(*) as nb from pays where nom =:nat ' ;
            datamodule2.fdQuerproc.ParamByName('nat').AsString := edPays.Text;
            datamodule2.fdQuerproc.open;
            nb:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger;
            datamodule2.fdQuerproc.Close;
      end;
      if nb=0 then
        begin
            datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='INSERT into pays(nom,datmaj) VALUES (:nat,:datmaj)';
                 datamodule2.fdQuerproc.ParamByName('nat').AsString := edPays.Text;
                 datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
                 datamodule2.fdQuerproc.ExecSQL;
                 datamodule2.fdQuerproc.Close;
                 edPays.Text:='';
        end
        else
        begin

        end;
end;

procedure TFbparam.btAjPeClick(Sender: TObject);
begin
  if not(edPerio.Text.IsEmpty) then
      begin
           datamodule2.fdQuerproc.Close;
            datamodule2.fdQuerproc.SQL.Clear;
            datamodule2.fdQuerproc.SQL.Text:='SELECT count(*) as nb from periodicite where periode =:perio ' ;
            datamodule2.fdQuerproc.ParamByName('perio').AsString := edPerio.Text;
            datamodule2.fdQuerproc.open;
            nb:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger;
            datamodule2.fdQuerproc.Close;
      end;
      if nb=0 then
        begin
           datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='INSERT into periodicite(periode,datmaj) VALUES (:perio,:datmaj)';
                 datamodule2.fdQuerproc.ParamByName('perio').AsString := edPerio.Text;
                 datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
                 datamodule2.fdQuerproc.ExecSQL;
                 datamodule2.fdQuerproc.Close;
                 edPerio.Text:='';
        end
        else
        begin

        end;
end;

procedure TFbparam.btAjTClick(Sender: TObject);
var
  rev,liv,cd,dvd :integer;
begin
  if not(edThem.Text.IsEmpty) then
      begin
          datamodule2.fdQuerproc.Close;
            datamodule2.fdQuerproc.SQL.Clear;
            datamodule2.fdQuerproc.SQL.Text:='SELECT count(*) as nb from thematique where theme =:them ' ;
            datamodule2.fdQuerproc.ParamByName('them').AsString := edThem.Text;
            datamodule2.fdQuerproc.open;
            nb:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger;
            datamodule2.fdQuerproc.Close;
      end;
      if nb=0 then
        begin
           datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='INSERT into thematique(theme,revue,livre,dvd,cd,datmaj) VALUES (:them,:rev,:liv,:dvd,:cd,:datmaj)';
                 datamodule2.fdQuerproc.ParamByName('them').AsString := edThem.Text;
                 if ckCd.IsChecked=true then
                 datamodule2.fdQuerproc.ParamByName('cd').AsInteger := 1
                 else
                 datamodule2.fdQuerproc.ParamByName('cd').AsInteger := 0;
                 if ckDvd.IsChecked=true then
                 datamodule2.fdQuerproc.ParamByName('dvd').AsInteger := 1
                 else
                 datamodule2.fdQuerproc.ParamByName('dvd').AsInteger := 0;
                 if ckLiv.IsChecked=true then
                 datamodule2.fdQuerproc.ParamByName('liv').AsInteger := 1
                 else
                 datamodule2.fdQuerproc.ParamByName('liv').AsInteger := 0;
                 if ckrev.IsChecked=true then
                 datamodule2.fdQuerproc.ParamByName('rev').AsInteger := 1
                 else
                 datamodule2.fdQuerproc.ParamByName('rev').AsInteger := 0;
                 datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
                 datamodule2.fdQuerproc.ExecSQL;
                 datamodule2.fdQuerproc.Close;
                 edThem.Text:='';
        end
        else
        begin
           datamodule2.fdQuerproc.Close;
            datamodule2.fdQuerproc.SQL.Clear;
            datamodule2.fdQuerproc.SQL.Text:='SELECT theme,revue,livre,dvd,cd from thematique where theme =:them ' ;
            datamodule2.fdQuerproc.ParamByName('them').AsString := edThem.Text;
            datamodule2.fdQuerproc.open;
            rev:=datamodule2.fdQuerproc.FieldByName('revue').AsInteger;
              if ckRev.IsChecked=false then
                if rev=1 then
                  ckRev.IsChecked:=true
                  else
                 ckRev.IsChecked:=false;
            liv:=datamodule2.fdQuerproc.FieldByName('livre').AsInteger;
             if ckLiv.IsChecked=false then
               if liv=1 then
                  ckliv.IsChecked:=true
                  else
                 ckliv.IsChecked:=false;
            cd:=datamodule2.fdQuerproc.FieldByName('cd').AsInteger;
             if ckcd.IsChecked=false then
               if cd=1 then
                  ckcd.IsChecked:=true
                  else
                 ckcd.IsChecked:=false;
            dvd:=datamodule2.fdQuerproc.FieldByName('dvd').AsInteger;
              if ckDvd.IsChecked=false then
                if dvd=1 then
                  ckdvd.IsChecked:=true
                  else
                 ckdvd.IsChecked:=false;
            datamodule2.fdQuerproc.Close;
//            datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
//                 datamodule2.fdQuerproc.SQL.Text:='INSERT into thematique(theme,revue,livre,dvd,cd,datmaj) VALUES (:them,:rev,:liv,:dvd,:cd,:datmaj)';
                 datamodule2.fdQuerproc.SQL.Text:='UPDATE thematique SET revue = :rev,livre=:liv,dvd=:dvd,cd=:cd, datmaj = :datmaj  WHERE theme =:them ' ;
                 datamodule2.fdQuerproc.ParamByName('them').AsString := edThem.Text;
                 if ckCd.IsChecked=true then
                 datamodule2.fdQuerproc.ParamByName('cd').AsInteger := 1
                 else
                 datamodule2.fdQuerproc.ParamByName('cd').AsInteger := 0;
                 if ckDvd.IsChecked=true then
                 datamodule2.fdQuerproc.ParamByName('dvd').AsInteger := 1
                 else
                 datamodule2.fdQuerproc.ParamByName('dvd').AsInteger := 0;
                 if ckLiv.IsChecked=true then
                 datamodule2.fdQuerproc.ParamByName('liv').AsInteger := 1
                 else
                 datamodule2.fdQuerproc.ParamByName('liv').AsInteger := 0;
                 if ckrev.IsChecked=true then
                 datamodule2.fdQuerproc.ParamByName('rev').AsInteger := 1
                 else
                 datamodule2.fdQuerproc.ParamByName('rev').AsInteger := 0;
                 datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
                 datamodule2.fdQuerproc.ExecSQL;
                 datamodule2.fdQuerproc.Close;
                 edThem.Text:='';

        end;
        for i := 0 to Componentcount-1 do
          	begin
            		if (Components[i] is TEdit ) then
                     begin
                       TEdit(Components[i]).Text:='';
                     end;
//                //if (Components[i] is TMemo ) then
//                   //  begin
//                      // TMemo(Components[i]).Text:='';
//                     //end;
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
////                 if (Components[i] is TDateEdit ) then
////                    begin
////                       TDateEdit(Components[i]).Date:=now;
////                     end;
               end;
end;

procedure TFbparam.btAjPrClick(Sender: TObject);
begin
  if not(edProf.Text.IsEmpty) then
      begin
            datamodule2.fdQuerproc.Close;
            datamodule2.fdQuerproc.SQL.Clear;
            datamodule2.fdQuerproc.SQL.Text:='SELECT count(*) as nb from profil where profil =:pro ' ;
            datamodule2.fdQuerproc.ParamByName('pro').AsString := edprof.Text;
            datamodule2.fdQuerproc.open;
            nb:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger;
            datamodule2.fdQuerproc.Close;

      end;
      if nb=0 then
        begin
           datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='INSERT into profil(profil,datmaj) VALUES (:pro,:datmaj)';
                 datamodule2.fdQuerproc.ParamByName('pro').AsString := edProf.Text;
                 datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
                 datamodule2.fdQuerproc.ExecSQL;
                 datamodule2.fdQuerproc.Close;
                 edProf.Text:='';
        end
        else
        begin

        end;
end;

procedure TFbparam.btPrecClick(Sender: TObject);
begin
  fadmin.show;
end;

procedure TFbparam.btQuitClick(Sender: TObject);
begin
  close;
end;

procedure TFbparam.FormActivate(Sender: TObject);
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
                //if (Components[i] is TMemo ) then
                   //  begin
                      // TMemo(Components[i]).Text:='';
                     //end;
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
