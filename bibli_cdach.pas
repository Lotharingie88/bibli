unit bibli_cdach;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.DateTimeCtrls, FMX.ListBox,
  FMX.Edit,udb, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TFcdach = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btQuit: TButton;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edPriCd: TEdit;
    edMaj: TEdit;
    cbCdTit: TComboBox;
    ckGrat: TCheckBox;
    dedDatach: TDateEdit;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    btRec: TButton;
    edCdTit: TEdit;
    procedure btPrecClick(Sender: TObject);
    procedure btQuitClick(Sender: TObject);
    procedure btRecClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Fcdach: TFcdach;

implementation

{$R *.fmx}
 uses bibli_cd;
 var
  nb,id:integer;
  datmaj:string;
procedure TFcdach.btPrecClick(Sender: TObject);
begin
  fcd.show;
  fcdach.close;
end;

procedure TFcdach.btQuitClick(Sender: TObject);
begin
  close;
end;

procedure TFcdach.btRecClick(Sender: TObject);
begin
            datamodule2.fdQuerproc.Close;
            datamodule2.fdQuerproc.SQL.Clear;
            datamodule2.fdQuerproc.SQL.Text:='SELECT count(*) as nb from cd where cdnom =:tit ' ;
            datamodule2.fdQuerproc.ParamByName('tit').AsString := edCdTit.Text;
            datamodule2.fdQuerproc.Open;
            nb:=datamodule2.fdQuerproc.FieldByName('nb').AsInteger;
            datamodule2.fdQuerproc.Close;
            if nb=0 then
              begin
                 datamodule2.fdQuerproc.Close;
                 datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='INSERT into cd(cdnom,datmaj) VALUES (:tit,:datmaj)';
                 datamodule2.fdQuerproc.ParamByName('tit').AsString := edcdTit.Text;
                 datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
                 datamodule2.fdQuerproc.ExecSQL;
                 datamodule2.fdQuerproc.Close;
                  datamodule2.fdQuerproc.SQL.Clear;
                  datamodule2.fdQuerproc.SQL.Text:='SELECT idcd as id from cd where cdnom =:tit ' ;
                  datamodule2.fdQuerproc.ParamByName('tit').AsString := edcdTit.Text;
                  datamodule2.fdQuerproc.Open;
                  id:=datamodule2.fdQuerproc.FieldByName('id').AsInteger;
                  datamodule2.fdQuerproc.Close;
                    datamodule2.fdQuerproc.SQL.Clear;
                 datamodule2.fdQuerproc.SQL.Text:='INSERT into achat(idcd,prix,datach,datmaj,grat) VALUES (:id,:pri,:ach,:datmaj,:gra)';
                 datamodule2.fdQuerproc.ParamByName('id').AsInteger := id;
                 datamodule2.fdQuerproc.ParamByName('pri').AsString := edPricd.Text;
                 if (not(dedDatach.IsEmpty) and (dedDatach.Text<>'01/01/0001')) then
                 datamodule2.fdQuerproc.ParamByName('ach').AsDate := StrToDate(dedDatach.Text)
                   else
                  datamodule2.fdQuerproc.ParamByName('ach').AsString:='NULL';
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
                  datamodule2.fdQuerproc.SQL.Text:='SELECT idtitre as id from cd where cdnom =:tit ' ;
                  datamodule2.fdQuerproc.ParamByName('tit').AsString := edcdTit.Text;
                  datamodule2.fdQuerproc.Open;
                  id:=datamodule2.fdQuerproc.FieldByName('id').AsInteger;
                  datamodule2.fdQuerproc.Close;
                  datamodule2.fdQuerproc.SQL.Clear;
                  datamodule2.fdQuerproc.SQL.Text:='INSERT into achat(idcd,prix,datach,datmaj,grat) VALUES (:id,:pri,:ach,:datmaj,:gra)';
                  datamodule2.fdQuerproc.ParamByName('id').AsInteger := id;
                 datamodule2.fdQuerproc.ParamByName('pri').AsString := edpricd.Text;
                 if (not(dedDatach.IsEmpty) and (dedDatach.Text<>'01/01/0001')) then
                 datamodule2.fdQuerproc.ParamByName('ach').AsDate := StrToDate(dedDatach.Text)
                   else
                  datamodule2.fdQuerproc.ParamByName('ach').AsString:='NULL';
                 datamodule2.fdQuerproc.ParamByName('datmaj').AsDate := StrToDate(Datmaj);
                 if ckGrat.IsChecked=true then
                     datamodule2.fdQuerproc.ParamByName('gra').AsString := 'O'
                     else
                     datamodule2.fdQuerproc.ParamByName('gra').AsString := 'N';
                 datamodule2.fdQuerproc.ExecSQL;
                  datamodule2.fdQuerproc.Close;
              end;
end;

procedure TFcdach.FormActivate(Sender: TObject);
begin
   Datmaj := DateToStr(Date);
end;

end.
