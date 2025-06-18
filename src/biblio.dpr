program biblio;

uses
  System.StartUpCopy,
  FMX.Forms,
  bibli in 'bibli.pas' {FBibli},
  bibli_liv1 in 'bibli_liv1.pas' {FLiv},
  bibli_livAut in 'bibli_livAut.pas' {FAuteur},
  uDatUtil in 'uDatUtil.pas',
  bibli_revue in 'bibli_revue.pas' {Fbibli_revue},
  bibli_dvd in 'bibli_dvd.pas' {Fdvd},
  bibli_cd in 'bibli_cd.pas' {Fcd},
  bibli_livachat in 'bibli_livachat.pas' {FLacha},
  bibli_livcons in 'bibli_livcons.pas' {Flivcons},
  bibli_livaj in 'bibli_livaj.pas' {Flivaj},
  bibli_livedi in 'bibli_livedi.pas' {FEdit},
  bibli_livpret in 'bibli_livpret.pas' {Fpret},
  bibli_revsuiv in 'bibli_revsuiv.pas' {Fbibli_revsuiv},
  bibli_revcont in 'bibli_revcont.pas' {Fbibli_revcont},
  bibli_revaj in 'bibli_revaj.pas' {Fbibli_revaj},
  bibli_revach in 'bibli_revach.pas' {Fbibli_revach},
  bibli_budget in 'bibli_budget.pas' {FBudget},
  uDB in 'uDB.pas' {DataModule2: TDataModule},
  bibli_dvdcons in 'bibli_dvdcons.pas' {FDVDcons},
  bibli_DvdRea in 'bibli_DvdRea.pas' {FDvdRea},
  bibli_DvdAct in 'bibli_DvdAct.pas' {fDvdact},
  bibli_dvdajo in 'bibli_dvdajo.pas' {fDvdAjo},
  bibli_dvdacha in 'bibli_dvdacha.pas' {fDvdacha},
  bibli_user in 'bibli_user.pas' {FBuser},
  bibli_cdcons in 'bibli_cdcons.pas' {Fbibli_cdcons},
  bibli_cdach in 'bibli_cdach.pas' {Fbibli_cdach},
  bibli_cdaj in 'bibli_cdaj.pas' {Fbibli_cdaj},
  admin in 'admin.pas' {Fadmin},
  bibli_param in 'bibli_param.pas' {Fbparam},
  bibli_aprop in 'bibli_aprop.pas' {FAprop};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFBibli, FBibli);
  Application.CreateForm(TFBudget, FBudget);
  Application.CreateForm(TFLiv, FLiv);
  Application.CreateForm(TFAuteur, FAuteur);
  Application.CreateForm(TFbibli_revue, Fbibli_revue);
  Application.CreateForm(TFcd, Fcd);
  Application.CreateForm(TFdvd, Fdvd);
  Application.CreateForm(TFlivcons, Flivcons);
  Application.CreateForm(TFLacha, FLacha);
  Application.CreateForm(TFlivaj, Flivaj);
  Application.CreateForm(TFEdit, FEdit);
  Application.CreateForm(TFpret, Fpret);
  Application.CreateForm(TFbibli_revsuiv, Fbibli_revsuiv);
  Application.CreateForm(TFbibli_revcont, Fbibli_revcont);
  Application.CreateForm(TFbibli_revaj, Fbibli_revaj);
  Application.CreateForm(TFbibli_revach, Fbibli_revach);
  Application.CreateForm(TDataModule2, DataModule2);
  Application.CreateForm(TFDVDcons, FDVDcons);
  Application.CreateForm(TFDvdRea, FDvdRea);
  Application.CreateForm(TfDvdact, fDvdact);
  Application.CreateForm(TfDvdAjo, fDvdAjo);
  Application.CreateForm(TfDvdacha, fDvdacha);
  Application.CreateForm(TFBuser, FBuser);
  Application.CreateForm(TFcdcons, Fcdcons);
  Application.CreateForm(TFcdcons, Fcdcons);
  Application.CreateForm(TFcdach, Fcdach);
  Application.CreateForm(TFcdach, Fcdach);
  Application.CreateForm(TFcdaj, Fcdaj);
  Application.CreateForm(TFcdaj, Fcdaj);
  Application.CreateForm(TFadmin, Fadmin);
  Application.CreateForm(TFbparam, Fbparam);
  Application.CreateForm(TFAprop, FAprop);
  Application.Run;
end.
