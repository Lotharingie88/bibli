unit bibli_dvdacha;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls,udb, FMX.Edit, FMX.ListBox,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors,firedac.Stan.Param, Data.Bind.Components, Data.Bind.DBScope, FMX.DateTimeCtrls;

type
  TfDvdacha = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btQuit: TButton;
    Button1: TButton;
    Button2: TButton;
    btCons: TButton;
    btMaj: TButton;
    btAjo: TButton;
    btRec: TButton;
    cbTitr: TComboBox;
    edPrix: TEdit;
    ckGrat: TCheckBox;
    edTitr: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edMaj: TEdit;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    dedDach: TDateEdit;
    LinkFillControlToField: TLinkFillControlToField;
    procedure btPrecClick(Sender: TObject);
    procedure btQuitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btAjoClick(Sender: TObject);
    procedure btMajClick(Sender: TObject);
    procedure btRecClick(Sender: TObject);
    procedure cbTitrChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  fDvdacha: TfDvdacha;

implementation

{$R *.fmx}
uses bibli_dvd;
  var
    datmaj: string;
    nb,titr,id:integer;
procedure TfDvdacha.btAjoClick(Sender: TObject);
begin
  btRec.Enabled:=true;
  //cbTitr.Hint := cbtitr.Selected.Text;
  cbTitr.Visible:=false;
  edTitr.Visible:=true;
  //btAjo.Enabled:=true;
  btMaj.Enabled:=false;
  btCons.Enabled:=false;
end;

procedure TfDvdacha.btMajClick(Sender: TObject);
begin
  cbTitr.Visible:=true;
  //cbTitr.Hint := cbtitr.Selected.Text;
  edTitr.Visible:=false;
  btAjo.Enabled:=false;
  //btMaj.Enabled:=true;
  btRec.Enabled:=true;
  btCons.Enabled:=false;
end;

procedure TfDvdacha.btPrecClick(Sender: TObject);
begin
  fdvd.Show;
  fdvdacha.Close;
end;

procedure TfDvdacha.btQuitClick(Sender: TObject);
begin
  close;
end;

procedure TfDvdacha.btRecClick(Sender: TObject);
begin
  //btRec.Enabled:=false;
  //cbTitr.Hint := cbtitr.Selected.Text;
//  cbTitr.Visible:=true;
//  edTitr.Visible:=false;
//  btAjo.Enabled:=true;
//  btMaj.Enabled:=true;
//  btCons.Visible:=true;
  if btMaj.Visible = true then
    begin
       datamodule2.fdQuerproc.Close;
            datamodule2.fdQuerproc.SQL.Clear;
            datamodule2.fdQuerproc.SQL.Text:='SELECT count(*) as nb from dvd as a left join achat as b on a.idtitre=b.iddvd where titre =:tit ' ;
            datamodule2.fdQuerproc.ParamByName('tit').AsString := cbTitr.Selected.Text;
            datamodule2.fdQuerproc.Open;
            nb:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger;
            datamodule2.fdQuerproc.Close;
            if nb=1 then
            begin
               datamodule2.fdQuerproc.Close;
            datamodule2.fdQuerproc.SQL.Clear;
            datamodule2.fdQuerproc.SQL.Text:='SELECT idtitre  from dvd as a left join achat as b on a.idtitre=b.iddvd where titre =:tit ' ;
            datamodule2.fdQuerproc.ParamByName('tit').AsString := cbTitr.Selected.Text;
            datamodule2.fdQuerproc.Open;
            titr:=datamodule2.fdQuerproc.FieldByName('idtitre').AsInteger;
            datamodule2.fdQuerproc.Close;
               datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='UPDATE achat SET prix = :pri,datach=:dach,grat=:gr, datmaj = :maj  WHERE iddvd =:iddv ' ;
                 datamodule2.fdQuerproc.ParamByName('pri').AsString := edPrix.Text;
                 if ckGrat.IsChecked=true then
                 datamodule2.fdQuerproc.ParamByName('gr').AsString := 'O'
                 else
                 datamodule2.fdQuerproc.ParamByName('gr').AsString := 'N';
                  if (not(dedDach.IsEmpty) and (dedDach.Text<>'01/01/0001')) then
                 datamodule2.fdQuerproc.ParamByName('dach').AsDate := StrToDate(dedDach.Text)
                   else
                  datamodule2.fdQuerproc.ParamByName('dach').AsString:='NULL';
                 datamodule2.fdQuerproc.ParamByName('maj').AsDate := StrToDate(Datmaj);
                 datamodule2.fdQuerproc.ParamByName('iddv').AsInteger := titr;
                 datamodule2.fdQuerproc.ExecSQL;
                 datamodule2.fdQuerproc.Close;
            end;
            if nb=0 then
              begin
                 ShowMessage ('Test3!');
              end;
      //exit;
    end;
  if btAjo.Visible=true then
    begin
            datamodule2.fdQuerproc.Close;
            datamodule2.fdQuerproc.SQL.Clear;
            datamodule2.fdQuerproc.SQL.Text:='SELECT count(*) as nb from dvd where titre =:tit ' ;
            datamodule2.fdQuerproc.ParamByName('tit').AsString := edTitr.Text;
            datamodule2.fdQuerproc.Open;
            nb:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger;
            datamodule2.fdQuerproc.Close;
            if nb=0 then
              begin
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='INSERT into dvd(titre,datmaj) VALUES (:tit,:datmaj)';
                 datamodule2.fdQuerproc.ParamByName('tit').AsString := edTitr.Text;
                 datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
                 datamodule2.fdQuerproc.ExecSQL;
                 datamodule2.fdQuerproc.Close;
                  datamodule2.fdQuerproc.SQL.Clear;
                  datamodule2.fdQuerproc.SQL.Text:='SELECT idtitre as id from dvd where titre =:tit ' ;
                  datamodule2.fdQuerproc.ParamByName('tit').AsString := edTitr.Text;
                  datamodule2.fdQuerproc.Open;
                  id:=datamodule2.fdQuerproc.FieldByName('id').AsInteger;
                  datamodule2.fdQuerproc.Close;
                    datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='INSERT into achat(iddvd,prix,datach,datmaj,grat) VALUES (:id,:pri,:ach,:datmaj,:gra)';
                 datamodule2.fdQuerproc.ParamByName('id').AsInteger := id;
                 datamodule2.fdQuerproc.ParamByName('pri').AsString := edPrix.Text;
                 if (not(dedDach.IsEmpty) and (dedDach.Text<>'01/01/0001')) then
                 datamodule2.fdQuerproc.ParamByName('ach').AsDate := StrToDate(dedDach.Text)
                   else
                  datamodule2.fdQuerproc.ParamByName('ach').AsString:='NULL';
                 //datamodule2.fdQuerproc.ParamByName('ach').AsDate := dedDach.date;
                 datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
                 if ckGrat.IsChecked=true then
                    datamodule2.fdQuerproc.ParamByName('gra').AsString := 'O'
                    else
                    datamodule2.fdQuerproc.ParamByName('gra').AsString := 'N';
                 datamodule2.fdQuerproc.ExecSQL;
                 datamodule2.fdQuerproc.Close;

                 //ShowMessage ('Test!');
              end
              else
              begin
                  datamodule2.fdQuerproc.Close;
                  datamodule2.fdQuerproc.SQL.Clear;
                  datamodule2.fdQuerproc.SQL.Text:='SELECT idtitre as id from dvd where titre =:tit ' ;
                  datamodule2.fdQuerproc.ParamByName('tit').AsString := edTitr.Text;
                  datamodule2.fdQuerproc.Open;
                  id:=datamodule2.fdQuerproc.FieldByName('id').AsInteger;
                  datamodule2.fdQuerproc.Close;
                  datamodule2.fdQuerproc.SQL.Clear;
                  datamodule2.fdQuerproc.SQL.Text:='INSERT into achat(iddvd,prix,datach,datmaj,grat) VALUES (:id,:pri,:ach,:datmaj,:gra)';
                  datamodule2.fdQuerproc.ParamByName('id').AsInteger := id;
                 datamodule2.fdQuerproc.ParamByName('pri').AsString := edprix.Text;
                 if (not(dedDach.IsEmpty) and (dedDach.Text<>'01/01/0001')) then
                 datamodule2.fdQuerproc.ParamByName('ach').AsDate := StrToDate(dedDach.Text)
                   else
                  datamodule2.fdQuerproc.ParamByName('ach').AsString:='NULL';
                 //datamodule2.fdQuerproc.ParamByName('ach').AsString := dedDach.Text;
                 datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
                 if ckGrat.IsChecked=true then
                     datamodule2.fdQuerproc.ParamByName('gra').AsString := 'O'
                     else
                     datamodule2.fdQuerproc.ParamByName('gra').AsString := 'N';
                 datamodule2.fdQuerproc.ExecSQL;
                  datamodule2.fdQuerproc.Close;
                  //ShowMessage ('Erreur ! Le DVD existe déjà , passez par la mise à jour !');
              end;
              //exit;
    end;
    cbTitr.Visible:=true;
  edTitr.Visible:=false;
  btAjo.Enabled:=true;
  btMaj.Enabled:=true;
  btCons.Visible:=true;
end;

procedure TfDvdacha.cbTitrChange(Sender: TObject);
var
  nb,nb2,id:integer;
  req,dac,dam:string;
  //act1,act2,act3,real,mes,them,cpays : integer;
begin
       deddach.Text.Empty;
       datamodule2.fdQuerproc.Close;
       datamodule2.fdQuerproc.SQL.Clear;
            //datamodule2.fdQuerproc.SQL.Text:='SELECT count(*) as nb from dvd as a inner join achat as b on a.idtitre=b.iddvd where titre =:tit ' ;
            datamodule2.fdQuerproc.SQL.Text:='SELECT count(*) as nb from dvd,achat where titre =:tit and achat.iddvd=dvd.idtitre ' ;
            datamodule2.fdQuerproc.ParamByName('tit').AsString := cbTitr.Selected.Text;
            datamodule2.fdQuerproc.Open;
            nb:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger;
            datamodule2.fdQuerproc.Close;
            if nb=1 then
             begin
                 datamodule2.fdQuerproc.SQL.Text:='SELECT idtitre as id from dvd where titre =:tit ' ;
                 datamodule2.fdQuerproc.ParamByName('tit').AsString := cbTitr.Selected.Text;
                 datamodule2.fdQuerproc.Open;
                 id:=datamodule2.fdQuerproc.FieldByName('id').AsInteger;
                 datamodule2.fdQuerproc.Close;
                 //datamodule2.fdQuerproc.SQL.Text:='SELECT count(*) as nb from achat where iddvd =:id ' ;
                 //datamodule2.fdQuerproc.ParamByName('id').AsInteger := id;
                 //datamodule2.fdQuerproc.Open;
                // nb2:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger;
                 // datamodule2.fdQuerproc.Close;
                  //if nb2=1 then
                  //begin
                 datamodule2.fdQuerproc.SQL.Clear;
                 req:= 'select strftime(''%d-%m-%Y'',b.datmaj) as datmaj ';
                 req:=req+',b.prix as prix,strftime(''%d-%m-%Y'',b.datach) as datach,grat from achat as b ';

                 datamodule2.fdQuerproc.SQL.Text:=req+ ' where b.iddvd = :id';
                 datamodule2.fdQuerproc.ParamByName('id').AsInteger := id;
                 datamodule2.fdQuerproc.open;
                 if datamodule2.fdQuerproc.FieldByName('prix').AsString <>'' then

                 edprix.Text:= datamodule2.fdQuerproc.FieldByName('prix').AsString
                 else
                 edprix.Text:='';
                 if  not(datamodule2.fdQuerproc.FieldByName('datach').IsNull) then
                 begin
                  dac:= datamodule2.fdQuerproc.FieldByName('datach').AsString;
                   deddach.Text:=dac;
                  //deddach.date := datamodule2.fdQuerproc.FieldByName('datach').asdatetime;
                 end
                  else
                  deddach.text :='' ;
                  dam:= datamodule2.fdQuerproc.FieldByName('datmaj').AsString ;
                 edMaj.text:=dam ;
                 datamodule2.fdQuerproc.Close;
                 // end;

             end;
             if nb=0 then
              begin
                edTitr.Text:=cbTitr.Selected.Text;
                edPrix.Text:='';
                edMaj.Text:='';
                deddach.IsEmpty:=true;
                 btajoclick(nil);
                 //ShowMessage ('Test2!');

              end;
              //exit;
end;

procedure TfDvdacha.FormActivate(Sender: TObject);
var
  i:integer;
begin
    Datmaj := DateToStr(Date);
  btRec.Enabled:=false;

  cbTitr.Visible:=true;
  cbTitr.Hint := cbtitr.Selected.Text;
  edTitr.Visible:=false;
  btAjo.Enabled:=true;
  btMaj.Enabled:=true;
   for i := 0 to Componentcount-1 do
         	begin
            		if (Components[i] is TEdit ) then
                     begin
                      TEdit(Components[i]).Text:='';
                     end;
                //if (Components[i] is TMemo ) then
                   //  begin
                   //   TMemo(Components[i]).Text:='';
                   // end;
                 if (Components[i] is TComboBox ) then
                     begin
                      if TComboBox(Components[i]).items[0]<>''  then
                       TComboBox(Components[i]).items.Insert(0,'');
                     end;
                 if (Components[i] is TDateEdit ) then
                    begin
                       TDateEdit(Components[i]).IsEmpty:=true;;
                     end;
               end;
end;

end.
