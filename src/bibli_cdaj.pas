unit bibli_cdaj;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types, FMX.ListBox,
  FMX.ScrollBox, FMX.Memo, FMX.Edit,udb, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,FireDac.stan.Param,
  Data.Bind.DBScope;

type
  TFcdaj = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btQuit: TButton;
    btNouv: TButton;
    btMod: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    btRec: TButton;
    edCdnot: TEdit;
    edMaj: TEdit;
    edCdDat: TEdit;
    edCdTit: TEdit;
    memCd: TMemo;
    cbCdtit: TComboBox;
    cbPayscd: TComboBox;
    cbGenrcd: TComboBox;
    cbInterp: TComboBox;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField2: TLinkFillControlToField;
    BindSourceDB3: TBindSourceDB;
    LinkFillControlToField3: TLinkFillControlToField;
    BindSourceDB4: TBindSourceDB;
    BindSourceDB5: TBindSourceDB;
    LinkFillControlToField4: TLinkFillControlToField;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure btPrecClick(Sender: TObject);
    procedure btQuitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btModClick(Sender: TObject);
    procedure btNouvClick(Sender: TObject);
    procedure btRecClick(Sender: TObject);
    procedure cbCdtitChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Fcdaj: TFcdaj;

implementation

{$R *.fmx}
  uses bibli_cd;
  var
  req,datmaj:string;
  nb : integer;
procedure TFcdaj.btModClick(Sender: TObject);
begin
  btmod.Enabled:=true;
  btrec.Enabled:=true;
  btnouv.Enabled:=false;
  edcdtit.Visible:=false;
  cbcdtit.Visible:=true;
end;

procedure TFcdaj.btNouvClick(Sender: TObject);
begin
  btmod.Enabled:=false;
  btrec.Enabled:=true;
  btnouv.Enabled:=true;
  edcdtit.Visible:=true;
  cbcdtit.Visible:=false;
end;

procedure TFcdaj.btPrecClick(Sender: TObject);
begin
  fcd.show;
  fcdaj.Close;
end;

procedure TFcdaj.btQuitClick(Sender: TObject);
begin
  close;
end;

procedure TFcdaj.btRecClick(Sender: TObject);
var
  i,cchant,cnat,cthem:integer;
begin

                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idnation from pays where nom = :pays';
                 datamodule2.fdQuerproc.ParamByName('pays').AsString := cbPayscd.Selected.text;
                 datamodule2.fdQuerproc.open;
                 cnat:=datamodule2.fdQuerproc.FieldByName('idnation').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.close;
                 datamodule2.fdQuerproc.SQL.clear;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idactreal from actreal where nomactreal = :chant';
                 datamodule2.fdQuerproc.ParamByName('chant').AsString := cbInterp.Selected.text;
                 datamodule2.fdQuerproc.open;
                 cchant:=datamodule2.fdQuerproc.FieldByName('idactreal').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.close;
                 datamodule2.fdQuerproc.SQL.clear;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='select idtheme from thematique where theme = :them and cd=1';
                 datamodule2.fdQuerproc.ParamByName('them').AsString := cbGenrcd.Selected.text;
                 datamodule2.fdQuerproc.open;
                 cthem:=datamodule2.fdQuerproc.FieldByName('idtheme').AsInteger ;
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.close;
                 datamodule2.fdQuerproc.SQL.clear;


  if btnouv.Enabled=true then
    begin
       if edcdtit.Text<>'' then
        begin
              datamodule2.fdQuerproc.Close;
              datamodule2.fdQuerproc.SQL.Clear;
              datamodule2.fdQuerproc.SQL.Text:='SELECT count(*) as nb from cd where cdnom =:tit ' ;
              datamodule2.fdQuerproc.ParamByName('tit').AsString := edcdtit.Text;
              datamodule2.fdQuerproc.Open;
              nb:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger;
              datamodule2.fdQuerproc.Close;
              if nb=0 then
                begin
                   datamodule2.fdQuerproc.SQL.Text:='INSERT into cd(cdnom,idinterpret,idgenr,ansort,datmaj,idnation,note,avis) VALUES (:tit,:aut,:them,:dpar,:datmaj,:nat,:nota,:avis)';
                   datamodule2.fdQuerproc.ParamByName('tit').AsString := edCdTit.Text;
                   datamodule2.fdQuerproc.ParamByName('aut').AsInteger := cchant;
                   datamodule2.fdQuerproc.ParamByName('them').AsInteger := cthem;
                   datamodule2.fdQuerproc.ParamByName('nat').AsInteger := cnat;
                   if edCdDat.Text<>'' then
                     datamodule2.fdQuerproc.ParamByName('dpar').AsInteger := StrToInt(edCdDat.Text)
                   else
                     datamodule2.fdQuerproc.ParamByName('dpar').Asstring :='';
                   if (edCdNot.text.IsEmpty=True) then
                      datamodule2.fdQuerproc.ParamByName('nota').AsInteger := -0
                      else
                      datamodule2.fdQuerproc.ParamByName('nota').AsInteger := strtoint(edCdNot.Text) ;
                   if (memCd.text.IsEmpty=True) then
                      datamodule2.fdQuerproc.ParamByName('avis').AsString := ''
                      else
                      datamodule2.fdQuerproc.ParamByName('avis').AsString := memCd.Text ;
                   datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
                end;
        end;
    end;
  if btmod.Enabled=true then
    begin
         if cbCdtit.selected.Text<>'' then
          begin
              datamodule2.fdQuerproc.Close;
              datamodule2.fdQuerproc.SQL.Clear;
              datamodule2.fdQuerproc.SQL.Text:='SELECT count(*) as nb from cd where cdnom =:tit ' ;
              datamodule2.fdQuerproc.ParamByName('tit').AsString := cbCdtit.selected.Text;
              datamodule2.fdQuerproc.Open;
              nb:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger;
              datamodule2.fdQuerproc.Close;
              if nb=1 then
                begin
                  req:='UPDATE cd SET idinterpret = :aut,idgenr=:them,';
                  req:=req + 'ansort=:dpar,idnation=:nat,';
                  req:= req + 'avis=:av,note=:nota, datmaj = :maj  WHERE cdnom = :tit' ;
                  datamodule2.fdQuerproc.SQL.Text:=req;
                  datamodule2.fdQuerproc.ParamByName('aut').AsInteger := cchant;
                  datamodule2.fdQuerproc.ParamByName('them').AsInteger  := cthem;
                  datamodule2.fdQuerproc.ParamByName('dpar').AsInteger := strtoint(edCdDat.Text);
                  datamodule2.fdQuerproc.ParamByName('nat').AsInteger  := cnat;
                  if (memCd.text.IsEmpty=True) then
                      datamodule2.fdQuerproc.ParamByName('av').AsString := ''
                      else
                      datamodule2.fdQuerproc.ParamByName('av').AsString := memCd.Text ;
                  if (edCdNot.text.IsEmpty=True) then
                      datamodule2.fdQuerproc.ParamByName('nota').AsInteger := -0
                      else
                      datamodule2.fdQuerproc.ParamByName('nota').AsInteger := strtoint(edCdNot.Text) ;
                  datamodule2.fdQuerproc.ParamByName('maj').AsDate := StrToDate(Datmaj);
                  datamodule2.fdQuerproc.ParamByName('tit').AsString := cbCdTit.Selected.Text;
                end;
          end;
    end;
        datamodule2.fdQuerproc.ExecSQL;
        datamodule2.fdQuerproc.Close;
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

  btmod.Enabled:=false;
  btrec.Enabled:=true;
  btnouv.Enabled:=false;
end;

procedure TFcdaj.cbCdtitChange(Sender: TObject);
begin
              datamodule2.fdQuerproc.Close;
              datamodule2.fdQuerproc.SQL.Clear;
              datamodule2.fdQuerproc.SQL.Text:='SELECT count(*) as nb from cd where cdnom =:tit ' ;
              datamodule2.fdQuerproc.ParamByName('tit').AsString := cbCdtit.Selected.text;
              datamodule2.fdQuerproc.Open;
              nb:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger;
              datamodule2.fdQuerproc.Close;
              if nb=1 then
                 begin

                     datamodule2.fdQuerproc.Close;
                     datamodule2.fdQuerproc.SQL.Clear;
                     req:='SELECT idcd, nomactreal||" "||prenactreal as nom,c.theme,ansort,d.nom,note,avis, a.datmaj from cd as a' ;
                     req:=req + ' left join actreal as b on a.idinterpret=b.idactreal left join thematique as c on a.idgenr=c.idtheme left join pays as d on a.idnation=d.idnation';
                     req:=req + ' where cdnom =:tit ' ;
                     datamodule2.fdQuerproc.SQL.Text:=req ;
                     datamodule2.fdQuerproc.ParamByName('tit').AsString := cbCdtit.Selected.Text;
                     datamodule2.fdQuerproc.Open;
                     cbInterp.Selected.Text:=datamodule2.fdQuerproc.FieldByName('nom').AsString;
                     cbGenrcd.Selected.text :=datamodule2.fdQuerproc.FieldByName('theme').AsString;
                     cbPayscd.Selected.text :=datamodule2.fdQuerproc.FieldByName('nom').AsString;
                     edCddat.text:=datamodule2.fdQuerproc.FieldByName('ansort').AsString;
                     edCdnot.text:=datamodule2.fdQuerproc.FieldByName('note').AsString;
                     memCd.Text:=datamodule2.fdQuerproc.FieldByName('avis').AsString;
                     edMaj.text:=datamodule2.fdQuerproc.FieldByName('datmaj').AsString;
                     datamodule2.fdQuerproc.Close;

                 end;
end;

procedure TFcdaj.FormActivate(Sender: TObject);
var
  i:integer;
begin
    Datmaj := DateToStr(Date);
    btmod.enabled:=true;
    btnouv.Enabled:=true;
    btrec.Enabled:=false;
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
