-- phpMyAdmin SQL Dump
-- version 4.0.4.2
-- http://www.phpmyadmin.net
--
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `coko_kategorie`
--

DROP TABLE IF EXISTS `coko_kategorie`;
CREATE TABLE IF NOT EXISTS `coko_kategorie` (
  `id_kat` smallint(6) NOT NULL AUTO_INCREMENT,
  `nazov` varchar(100) COLLATE utf8_slovak_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_kat`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci AUTO_INCREMENT=6 ;

--
-- Sťahujem dáta pre tabuľku `coko_kategorie`
--

INSERT INTO `coko_kategorie` (`id_kat`, `nazov`) VALUES
(1, 'Pralinka horká'),
(2, 'Pralinka mliečna'),
(3, 'Pralinka biela'),
(4, 'Tvary'),
(5, 'Bonboniéra');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `coko_komentare`
--

DROP TABLE IF EXISTS `coko_komentare`;
CREATE TABLE IF NOT EXISTS `coko_komentare` (
  `id_koment` smallint(6) NOT NULL AUTO_INCREMENT,
  `uid` smallint(6) NOT NULL,
  `pid` smallint(6) NOT NULL,
  `komentar` text COLLATE utf8_slovak_ci NOT NULL,
  `cas` datetime NOT NULL,
  `stav` char(1) COLLATE utf8_slovak_ci NOT NULL DEFAULT 'x',
  PRIMARY KEY (`id_koment`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci AUTO_INCREMENT=12 ;

--
-- Sťahujem dáta pre tabuľku `coko_komentare`
--

INSERT INTO `coko_komentare` (`id_koment`, `uid`, `pid`, `komentar`, `cas`, `stav`) VALUES
(1, 1, 2, 'aaaach', '2019-05-25 00:19:35', 'x'),
(2, 3, 1, 'pokusný komentár', '2019-05-24 22:34:36', 'x'),
(3, 2, 2, 'wau, wau', '2019-05-24 00:00:00', 'x'),
(4, 2, 1, 'skúšam, či toto schváli admin ;-)', '2019-05-24 00:00:00', 'x'),
(5, 3, 1, 'toto je fakt super', '2019-05-24 22:40:07', 'a'),
(6, 2, 1, 'druhý pokus', '2019-05-24 00:00:00', 'x'),
(8, 2, 1, 'tretí pokus', '2019-05-25 00:19:35', 'x'),
(9, 2, 1, 'ďalší pokusný komentár na schválenie', '2019-05-24 22:51:00', 'x'),
(10, 2, 1, 'xxxxxx', '2019-05-24 22:58:19', 'x'),
(11, 2, 3, 'mňam', '2020-05-21 11:24:56', 'a'),
(12, 2, 3, 'tekutý je lepší ;-)', '2020-05-21 11:25:09', 'x'),
(14, 2, 2, 'čistý banán je lepší', '2020-05-25 18:15:42', 'x'),
(16, 1, 3, 'mňam', '2020-05-25 20:47:44', 'x'),
(17, 1, 3, 'mňam, mňam', '2020-05-25 20:47:51', 'x');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `coko_pouzivatelia`
--

DROP TABLE IF EXISTS `coko_pouzivatelia`;
CREATE TABLE IF NOT EXISTS `coko_pouzivatelia` (
  `uid` smallint(6) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) COLLATE utf8_slovak_ci NOT NULL DEFAULT '',
  `heslo` varchar(50) COLLATE utf8_slovak_ci NOT NULL DEFAULT '',
  `meno` varchar(20) COLLATE utf8_slovak_ci NOT NULL DEFAULT '',
  `priezvisko` varchar(30) COLLATE utf8_slovak_ci NOT NULL DEFAULT '',
  `admin` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci AUTO_INCREMENT=7 ;

--
-- Sťahujem dáta pre tabuľku `coko_pouzivatelia`
--

INSERT INTO `coko_pouzivatelia` (`uid`, `username`, `heslo`, `meno`, `priezvisko`, `admin`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'Administrátor', 'systému', 1),
(2, 'uwa', '78f0f32c08873cfdba57f17c855943c0', 'predmet', 'UWA', 0),
(3, 'roman', 'b179a9ec0777eae19382c14319872e1b', 'Roman', 'Hrušecký', 1),
(4, 'marek', 'e061c9aea5026301e7b3ff09e9aca2cf', 'Marek', 'Nagy', 0),
(5, 'jozko', '256f035bd7cf72238fad007fb9199c66', 'Jožko', 'Púčik', 0),
(6, 'mrkva', 'bfd7d9c62540ed72de0f32932077bef7', 'Janko', 'Mrkvička', 0);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `coko_produkty`
--

DROP TABLE IF EXISTS `coko_produkty`;
CREATE TABLE IF NOT EXISTS `coko_produkty` (
  `pid` smallint(6) NOT NULL AUTO_INCREMENT,
  `nazov` varchar(30) COLLATE utf8_slovak_ci NOT NULL,
  `popis` varchar(200) COLLATE utf8_slovak_ci NOT NULL,
  `cena` float NOT NULL,
  `foto` varchar(255) COLLATE utf8_slovak_ci NOT NULL,
  `id_kat` tinyint(4) NOT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci AUTO_INCREMENT=47 ;

--
-- Sťahujem dáta pre tabuľku `coko_produkty`
--

INSERT INTO `coko_produkty` (`pid`, `nazov`, `popis`, `cena`, `foto`, `id_kat`) VALUES
(1, 'Amaretto Truffle', 'čokoládovo-smotanová náplň s Amarettom', 2.62, 'amaretto_truffle.jpg', 1),
(2, 'Banán', 'fondán s banánovou príchuťou ', 2.62, 'banan.jpg', 1),
(3, 'Baylies', 'čokoládová náplň s Baylies', 2.62, 'baylies.jpg', 1),
(4, 'Diamant', 'horká čokoládová náplň', 2.82, 'diamant.jpg', 1),
(5, 'Golfová loptička', 'vanilková náplň s kokosom', 2.62, 'golfova_lopticka.jpg', 1),
(6, 'Manon', 'dvojvrstvový nugát', 2.62, 'manon.jpg', 1),
(7, 'Marcipánová mušlička', 'marcipán s Napoleonom', 2.62, 'marcipanova_muslicka.jpg', 1),
(8, 'Medailón', 'pepermintová náplň', 2.62, 'medailon.jpg', 1),
(9, 'Orechový krém', 'orieškový krém', 2.62, 'orechovy_krem.jpg', 1),
(10, 'Štvorlístok', 'kávová náplň', 2.62, 'stvorlistok.jpg', 2),
(11, 'Jazdecká čiapka', 'čokoládový krém s pomarančovou príchuťou', 2.62, 'jazdecka_ciapka.jpg', 2),
(12, 'Kávové zrno', 'kávová náplň', 2.62, 'kavove_zrno.jpg', 2),
(13, 'Motýlik', 'maslový krém s Cointreau likérom', 2.62, 'motylik.jpg', 2),
(14, 'Nugátový košíček', 'nugátová náplň s whisky', 2.62, 'nugatovy_kosicek.jpg', 2),
(15, 'Pistáciový marcipán', 'pistáciový marcipán', 2.62, 'pistaciovy_marcipan.jpg', 2),
(16, 'Smotanový slimák', 'nugát a smotanová náplň', 2.62, 'smotanovy_slimak.jpg', 2),
(17, 'Rumová vlnka', 'rumová náplň', 2.62, 'rumova_vlnka.jpg', 2),
(18, 'Trimandel', 'nugátová náplň s celou mandľou', 2.62, 'trimandel.jpg', 2),
(19, 'Biela káva', 'kávová náplň', 2.62, 'biela_kava.jpg', 3),
(20, 'Dary mora', 'nugátová náplň', 2.62, 'dary_mora.jpg', 3),
(21, 'Lemon ganache', 'ganache s citrónovou príchuťou ', 2.62, 'lemon_ganache.jpg', 3),
(22, 'Lieskáčik', 'orechová náplň s brandy', 2.62, 'lieskacik.jpg', 3),
(23, 'Malinová kytička', 'karamel s malinovou príchuťou', 2.62, 'malinova_kyticka.jpg', 3),
(24, 'Maliarska paleta', 'pomarančová náplň ', 2.62, 'maliarska_paleta.jpg', 3),
(25, 'Orechové srdiečko', 'lieskovo-oriešková náplň', 2.49, 'orechove_srdiecko.jpg', 3),
(26, 'Valencia', 'čokoládovo-smotanová náplň', 2.62, 'valencia.jpg', 3),
(27, 'Šampiňón', 'nugátová náplň', 2.62, 'sampinon.jpg', 3),
(28, 'Figúrky dino', 'horká, mliečna, biela', 2.62, 'figurky_dino.jpg', 4),
(29, 'Husle', 'náplň mix', 8.3, 'husle.jpg', 4),
(30, 'Hroch', 'mliečna čokoláda', 4.15, 'hroch.jpg', 4),
(31, 'Kopačka', 'náplň mix', 5.61, 'kopacka.jpg', 4),
(32, 'Košík veľký', 'náplň mix', 15.44, 'kosik_velky.jpg', 4),
(33, 'Mobil', 'náplň mix', 2.49, 'mobil.jpg', 4),
(34, 'Motorka', 'náplň mix', 3.65, 'motorka.jpg', 4),
(35, 'Panda', 'mix čokolád', 10.79, 'panda.jpg', 4),
(36, 'Korytnačka', 'mix čokolád', 6.61, 'korytnacka.jpg', 4),
(37, 'Veterán', 'náplň mix', 7.97, 'veteran.jpg', 4),
(38, 'Veselá krava', 'mix čokolád', 4.98, 'vesela_krava.jpg', 4),
(39, 'Črievička', 'náplň mix', 6.8, 'crievicka.jpg', 4),
(40, 'Psík', 'náplň mix', 4.95, 'psik.jpg', 4),
(41, 'MILKA - srdiečko', 'bonbóny z mliečnej čokolády plnené lieskovo-orieškovou náplňou', 3.29, 'milka-srdiecko.jpg', 5),
(42, 'Čokoládové pralinky', 'krásne zdobená plechová dóza s ručne pripravenými pralinkami', 6.61, 'cokoladove_pralinky.jpg', 5),
(43, 'Čokoládový mix', 'lahodné, ručne vyrábané pralinky podľa českej receptúry', 1.96, 'cokoladovy_mix.jpg', 5),
(44, 'MON CHÉRI - srdiečko', 'čokoládové bonbóny s likérovou náplňou a celou čerešňou', 3.29, 'mon_cheri-srdiecko.jpg', 5),
(45, 'Malý mls', 'krásne zdobená plechová dóza s ručne pripravenými pralinkami', 6.61, 'maly_mls.jpg', 5),
(46, 'Srdiečko', 'dóza s niekoľkými ručne pripravenými pralinkami', 5.61, 'srdiecko.jpg', 5);
