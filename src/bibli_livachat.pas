unit bibli_livachat;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Edit, FMX.ListBox,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  FireDAC.Comp.DataSet, Data.Bind.DBScope, FMX.DateTimeCtrls,udb;

type
  TFLacha = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btQuit: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cbTitre: TComboBox;
    edPrix: TEdit;
    edDatach: TEdit;
    btRec: TButton;
    Label4: TLabel;
    Panel1: TPanel;
    rbO: TRadioButton;
    rbN: TRadioButton;
    edAuteur: TEdit;
    Label5: TLabel;
    fdqRLiv: TFDQuery;
    dedDach: TDateEdit;
    BindingsList1: TBindingsList;
    BindSourceDB2: TBindSourceDB;
    BindSourceDB1: TBindSourceDB;
    LinkFillControlToField: TLinkFillControlToField;
    procedure btQuitClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbTitreChange(Sender: TObject);
    procedure btRecClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FLacha: TFLacha;

implementation

{$R *.fmx}
 uses bibli_liv1;
 var
 cod:integer;
 Datmaj : String;
procedure TFLacha.btPrecClick(Sender: TObject);
begin
  FLiv.Show;
  Flacha.Close;
end;

procedure TFLacha.btQuitClick(Sender: TObject);
begin
close;
end;

procedure TFLacha.btRecClick(Sender: TObject);
begin
       rbO.IsChecked:=True;
       fdqRLiv.SQL.Clear;
       fdqRLiv.SQL.Text:='SELECT prix,datach,nomauteur,prenauteur from livres,achat,auteur where titre =:tit and achat.idliv=livres.idtitre and livres.idauteur =auteur.idauteur ' ;
       fdqRLiv.ParamByName('tit').AsString := cbTitre.Selected.Text;
       fdqRLiv.SQL.Text:='INSERT into achat(idliv,prix,datach) VALUES (:cod,:pr,:dach)';
       fdqRLiv.ParamByName('cod').AsInteger := cod;
       fdqRLiv.ParamByName('pr').AsFloat := strtofloat(edPrix.Text);
       fdqRLiv.ParamByName('dach').AsDate := dedDach.Date;
       fdqRLiv.ExecSQL;
end;

procedure TFLacha.cbTitreChange(Sender: TObject);
begin
 //test
       fdqRLiv.SQL.Clear;
       fdqRLiv.SQL.Text:='SELECT idtitre,nomauteur,prenauteur from livres,auteur where titre =:tit and livres.idauteur =auteur.idauteur ' ;
       fdqRLiv.ParamByName('tit').AsString := cbTitre.Selected.Text;
       fdqRLiv.Open;
       cod:=   fdqRLiv.FieldByName('idtitre').AsInteger;
       edAuteur.Text := fdqRLiv.FieldByName('nomauteur').AsString + ' ' +fdqRLiv.FieldByName('prenauteur').AsString ;

       fdqRLiv.SQL.Clear;
       fdqRLiv.SQL.Text:='SELECT count(*) as nb,prix,datach from livres,achat where idtitre =:codt and achat.idliv=livres.idtitre' ;
       fdqRLiv.ParamByName('codt').AsInteger := cod;
       fdqRLiv.Open;
       if fdqRLiv.FieldByName('nb').AsInteger <>0 then
       begin
       edPrix.Text:=fdqRLiv.FieldByName('prix').AsString;
       if not(fdqRLiv.FieldByName('datach').IsNull)=true then
          begin
              rbO.IsChecked:=True;
              //edDatach.Text:=fdqRLiv.FieldByName('datach').AsString;
               dedDach.date := fdqRLiv.FieldByName('datach').AsDateTime ;
          end
          else
          begin
              dedDach.text:='';
              rbN.IsChecked:=True;
          end;
       end
       else
       begin
              edPrix.Text:='';
              dedDach.text:='';
              rbN.IsChecked:=True;

       end;
end;

procedure TFLacha.FormActivate(Sender: TObject);
begin
 Datmaj := DateToStr(Date);
end;

end.
