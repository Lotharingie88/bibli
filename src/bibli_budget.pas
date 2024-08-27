unit bibli_budget;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts,bibli;

type
  TFBudget = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btPrec: TButton;
    btQuit: TButton;
    btBPAnn: TButton;
    btBAnn: TButton;
    procedure btQuitClick(Sender: TObject);
    procedure btPrecClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FBudget: TFBudget;

implementation

{$R *.fmx}

procedure TFBudget.btPrecClick(Sender: TObject);
begin
Fbibli.show;
fbudget.close;
end;

procedure TFBudget.btQuitClick(Sender: TObject);
begin
     close;
end;

end.
