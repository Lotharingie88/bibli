


CREATE DATABASE IF NOT EXISTS `bibliotheque` ;
USE `bibliotheque`;

DROP TABLE IF EXISTS `abonnement`;
CREATE TABLE IF NOT EXISTS `abonnement` (
  `idabo` int NOT NULL AUTO_INCREMENT,
  `idrevue` int NOT NULL,
  `idduree` int NOT NULL,
  `ann` int NOT NULL,
  `date` date NOT NULL,
  `priabo` decimal(8,2) NOT NULL,
  UNIQUE KEY `idabo` (`idabo`)
) ;


DROP TABLE IF EXISTS `achat`;
CREATE TABLE IF NOT EXISTS `achat` (
  `idach` int NOT NULL AUTO_INCREMENT,
  `iddvd` int NOT NULL,
  `idliv` int NOT NULL,
  `prix` decimal(15,2) NOT NULL,
  `datach` date NOT NULL,
  UNIQUE KEY `idach` (`idach`)
) ;



DROP TABLE IF EXISTS `achrev`;
CREATE TABLE IF NOT EXISTS `achrev` (
  `idachrev` int NOT NULL AUTO_INCREMENT,
  `idrev` int NOT NULL,
  `numrevue` int NOT NULL,
  `prixrev` float NOT NULL,
  `semaine` int NOT NULL,
  `mois` int NOT NULL,
  `annee` year NOT NULL,
  UNIQUE KEY `idachrev` (`idachrev`)
);



DROP TABLE IF EXISTS `activite`;
CREATE TABLE IF NOT EXISTS `activite` (
  `cactiv` int NOT NULL AUTO_INCREMENT,
  `metier` varchar(20) NOT NULL,
  PRIMARY KEY (`cactiv`)
);


DROP TABLE IF EXISTS `actreal`;
CREATE TABLE IF NOT EXISTS `actreal` (
  `idactreal` int NOT NULL AUTO_INCREMENT,
  `nomactreal` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `prenactreal` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `acteur` tinyint(1) NOT NULL,
  `realisateur` tinyint(1) NOT NULL,
  `menscene` tinyint(1) NOT NULL,
  `datnaiss` date NOT NULL DEFAULT '0000-00-00',
  `datdec` date NOT NULL DEFAULT '0000-00-00',
  `idnation` int NOT NULL DEFAULT '0',
  `datmaj` date NOT NULL,
  UNIQUE KEY `idauteur` (`idactreal`)
) ;



DROP TABLE IF EXISTS `articles`;
CREATE TABLE IF NOT EXISTS `articles` (
  `idarticle` int NOT NULL AUTO_INCREMENT,
  `titrearticle` varchar(30) NOT NULL DEFAULT '',
  `idauteurarticl` int NOT NULL DEFAULT '0',
  `idrevuebibli` int NOT NULL DEFAULT '0',
  `idthem` int NOT NULL DEFAULT '0',
  `digest` text NOT NULL,
  UNIQUE KEY `idarticle` (`idarticle`)
) ;



DROP TABLE IF EXISTS `auteur`;
CREATE TABLE IF NOT EXISTS `auteur` (
  `idauteur` int NOT NULL AUTO_INCREMENT,
  `nomauteur` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `prenauteur` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `datnaiss` date NOT NULL DEFAULT '0000-00-00',
  `datdec` date NOT NULL DEFAULT '0000-00-00',
  `idnation` int NOT NULL DEFAULT '0',
  `datmaj` date NOT NULL,
  UNIQUE KEY `idauteur` (`idauteur`)
) ;



DROP TABLE IF EXISTS `auteurarticle`;
CREATE TABLE IF NOT EXISTS `auteurarticle` (
  `idauteurarticl` int NOT NULL AUTO_INCREMENT,
  `nomauteurarticl` varchar(20) NOT NULL DEFAULT '',
  `prenauteurarticl` varchar(20) NOT NULL DEFAULT '',
  `datnaissautart` date NOT NULL DEFAULT '0000-00-00',
  `datdecautart` date NOT NULL DEFAULT '0000-00-00',
  `idnation` int NOT NULL DEFAULT '0',
  UNIQUE KEY `idauteur` (`idauteurarticl`)
) ;



DROP TABLE IF EXISTS `duree`;
CREATE TABLE IF NOT EXISTS `duree` (
  `idduree` int NOT NULL AUTO_INCREMENT,
  `lduree` varchar(10) NOT NULL,
  UNIQUE KEY `idduree` (`idduree`)
) ;



DROP TABLE IF EXISTS `dvd`;
CREATE TABLE IF NOT EXISTS `dvd` (
  `idtitre` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(50) NOT NULL DEFAULT '',
  `idrealisateur` int NOT NULL DEFAULT '0',
  `idact1` int NOT NULL,
  `idact2` int NOT NULL,
  `idact3` int NOT NULL,
  `idms` int NOT NULL DEFAULT '0',
  `idthem` int NOT NULL,
  `idnation` int NOT NULL,
  `datsort` year NOT NULL,
  `resume` text NOT NULL,
  `avis` text NOT NULL,
  `note` int NOT NULL,
  `datmaj` date NOT NULL,
  UNIQUE KEY `idtitre` (`idtitre`)
) ;



DROP TABLE IF EXISTS `editeur`;
CREATE TABLE IF NOT EXISTS `editeur` (
  `idediteur` int NOT NULL AUTO_INCREMENT,
  `editeur` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `idnation` int NOT NULL DEFAULT '0',
  `datmaj` date NOT NULL,
  UNIQUE KEY `idediteur` (`idediteur`)
) ;



DROP TABLE IF EXISTS `editionpoche`;
CREATE TABLE IF NOT EXISTS `editionpoche` (
  `ideditionpoche` int NOT NULL AUTO_INCREMENT,
  `editpoch` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `idnation` int NOT NULL DEFAULT '0',
  UNIQUE KEY `ideditionpoche` (`ideditionpoche`)
) ;



DROP TABLE IF EXISTS `joursession`;
CREATE TABLE IF NOT EXISTS `joursession` (
  `idsession` varchar(40) NOT NULL,
  `iduser` int NOT NULL,
  `debsess` datetime NOT NULL,
  `finsess` datetime NOT NULL,
  `datdebjours` date NOT NULL,
  `datefinjours` date NOT NULL,
  UNIQUE KEY `idsession` (`idsession`)
) ;



DROP TABLE IF EXISTS `livres`;
CREATE TABLE IF NOT EXISTS `livres` (
  `idtitre` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(50) NOT NULL DEFAULT '',
  `idauteur` int NOT NULL DEFAULT '0',
  `idediteur` int NOT NULL DEFAULT '0',
  `ideditionpoche` int NOT NULL DEFAULT '0',
  `codepoche` varchar(7) NOT NULL DEFAULT '',
  `idthem` int NOT NULL,
  `isbn` varchar(15) NOT NULL,
  `datparut` year NOT NULL,
  `idnation` int NOT NULL,
  `resume` text NOT NULL,
  `avis` text NOT NULL,
  `note` int NOT NULL,
  `datmaj` date NOT NULL,
  UNIQUE KEY `idtitre` (`idtitre`)
) ;



DROP TABLE IF EXISTS `pays`;
CREATE TABLE IF NOT EXISTS `pays` (
  `idnation` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL DEFAULT '',
  `codinter` char(3) NOT NULL DEFAULT '',
  `idmonnaie` int DEFAULT NULL,
  UNIQUE KEY `idnation` (`idnation`)
) ;



DROP TABLE IF EXISTS `periodicite`;
CREATE TABLE IF NOT EXISTS `periodicite` (
  `idperiodicite` int NOT NULL AUTO_INCREMENT,
  `periode` varchar(20) NOT NULL DEFAULT '',
  `lcperiode` char(3) NOT NULL DEFAULT '',
  UNIQUE KEY `idperiodicite` (`idperiodicite`)
) ;



DROP TABLE IF EXISTS `pret`;
CREATE TABLE IF NOT EXISTS `pret` (
  `idpret` int NOT NULL AUTO_INCREMENT,
  `iddvd` int NOT NULL,
  `idliv` int NOT NULL,
  `idrev` int NOT NULL,
  `idempr` int NOT NULL,
  `date` date NOT NULL,
  UNIQUE KEY `idpret` (`idpret`)
);



DROP TABLE IF EXISTS `profil`;
CREATE TABLE IF NOT EXISTS `profil` (
  `cprofil` int NOT NULL AUTO_INCREMENT,
  `profil` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`cprofil`)
) ;



DROP TABLE IF EXISTS `revues`;
CREATE TABLE IF NOT EXISTS `revues` (
  `idrevue` int NOT NULL AUTO_INCREMENT,
  `titrerevue` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `idperiodicite` int NOT NULL DEFAULT '0',
  `idnation` int NOT NULL DEFAULT '0',
  `idtheme` int NOT NULL DEFAULT '0',
  `codpress` varchar(10) NOT NULL,
  `flok` char(1) NOT NULL DEFAULT 'O',
  `datmaj` date NOT NULL,
  UNIQUE KEY `idrevue` (`idrevue`)
); 



DROP TABLE IF EXISTS `session`;
CREATE TABLE IF NOT EXISTS `session` (
  `idsession` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nom` varchar(25) NOT NULL,
  `prenom` varchar(20) NOT NULL,
  `limtime` int NOT NULL,
  `datdeb` datetime NOT NULL,
  UNIQUE KEY `idsession` (`idsession`)
) ;


DROP TABLE IF EXISTS `sommairerev`;
CREATE TABLE IF NOT EXISTS `sommairerev` (
  `idsommaire` int NOT NULL AUTO_INCREMENT,
  `idrevue` int NOT NULL,
  `numrevue` int NOT NULL,
  `aticle1` text NOT NULL,
  PRIMARY KEY (`idsommaire`)
) ;



DROP TABLE IF EXISTS `thematique`;
CREATE TABLE IF NOT EXISTS `thematique` (
  `idtheme` int NOT NULL AUTO_INCREMENT,
  `theme` varchar(20) NOT NULL DEFAULT '',
  `lctheme` char(3) NOT NULL DEFAULT '',
  `revue` int NOT NULL,
  `livre` int NOT NULL,
  `dvd` int NOT NULL,
  UNIQUE KEY `idtheme` (`idtheme`)
) ;



DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `iduser` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(25) NOT NULL,
  `prenom` varchar(25) NOT NULL,
  `telephone` int NOT NULL,
  `email` varchar(30) NOT NULL,
  `pwd` varchar(10) NOT NULL,
  `cprofil` int NOT NULL,
  `activite` int NOT NULL,
  `datdeb` date NOT NULL,
  `datfin` date NOT NULL,
  `datmaj` date NOT NULL,
  PRIMARY KEY (`iduser`)
) ;
COMMIT;


