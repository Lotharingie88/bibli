object DataModule2: TDataModule2
  Height = 500
  Width = 640
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 24
    Top = 8
  end
  object FDQuerProc: TFDQuery
    Connection = FDConnectSqlite
    UpdateOptions.AssignedValues = [uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    Left = 328
    Top = 16
  end
  object FDScript1: TFDScript
    SQLScripts = <>
    Connection = FDConnectSqlite
    Params = <>
    Macros = <>
    Left = 264
    Top = 16
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 480
    Top = 8
  end
  object FDConnectMysql: TFDConnection
    Params.Strings = (
      'DriverID=MySQL')
    Left = 584
    Top = 8
  end
  object FDQuerThem: TFDQuery
    Connection = FDConnectSqlite
    SQL.Strings = (
      'select idtheme,theme from thematique where dvd=1 order by theme')
    Left = 24
    Top = 192
  end
  object FDQuerFilm: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      'select idtitre,titre from dvd order by titre')
    Left = 24
    Top = 256
  end
  object FDQuerAct: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      
        'select idactreal,nomactreal||'#39' '#39'||prenactreal as act from actrea' +
        'l where acteur=1 order by act')
    Left = 120
    Top = 8
  end
  object FDQuerReal: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      
        'select idactreal, nomactreal||'#39' '#39'||prenactreal as real from  act' +
        'real where realisateur=1 order by real')
    Left = 120
    Top = 64
  end
  object FDQuerMes: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      
        'select idactreal, nomactreal||'#39' '#39'||prenactreal as mes from actre' +
        'al where menscene =1 order by mes')
    Left = 120
    Top = 128
  end
  object FDTabPays: TFDTable
    Active = True
    IndexFieldNames = 'idnation'
    DetailFields = 'idnation;nom;codinter'
    Connection = FDConnectSqlite
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'pays'
    Left = 24
    Top = 128
  end
  object FDTabGenre: TFDTable
    Active = True
    IndexFieldNames = 'idtheme'
    DetailFields = 'theme;lctheme;idtheme;dvd'
    Connection = FDConnectSqlite
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'thematique'
    Left = 120
    Top = 256
  end
  object FDConnectSqlite: TFDConnection
    ConnectionName = 'gestbibli'
    Params.Strings = (
      'DriverID=SQLite'
      'Database=C:\user\delphi\projets\bibli\data\biblio.db'
      'DateTimeFormat=DateTime'
      'LockingMode=Normal'
      'Synchronous=Normal')
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 64
  end
  object FDQuerNomAct: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      
        'select idactreal,nomactreal as act from actreal where acteur=1 o' +
        'rder by act')
    Left = 120
    Top = 192
  end
  object FDQuerLivr: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      
        'select idtitre,titre,b.nomauteur,b.prenauteur,nomedit,editpoch,c' +
        'odepoche,isbn,datparut,note,theme from livres as a left join aut' +
        'eur as b on a.idauteur=b.idauteur left join editeur as c on a.id' +
        'editeur=c.idediteur left join thematique as d on a.idthem=d.idth' +
        'eme left join editionpoche as e on a.ideditionpoche=e.ideditionp' +
        'oche group by titre')
    Left = 24
    Top = 328
  end
  object FDQuerEdit: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      'select idediteur, nomedit,idnation from editeur')
    Left = 112
    Top = 328
  end
  object FDQuerEdiP: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      
        'select ideditionpoche,editpoch from editionpoche order by editpo' +
        'ch')
    Left = 24
    Top = 384
  end
  object FDQuerThemL: TFDQuery
    Connection = FDConnectSqlite
    SQL.Strings = (
      
        'select idtheme,theme from thematique where livre=1 order by them' +
        'e')
    Left = 112
    Top = 384
  end
  object FDQuerCd: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      'select idcd,cdnom from cd order by cdnom')
    Left = 248
    Top = 72
  end
  object FDQuerRev: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      'select idrevue,titrerevue from revues order by titrerevue')
    Left = 328
    Top = 72
  end
  object FDQuerUser: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      
        'select iduser,nom, prenom, nom||'#39' '#39'||prenom as user from utilisa' +
        'teur order by nom,prenom')
    Left = 248
    Top = 184
  end
  object FDQuerAuteur: TFDQuery
    Active = True
    IndexFieldNames = 'aut;datdec;datnaiss;idauteur;nomauteur;prenauteur;vilnaiss'
    Connection = FDConnectSqlite
    SQL.Strings = (
      
        'select idauteur,nomauteur,prenauteur,nomauteur||'#39' '#39'||prenauteur ' +
        'as aut,datnaiss,vilnaiss,datdec from auteur order by nomauteur')
    Left = 248
    Top = 128
  end
  object FDQuerDvdActRealGenre: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      
        'select titre,datsort as sortie,b.nomactreal as acteur,c.theme as' +
        ' genre,d.nom as origine from dvd as a left  join actreal as b on' +
        ' a.idact1=b.idactreal left  join thematique as c on '
      
        'a.idthem=c.idtheme left join pays as d on a.idnation=d.idnation ' +
        'order by a.titre')
    Left = 328
    Top = 320
  end
  object FDQuerNomRealScec: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      
        'select idactreal,nomactreal as rea from actreal where realisateu' +
        'r=1 or menscene=1 order by rea')
    Left = 256
    Top = 320
  end
  object FDQuerAct2: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      
        'select idactreal,(nomactreal||'#39' '#39'||prenactreal) as act from actr' +
        'eal where acteur=1 order by act')
    Left = 256
    Top = 256
  end
  object FDQuerActiv: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      'select cactiv,metier from activite order by metier')
    Left = 328
    Top = 128
  end
  object FDQuerProf: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      'select cprofil,profil from profil order by profil')
    Left = 328
    Top = 184
  end
  object FDQuerProc2: TFDQuery
    Connection = FDConnectSqlite
    Left = 376
    Top = 16
  end
  object FDQuerAct3: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      
        'select idactreal,(nomactreal||'#39' '#39'||prenactreal) as act from actr' +
        'eal where acteur=1 order by act'
      '')
    Left = 328
    Top = 256
  end
  object FDQuerLivBas: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      'select idtitre,titre from livres order by titre'
      '')
    Left = 232
    Top = 384
  end
  object FDQuerChant: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      
        'select idactreal, nomactreal||'#39' '#39'||prenactreal as chan from actr' +
        'eal where chant =1 order by chan')
    Left = 328
    Top = 384
  end
  object FDQuerPerio: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      'select idperiodicite,periode from periodicite')
    Left = 392
    Top = 80
  end
  object FDQuerThemCd: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      'select idtheme,theme from thematique where cd=1 order by theme')
    Left = 400
    Top = 384
  end
  object FDQuerCdGlob: TFDQuery
    Active = True
    Connection = FDConnectSqlite
    SQL.Strings = (
      
        'select cdnom as titre, b.nomactreal as chanteur,c.theme as genre' +
        ',ansort as sortie, note, d.nom as pays  from cd as a left join a' +
        'ctreal as b on a.idinterpret =b.idactreal left join thematique a' +
        's c on a.idgenr=c.idtheme left join pays as d on a.idnation=d.id' +
        'nation')
    Left = 424
    Top = 160
  end
end
