unit admin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,udb;

type
  TFadmin = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btQuit: TButton;
    btUser: TButton;
    btConst: TButton;
    procedure btQuitClick(Sender: TObject);
    procedure btUserClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);
    procedure btConstClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Fadmin: TFadmin;

implementation

{$R *.fmx}
 uses bibli,bibli_user,bibli_param;
procedure TFadmin.btConstClick(Sender: TObject);
begin
  fbparam.show;
end;

procedure TFadmin.btPrecClick(Sender: TObject);
begin
  fbibli.show;
  fadmin.Close;
end;

procedure TFadmin.btQuitClick(Sender: TObject);
begin
  close;

end;

procedure TFadmin.btUserClick(Sender: TObject);
begin
  fbuser.Tag:=1;
    fbuser.show;
end;

end.
