unit bibli_dvdaj;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation,FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ListBox,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.Edit, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.ComboEdit,uDb;

type
  TFDvdAj = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btQuit: TButton;
    FDQuerDvdaj: TFDQuery;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    cbGenr: TComboBox;
    cbPays: TComboBox;
    cbAct1: TComboBox;
    cbAct2: TComboBox;
    cbAct3: TComboBox;
    cbReal: TComboBox;
    edFilm: TEdit;
    edDure: TEdit;
    edNot: TEdit;
    edMaj: TEdit;
    memAvi: TMemo;
    memResu: TMemo;
    btAjo: TButton;
    btReg: TButton;
    btModi: TButton;
    edAnsort: TEdit;
    cbMetScen: TComboBox;
    cbFilm: TComboBox;
    BindSourceDB1: TBindSourceDB;
    BindSourceDB2: TBindSourceDB;
    BindSourceDB3: TBindSourceDB;
    BindSourceDB4: TBindSourceDB;
    BindSourceDB5: TBindSourceDB;
    BindSourceDB6: TBindSourceDB;
    FDQuerdvdIns: TFDQuery;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    LinkFillControlToField2: TLinkFillControlToField;
    LinkFillControlToField3: TLinkFillControlToField;
    LinkFillControlToField4: TLinkFillControlToField;
    LinkFillControlToField5: TLinkFillControlToField;
    LinkFillControlToField6: TLinkFillControlToField;
    LinkFillControlToField7: TLinkFillControlToField;
    LinkFillControlToField8: TLinkFillControlToField;
    procedure btQuitClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btModiClick(Sender: TObject);
    procedure btAjoClick(Sender: TObject);
    procedure btRegClick(Sender: TObject);
    procedure cbFilmChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FDvdAj: TFDvdAj;

implementation

{$R *.fmx}
uses bibli_dvd;
var
  Datmaj:string;

procedure TFDvdAj.btAjoClick(Sender: TObject);
begin
  btReg.Enabled:=true;
  btModi.Enabled:=false;
  cbFilm.Visible:=false;
end;

procedure TFDvdAj.btModiClick(Sender: TObject);
var
  film:string;
begin
  btReg.Enabled:=true;
  cbFilm.Visible:=true;
  btAjo.Enabled:=false;
  
end;

procedure TFDvdAj.btQuitClick(Sender: TObject);
begin
  close;
end;

procedure TFDvdAj.btRegClick(Sender: TObject);
var
  nb:integer;
  act1,act2,act3,real,ms,them,cpays : integer;
begin
  if btAjo.Enabled=true then
    begin
       if edFilm.Text<>'' then
        begin
           fdQuerDvdaj.Close;
            fdQuerDvdaj.SQL.Clear;
            fdQuerDvdaj.SQL.Text:='SELECT count(*) as nb from dvd where titre =:tit ' ;
            fdQuerDvdaj.ParamByName('tit').AsString := edFilm.Text;
            fdQuerDvdaj.Open;
            nb:=fdQuerDvdaj.FieldByName('nb').AsInteger;
            fdQuerDvdaj.Close;
            if nb=0 then
              begin
//                 fdQuerDvdaj.Close;
//                 fdQuerDvdaj.SQL.Clear;
//                 fdQuerDvdaj.SQL.Text:='select idnation from pays where nom = :pays';
//                 fdQuerDvdaj.ParamByName('pays').AsString := cbPays.Selected.text;
//                 fdQuerDvdaj.open;
//                 cpays:=fdQuerDvdaj.FieldByName('idnation').AsInteger ;
//                 fdQuerDvdaj.Close;
//                 fdQuerDvdaj.Close;
//                 fdQuerDvdaj.SQL.Clear;
//                 fdQuerDvdaj.SQL.Text:='select idactreal from actreal where nomactreal = :nom and acteur=1';
//                 fdQuerDvdaj.ParamByName('nom').AsString := cbAct1.Selected.text;
//                 fdQuerDvdaj.open;
//                 act1:=fdQuerDvdaj.FieldByName('idactreal').AsInteger ;
//                 fdQuerDvdaj.Close;
//                 fdQuerDvdaj.SQL.Clear;
//                 fdQuerDvdaj.SQL.Text:='select idactreal from actreal where nomactreal = :nom and realisateur=1';
//                 fdQuerDvdaj.ParamByName('nom').AsString := cbReal.Selected.text;
//                 fdQuerDvdaj.open;
//                 real:=fdQuerDvdaj.FieldByName('idactreal').AsInteger ;
//                 fdQuerDvdaj.Close;

//                 fdQuerDvdIns.Close;
//                 fdQuerDvdIns.SQL.Clear;
//                 fdQuerDvdIns.SQL.Text:='INSERT into dvd(titre,datsort,duree,datmaj,idnation,idact1,idrealisateur) VALUES (:tit,:sort,:dure,:datmaj,:nat,:acte1,:rea)';
//                 fdQuerDvdIns.ParamByName('tit').AsString := edFilm.Text;
//                 fdQuerDvdIns.ParamByName('sort').AsString := edAnsort.Text;
//                 fdQuerDvdIns.ParamByName('dure').AsString := edDure.Text;
//                 fdQuerDvdIns.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
//                 fdQuerDvdIns.ParamByName('nat').AsInteger := cpays;
//                 fdQuerDvdIns.ParamByName('acte1').AsInteger := act1;
//                 fdQuerDvdIns.ParamByName('rea').AsInteger := real;
//                 fdQuerDvdIns.ExecSQL;
//                 fdQuerDvdIns.Close;
              end;

        end;

    end;
  if btmodi.Enabled=true then
    begin

    end;

end;

procedure TFDvdAj.btPrecClick(Sender: TObject);
begin
  fdvd.show();
  fdvdaj.Close;
end;

procedure TFDvdAj.cbFilmChange(Sender: TObject);
var
  nb:integer;
  act1,act2,act3,real,ms,them,cpays : integer;
begin
   fdQuerDvdaj.Close;
    fdQuerDvdaj.SQL.Clear;
            fdQuerDvdaj.SQL.Text:='SELECT count(*) as nb from dvd where titre =:tit ' ;
            fdQuerDvdaj.ParamByName('tit').AsString := cbFilm.Selected.Text;
            fdQuerDvdaj.Open;
            nb:=fdQuerDvdaj.FieldByName('nb').AsInteger;
            fdQuerDvdaj.Close;
            if nb=1 then
              begin
                 fdQuerDvdaj.Close;
                 fdQuerDvdaj.SQL.Clear;
                 fdQuerDvdaj.SQL.Text:='select datsort,duree,strftime("%d/%m/%Y",datmaj) as datmaj,idnation,idthem,idrealisateur,idact1,idact2,idact3,idms from dvd where titre = :tit';
                 fdQuerDvdaj.ParamByName('tit').AsString := cbFilm.Selected.Text;

                 fdQuerDvdaj.open;
                 edAnsort.Text:=fdQuerDvdaj.FieldByName('datsort').AsString ;
                 edDure.Text:=fdQuerDvdaj.FieldByName('duree').AsString ;
                 edMaj.text:=fdQuerDvdaj.FieldByName('datmaj').AsString ;
                 act1:=fdQuerDvdaj.FieldByName('idact1').AsInteger ;
                 act2:=fdQuerDvdaj.FieldByName('idact2').AsInteger ;
                 act3:=fdQuerDvdaj.FieldByName('idact3').AsInteger ;
                 real:=fdQuerDvdaj.FieldByName('idrealisateur').AsInteger ;
                 ms:=fdQuerDvdaj.FieldByName('idms').AsInteger ;
                 them:=fdQuerDvdaj.FieldByName('idthem').AsInteger ;
                 cpays:=fdQuerDvdaj.FieldByName('idnation').AsInteger ;
                 fdQuerDvdaj.Close;
                 fdQuerDvdaj.Close;
                 fdQuerDvdaj.SQL.Clear;
                 fdQuerDvdaj.SQL.Text:='select nom from pays where idnation = :pays';
                 fdQuerDvdaj.ParamByName('pays').AsInteger := cpays;
                 fdQuerDvdaj.open;
                 cbPays.Selected.Text:=fdQuerDvdaj.FieldByName('nom').AsString ;
                 fdQuerDvdaj.Close;
                // DATE_FORMAT(datnaiss,"%d/%m/%Y")

              end;
end;

procedure TFDvdAj.FormActivate(Sender: TObject);
  var
    indreal:integer;
    real,pays,genr,mets,act1,act2,act3,film: string;

begin
  Datmaj := DateToStr(Date);
  btReg.Enabled:=false;
  cbFilm.Visible:=False;
  btAjo.Enabled:=true;
  btModi.Enabled:=true;
  

//          ReqMaj.Close;
//     	ReqMaj.SQL.Clear;
//     	ReqMaj.SQL.Text := 'SELECT idperson,nom,prenom FROM personnes ORDER BY nom,prenom';
//
//          ReqMaj.Open;
//          CbPerson.Text:='';
//      	CbPerson.Items.Clear();
//          CbPerson.ItemIndex := 0;
//          CbPerson.Items.Add('');
//
//          ReqMaj.first;
//      	while not ReqMaj.Eof do
//          begin
//
//               IndPers := ReqMaj.FieldByName('idperson').AsString;
//               //CbPerson.ItemIndex  := ReqMaj.FieldByName('idperson').AsInteger;
//               individu :=  ReqMaj.FieldByName('nom').AsString + ' ' + ReqMaj.FieldByName('prenom').AsString + ' -' + ReqMaj.FieldByName('idperson').AsString;
//               CbPerson.AddItem(individu,TObject(StrtoInt(IndPers)));
//               ReqMaj.Next;
//       	end;
//          CbPerson.Text:='';
//
//     ReqMaj.Refresh;
//	CbPerson.update;
//


end;

end.
