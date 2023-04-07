-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versione server:              10.6.4-MariaDB - mariadb.org binary distribution
-- S.O. server:                  Win64
-- HeidiSQL Versione:            11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dump della struttura del database app
CREATE DATABASE IF NOT EXISTS `app` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `app`;

-- Dump della struttura di tabella app.corso
CREATE TABLE IF NOT EXISTS `corso` (
  `primary_key` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SSD` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CFU` int(11) DEFAULT NULL,
  PRIMARY KEY (`primary_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella app.corso: ~0 rows (circa)
/*!40000 ALTER TABLE `corso` DISABLE KEYS */;
/*!40000 ALTER TABLE `corso` ENABLE KEYS */;

-- Dump della struttura di tabella app.corsodilaurea
CREATE TABLE IF NOT EXISTS `corsodilaurea` (
  `primary_key` int(11) NOT NULL AUTO_INCREMENT,
  `nome` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ordinamento` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `magistrale` tinyint(4) DEFAULT NULL,
  `CFU` int(11) DEFAULT NULL,
  PRIMARY KEY (`primary_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella app.corsodilaurea: ~0 rows (circa)
/*!40000 ALTER TABLE `corsodilaurea` DISABLE KEYS */;
/*!40000 ALTER TABLE `corsodilaurea` ENABLE KEYS */;

-- Dump della struttura di tabella app.linkcv
CREATE TABLE IF NOT EXISTS `linkcv` (
  `primary_key` int(11) NOT NULL AUTO_INCREMENT,
  `corso_key` int(11) NOT NULL DEFAULT 0,
  `valutazione_key` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`primary_key`),
  KEY `corso_key` (`corso_key`),
  KEY `valutazione_key` (`valutazione_key`),
  CONSTRAINT `FK_linkcv_corso` FOREIGN KEY (`corso_key`) REFERENCES `corso` (`primary_key`),
  CONSTRAINT `FK_linkcv_valutazione` FOREIGN KEY (`valutazione_key`) REFERENCES `valutazione` (`primary_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella app.linkcv: ~0 rows (circa)
/*!40000 ALTER TABLE `linkcv` DISABLE KEYS */;
/*!40000 ALTER TABLE `linkcv` ENABLE KEYS */;

-- Dump della struttura di tabella app.linkha
CREATE TABLE IF NOT EXISTS `linkha` (
  `primary_key` int(11) NOT NULL AUTO_INCREMENT,
  `anno_corso` date DEFAULT NULL,
  `corsodilaurea_key` int(11) DEFAULT NULL,
  `corso_key` int(11) DEFAULT NULL,
  PRIMARY KEY (`primary_key`),
  KEY `corso_key` (`corso_key`),
  KEY `corsodilaurea_key` (`corsodilaurea_key`),
  CONSTRAINT `FK_linkha_corso` FOREIGN KEY (`corso_key`) REFERENCES `corso` (`primary_key`),
  CONSTRAINT `FK_linkha_corsodilaurea` FOREIGN KEY (`corsodilaurea_key`) REFERENCES `corsodilaurea` (`primary_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella app.linkha: ~0 rows (circa)
/*!40000 ALTER TABLE `linkha` DISABLE KEYS */;
/*!40000 ALTER TABLE `linkha` ENABLE KEYS */;

-- Dump della struttura di tabella app.linkiscritto
CREATE TABLE IF NOT EXISTS `linkiscritto` (
  `primary_key` int(11) NOT NULL AUTO_INCREMENT,
  `anno_iscrizione` int(11) DEFAULT NULL,
  `corsodilaurea_key` int(11) DEFAULT NULL,
  `studente_key` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`primary_key`),
  KEY `corsodilaurea_key` (`corsodilaurea_key`),
  KEY `studente_key` (`studente_key`),
  CONSTRAINT `FK_linkiscritto_corsodilaurea` FOREIGN KEY (`corsodilaurea_key`) REFERENCES `corsodilaurea` (`primary_key`),
  CONSTRAINT `FK_linkiscritto_studente` FOREIGN KEY (`studente_key`) REFERENCES `studente` (`matricola`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella app.linkiscritto: ~0 rows (circa)
/*!40000 ALTER TABLE `linkiscritto` DISABLE KEYS */;
/*!40000 ALTER TABLE `linkiscritto` ENABLE KEYS */;

-- Dump della struttura di tabella app.linkrv
CREATE TABLE IF NOT EXISTS `linkrv` (
  `primary_key` int(11) NOT NULL AUTO_INCREMENT,
  `recensione_key` int(11) DEFAULT NULL,
  `valutazione_key` int(11) DEFAULT NULL,
  PRIMARY KEY (`primary_key`),
  KEY `recensione_key` (`recensione_key`),
  KEY `valutazione_key` (`valutazione_key`),
  CONSTRAINT `FK__recensione` FOREIGN KEY (`recensione_key`) REFERENCES `recensione` (`primary_key`),
  CONSTRAINT `FK_valutazione` FOREIGN KEY (`valutazione_key`) REFERENCES `valutazione` (`primary_key`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella app.linkrv: ~0 rows (circa)
/*!40000 ALTER TABLE `linkrv` DISABLE KEYS */;
/*!40000 ALTER TABLE `linkrv` ENABLE KEYS */;

-- Dump della struttura di tabella app.linkscrive
CREATE TABLE IF NOT EXISTS `linkscrive` (
  `primary_key` int(11) NOT NULL AUTO_INCREMENT,
  `recensione_key` int(11) DEFAULT NULL,
  `studente_key` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`primary_key`),
  KEY `recensione_key` (`recensione_key`),
  KEY `studente_key` (`studente_key`),
  CONSTRAINT `FK_linkscrive_recensione` FOREIGN KEY (`recensione_key`) REFERENCES `recensione` (`primary_key`),
  CONSTRAINT `FK_linkscrive_studente` FOREIGN KEY (`studente_key`) REFERENCES `studente` (`matricola`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella app.linkscrive: ~0 rows (circa)
/*!40000 ALTER TABLE `linkscrive` DISABLE KEYS */;
/*!40000 ALTER TABLE `linkscrive` ENABLE KEYS */;

-- Dump della struttura di tabella app.linktiene
CREATE TABLE IF NOT EXISTS `linktiene` (
  `primary_key` int(11) NOT NULL AUTO_INCREMENT,
  `corso_key` int(11) DEFAULT NULL,
  `professore_key` int(11) DEFAULT NULL,
  PRIMARY KEY (`primary_key`),
  KEY `corso_key` (`corso_key`),
  KEY `professore_key` (`professore_key`),
  CONSTRAINT `FK_linktiene_corso` FOREIGN KEY (`corso_key`) REFERENCES `corso` (`primary_key`),
  CONSTRAINT `FK_linktiene_professore` FOREIGN KEY (`professore_key`) REFERENCES `professore` (`primary_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella app.linktiene: ~0 rows (circa)
/*!40000 ALTER TABLE `linktiene` DISABLE KEYS */;
/*!40000 ALTER TABLE `linktiene` ENABLE KEYS */;

-- Dump della struttura di tabella app.linkvp
CREATE TABLE IF NOT EXISTS `linkvp` (
  `primary_key` int(11) NOT NULL AUTO_INCREMENT,
  `valutazione_key` int(11) DEFAULT NULL,
  `professore_key` int(11) DEFAULT NULL,
  PRIMARY KEY (`primary_key`),
  KEY `valutazione_key` (`valutazione_key`),
  KEY `professore_key` (`professore_key`),
  CONSTRAINT `FK_linkvp_professore` FOREIGN KEY (`professore_key`) REFERENCES `professore` (`primary_key`),
  CONSTRAINT `FK_linkvp_valutazione` FOREIGN KEY (`valutazione_key`) REFERENCES `valutazione` (`primary_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella app.linkvp: ~0 rows (circa)
/*!40000 ALTER TABLE `linkvp` DISABLE KEYS */;
/*!40000 ALTER TABLE `linkvp` ENABLE KEYS */;

-- Dump della struttura di tabella app.professore
CREATE TABLE IF NOT EXISTS `professore` (
  `primary_key` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cognome` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`primary_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella app.professore: ~0 rows (circa)
/*!40000 ALTER TABLE `professore` DISABLE KEYS */;
/*!40000 ALTER TABLE `professore` ENABLE KEYS */;

-- Dump della struttura di tabella app.recensione
CREATE TABLE IF NOT EXISTS `recensione` (
  `primary_key` int(11) NOT NULL AUTO_INCREMENT,
  `testo` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `voto` int(11) NOT NULL,
  `risultato_key` int(11) DEFAULT NULL,
  PRIMARY KEY (`primary_key`) USING BTREE,
  KEY `risultato_key` (`risultato_key`) USING BTREE,
  CONSTRAINT `recensione_ibfk_1` FOREIGN KEY (`risultato_key`) REFERENCES `risultato` (`primary_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella app.recensione: ~0 rows (circa)
/*!40000 ALTER TABLE `recensione` DISABLE KEYS */;
/*!40000 ALTER TABLE `recensione` ENABLE KEYS */;

-- Dump della struttura di tabella app.risultato
CREATE TABLE IF NOT EXISTS `risultato` (
  `primary_key` int(11) NOT NULL AUTO_INCREMENT,
  `Appello` enum('Primo','Secondo') COLLATE utf8mb4_unicode_ci NOT NULL,
  `Sessione` enum('Invernale','Estiva','Settembre','Primavera','Autunno') COLLATE utf8mb4_unicode_ci NOT NULL,
  `Esonero` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`primary_key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella app.risultato: ~0 rows (circa)
/*!40000 ALTER TABLE `risultato` DISABLE KEYS */;
/*!40000 ALTER TABLE `risultato` ENABLE KEYS */;

-- Dump della struttura di tabella app.studente
CREATE TABLE IF NOT EXISTS `studente` (
  `nome` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cognome` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `matricola` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `email` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`matricola`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella app.studente: ~0 rows (circa)
/*!40000 ALTER TABLE `studente` DISABLE KEYS */;
/*!40000 ALTER TABLE `studente` ENABLE KEYS */;

-- Dump della struttura di tabella app.valutazione
CREATE TABLE IF NOT EXISTS `valutazione` (
  `primary_key` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`primary_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella app.valutazione: ~0 rows (circa)
/*!40000 ALTER TABLE `valutazione` DISABLE KEYS */;
/*!40000 ALTER TABLE `valutazione` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
