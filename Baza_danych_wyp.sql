
IF EXISTS (SELECT * FROM sys.databases WHERE name= 'wypozyczalnia_plyt_winylowych')
DROP DATABASE wypozyczalnia_plyt_winylowych
GO

/* Tworzenie bazy danych wypozyczalnia_plyt_winylowych*/

CREATE DATABASE wypozyczalnia_plyt_winylowych
GO
USE wypozyczalnia_plyt_winylowych
GO 

/* Tworzenie poszczególnych tabel*/


/* 1)Tabela administrator */

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'administrator')
DROP TABLE administrator
GO 

CREATE TABLE administrator(
admin_id TINYINT IDENTITY (1,1) PRIMARY KEY,
data_dodania DATE NOT NULL,
pin INTEGER NOT NULL, 
);

/* 2)Tabela pracownik */

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'pracownik')
DROP TABLE pracownik
GO 

CREATE TABLE pracownik(
pracownik_id TINYINT IDENTITY (1,1) PRIMARY KEY,
data_zatrudnienia DATE NOT NULL,
pensja INTEGER NOT NULL,
PIN INTEGER NOT NULL
);

/* 3)Tabela klient */

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'klient')
DROP TABLE klient
GO 

CREATE TABLE klient(
klient_id INTEGER IDENTITY (1,1) PRIMARY KEY,
opis varchar(255) 
);


/* 4)Tabela miasto */

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'miasto')
DROP TABLE miasto
GO 

CREATE TABLE miasto(
miasto_id SMALLINT IDENTITY (1,1) PRIMARY KEY,
nazwa_miasta varchar(120) NOT NULL,
opis varchar(255) 
);

/* 5)Tabela adres */


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'adres')
DROP TABLE adres
GO

CREATE TABLE adres(
adres_id INTEGER IDENTITY(1,1) PRIMARY KEY,
ulica VARCHAR(120),
nr_domu VARCHAR(6) NOT NULL, 
nr_mieszkania VARCHAR(6),
opis VARCHAR(255),
kod_pocztowy VARCHAR(6) NOT NULL,
miasto_id SMALLINT NOT NULL REFERENCES  miasto(miasto_id)
);


/* 6)Tabela numer_tel */


IF EXISTS (SELECT* FROM sys.tables WHERE name = 'numer_tel')
DROP TABLE numer_tel
GO

CREATE TABLE numer_tel(
numer_tel_id INTEGER IDENTITY(1,1) PRIMARY KEY,
numer_tel_1 VARCHAR(13) NOT NULL,
numer_tel_2 VARCHAR(13),
numer_tel_3 VARCHAR(13)
);


/* 7)Tabela dane */


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'dane')
DROP TABLE dane
GO

CREATE TABLE dane(
dane_id INTEGER IDENTITY (1,1)  PRIMARY KEY,
imie VARCHAR(50) NOT NULL,
nazwisko VARCHAR(60) NOT NULL,
pesel CHAR(11) NOT NULL,
adres_id integer NOT NULL REFERENCES adres(adres_id),
numer_tel_id INTEGER NOT NULL REFERENCES numer_tel(numer_tel_id),
klient_id INTEGER REFERENCES klient(klient_id),
admin_id TINYINT REFERENCES administrator(admin_id),
pracownik_id TINYINT REFERENCES pracownik(pracownik_id)
);

/* 8)Tabela autorzy */


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'autorzy')
DROP TABLE autorzy
GO

CREATE TABLE autorzy(
autor_id INTEGER IDENTITY (1,1)  PRIMARY KEY,
imie_artysty VARCHAR(50),
nazwisko_artysty VARCHAR(60),
nazwa_zespolu VARCHAR(255)
);

/* 9)Tabela tytul */

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'tytul')
DROP TABLE tytul
GO

CREATE TABLE tytul(
tytul_id SMALLINT IDENTITY (1,1)  PRIMARY KEY,
tytul VARCHAR(150) NOT NULL,
data_premiery DATE NOT NULL,
cena FLOAT(5) NOT NULL,
ocena_albumu FLOAT(3) ,
opis VARCHAR(255),
admin_id TINYINT NOT NULL REFERENCES administrator(admin_id),
autor_id INTEGER NOT NULL  REFERENCES autorzy(autor_id)
);

/* 10)Tabela plyta */


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'plyta')
DROP TABLE plyta 
GO 

CREATE TABLE plyta(
plyta_id INTEGER IDENTITY (1,1)  PRIMARY KEY,
data_dodania date NOT NULL,
cena_zakupu FLOAT(5) NOT NULL,
opis VARCHAR(255),
tytul_id SMALLINT NOT NULL REFERENCES tytul(tytul_id),
admin_id TINYINT NOT NULL REFERENCES administrator(admin_id)
);

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'wypozyczenie')
DROP TABLE wypozyczenie 
GO 

/* 11)Tabela wypozyczenia */
CREATE TABLE wypozyczenie(
wypozyczenie_id INTEGER IDENTITY (1,1)  PRIMARY KEY,
data_wypozyczenia DATE NOT NULL,
data_oddania DATE,
cena_wypozyczenia FLOAT(5) NOT NULL,
liczba_dni_wyp INTEGER NOT NULL,
OCENA INTEGER ,
klient_id INTEGER NOT NULL REFERENCES klient(klient_id),
plyta_id INTEGER NOT NULL REFERENCES plyta(plyta_id),
admin_id TINYINT REFERENCES administrator(admin_id),
pracownik_id TINYINT REFERENCES pracownik(pracownik_id),
tytul_id SMALLINT REFERENCES tytul(tytul_id)
);


/* Polecenia INSERT*/

/* 1)Wprowadzanie danych do tabeli miasto */

--DELETE FROM miasto;

INSERT INTO miasto ( nazwa_miasta) VALUES
('Torzym'),
('Wroc³aw'),
('Szczecin'),
('Sulêcin'),
('Rzepin');

/* 2)Wprowadzanie danych do tabeli adres */

--DBCC CHECKIDENT (adres, RESEED,0);

--DELETE FROM adres;

INSERT INTO adres (ulica, nr_domu, kod_pocztowy, miasto_id) VALUES
('£agowska', 55,  '01-464', 1),
('Krakusa', 71,  '01-464', 1),
('Chêciñska', 84,  '01-464', 1),
('Cmentarna', 55,  '41-404', 2),
('Bogatyñska', 44,  '41-404', 2),
('Argentyñska ', 58,  '15-685', 3),
('Bacieczki', 113, '15-685', 3),
('¯egiestowska',114,  '50-542', 4),
('Kulmatyckiego W³odzimierza', 15,  '50-542', 4),
('Lenartowicza Aleksandra Teofila', 80,  '71-445', 5);




--DBCC CHECKIDENT (administrator, RESEED,0);

--DELETE FROM administrator;

INSERT INTO administrator(data_dodania, pin) VALUES
('2012-07-15', 1234),
('2019-07-1',4321);

--DBCC CHECKIDENT (pracownik, RESEED,0);

--DELETE FROM pracownik;

INSERT INTO pracownik (data_zatrudnienia, pensja, PIN) VALUES
('2012-07-23', 4321,2137),
('2022-03-10', 2234,9899);

--DBCC CHECKIDENT (numer_tel, RESEED,0);

--DELETE FROM numer_tel;

INSERT INTO numer_tel(numer_tel_1, numer_tel_2, numer_tel_3) VALUES
('123456789', NULL, NULL),
('123123123', '123456123', NULL),
('412214124', NULL, NULL),
('124214244', NULL, NULL),
('124214214', NULL, NULL),
('675675676', NULL, NULL),
('3453453454', NULL, NULL),
('3453454355', NULL, NULL),
('34543543522', NULL, NULL),
('23423432432', NULL, NULL);

--DBCC CHECKIDENT (klient, RESEED,0);

--DELETE FROM klient;

INSERT INTO klient(opis) VALUES
(NULL),
(NULL),
(NULL),
(NULL),
(NULL),
(NULL);

--DBCC CHECKIDENT (dane, RESEED,0);

--DELETE FROM dane;

INSERT INTO dane(imie, nazwisko, pesel, adres_id, numer_tel_id, klient_id, admin_id, pracownik_id) VALUES
('Alojzy', 'Kwiatkowski','19876543211',  1, 1, NULL, NULL, 1),
('Walenty ', 'Jasiñski','47040932515',  2, 2, NULL, NULL, 2),
('Wiktoria ', 'Gorska','63081979364',  3, 3, NULL, 1, NULL),
('Berta ', 'Sawicka','72080135488',  4, 4, NULL, 2, NULL),
('Oliwia ', 'Czarnecka','95122290529',  5, 5, 1, NULL, NULL),
('Hainrich ', 'Grabowski','76040953437',  6, 6, 2, NULL, NULL),
('Dyta ', 'Olszewska','87021182647',  7, 7, 3, NULL, NULL),
('Martyna ', 'Pawlak','49101840429',  8, 8, 4, NULL, NULL),
('Gracja ', 'Szczepañska','66081836981',  9, 9, 5, NULL, NULL),
('S³awomir ', 'Kowalski','51040552138',  10, 10, 6, NULL, NULL);


--DBCC CHECKIDENT (autorzy, RESEED,0);

--DELETE FROM autorzy;

INSERT INTO autorzy (imie_artysty, nazwisko_artysty, nazwa_zespolu) VALUES
('Kasper', 'Sobczak', null),
('Wiola ', 'Walczak', null),
(null, null, 'Stare Dobre Ma³¿eñstwo'),
(null, null, 'Metalica'),
(null, null, 'Sabaton');

--DBCC CHECKIDENT (tytul, RESEED,0);

--DELETE FROM tytul;

INSERT INTO tytul(tytul, data_premiery, cena, ocena_albumu, opis, admin_id, autor_id) VALUES
('Dwa latawce', '2020-06-22', 30, NULL, NULL,  1,1),
('Cztery sroki', '2011-07-11', 22, NULL, NULL, 1,2),
('Latawce dmuchawce wiatr', '2004-06-30',50,NULL,NULL, 2,3),
('Exit', '2012-12-11',33,NULL,NULL,1,4),
('Primo vicroria', '2004-10-15', 30,NULL,NULL,2,4);

--DBCC CHECKIDENT (plyta, RESEED,0);

--DELETE FROM plyta;

INSERT INTO plyta(data_dodania, cena_zakupu, opis, tytul_id, admin_id) VALUES
('2022-12-15', 55, NULL , 1,1),
('2022-04-15', 45, NULL , 2,1),
('2022-11-05', 16, NULL , 3,2),
('2022-04-19', 44, NULL , 1,1),
('2022-08-11', 37, NULL , 4,2),
('2022-10-04', 54, NULL , 4,1);

--DBCC CHECKIDENT (wypozyczenie, RESEED,0);

--DELETE FROM wypozyczenie;

INSERT INTO wypozyczenie(data_wypozyczenia, data_oddania, cena_wypozyczenia, liczba_dni_wyp, OCENA, klient_id, plyta_id, admin_id, pracownik_id, tytul_id) VALUES
('2022-12-07', NULL, 12, 64, NULL, 1, 1, NULL, 1,1),
('2022-12-08', NULL, 16, 34, NULL, 2, 2, NULL, 1,2),
('2022-12-09', NULL, 22, 23, NULL, 3, 3, NULL, 2,3),
('2022-12-10', NULL, 32, 43, NULL, 4, 4, NULL, 2,1),
('2022-12-01', NULL, 19, 54, NULL, 5, 5, NULL, 1,4);


INSERT INTO wypozyczenie(data_wypozyczenia, data_oddania, cena_wypozyczenia, liczba_dni_wyp, OCENA, klient_id, plyta_id, admin_id, pracownik_id, tytul_id) VALUES
('2022-12-07', NULL, 12, 64, NULL, 1, 1, NULL, 1,1),
('2022-12-08', NULL, 16, 34, NULL, 2, 1, NULL, 1,1);

--widok dane



IF EXISTS (SELECT * FROM sys.views WHERE name = 'Dane_wszystkie')
DROP VIEW Dane_wszystkie;
GO

CREATE VIEW Dane_wszystkie
AS 
SELECT dn.imie, dn.nazwisko, dn.pesel, dn.pracownik_id, dn.admin_id, dn.klient_id, ulica, ad.nr_domu, ad.nr_mieszkania, ad.kod_pocztowy, ms.nazwa_miasta
FROM dbo.dane dn LEFT JOIN dbo.adres ad
	ON dn.adres_id = ad.adres_id JOIN dbo.miasto ms
		ON ad.miasto_id = ms.miasto_id
GROUP BY dn.imie, dn.nazwisko, dn.pesel, dn.pracownik_id, dn.admin_id, dn.klient_id, ulica, ad.nr_domu, ad.nr_mieszkania, ad.kod_pocztowy, ms.nazwa_miasta
GO

--widok Dane wypozyczeñ klienta

IF EXISTS (SELECT * FROM sys.views WHERE name = 'Dane_wypozyczen_klienta')
DROP VIEW Dane_wypozyczen_klienta;
GO 

CREATE VIEW Dane_wypozyczen_klienta
AS 
SELECT kl.klient_id, da.imie, da.nazwisko, da.pesel, wy.data_wypozyczenia, ty.tytul, pl.plyta_id, wy.data_oddania, wy.cena_wypozyczenia, wy.liczba_dni_wyp,au.imie_artysty, au.nazwisko_artysty, au.nazwa_zespolu 
FROM klient kl LEFT JOIN wypozyczenie wy
	ON kl.klient_id = wy.klient_id
	JOIN dane da
	ON kl.klient_id = da.klient_id
	JOIN dbo.adres ad
	ON da.adres_id = ad.adres_id JOIN dbo.miasto ms
		ON ad.miasto_id = ms.miasto_id
	JOIN plyta pl
	ON wy.plyta_id = pl.plyta_id
	JOIN tytul ty
	ON pl.tytul_id = ty.tytul_id
	JOIN autorzy au
	ON  au.autor_id = ty.autor_id
GROUP BY kl.klient_id, da.imie, da.nazwisko, da.pesel, wy.data_wypozyczenia, ty.tytul, pl.plyta_id, wy.data_oddania, wy.cena_wypozyczenia, wy.liczba_dni_wyp,au.imie_artysty, au.nazwisko_artysty, au.nazwa_zespolu
GO
--Widok P³yty

IF EXISTS (SELECT * FROM sys.views WHERE name = 'Plyty')
DROP VIEW Plyty;
GO 

CREATE VIEW Plyty
AS 
SELECT au.imie_artysty, au.nazwisko_artysty, au.nazwa_zespolu, ty.tytul, ty.data_premiery, ty.cena, pl.plyta_id, pl.data_dodania, ty.opis
FROM plyta pl JOIN tytul ty
	ON pl.tytul_id = ty.tytul_id
	JOIN autorzy au
	ON  au.autor_id = ty.autor_id
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'wyswietl_adminow')
DROP PROC wyswietl_adminow
GO



--Wyswietlanie adminów

CREATE PROC wyswietl_adminow
AS
SELECT * FROM Dane_wszystkie
WHERE admin_id IS NOT NULL
GO

EXEC wyswietl_adminow

--Wyswietlanie pracowników


IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'wyswietl_pracownikow')
DROP PROC wyswietl_pracownikow
GO

CREATE PROC wyswietl_pracownikow
AS
SELECT * FROM Dane_wszystkie
WHERE pracownik_id IS NOT NULL
GO

EXEC wyswietl_pracownikow

--Wyswietlanie klientow z aktywnym wypozyzceniem

IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'klient_akt_wyp')
DROP PROC klient_akt_wyp
GO

CREATE PROC klient_akt_wyp
AS
SELECT * FROM Dane_wypozyczen_klienta
WHERE data_oddania is NULL
EXEC klient_akt_wyp
GO

EXEC klient_akt_wyp
GO


CREATE PROCEDURE search_tytul_id @myID int
AS
BEGIN

	SELECT tytul_id
	FROM tytul
	WHERE tytul_id = (SELECT tytul_id 
					  FROM plyta
					  WHERE plyta_id = (SELECT plyta_id
										FROM wypozyczenie
										WHERE wypozyczenie_id = @myID))
END
GO

EXEC search_tytul_id 1
--INDEXY

CREATE INDEX imie_nazwisko
ON dane (imie, nazwisko)
GO
--DROP INDEX dane.imie_nazwisko

CREATE INDEX imie_nazwisko_artysty
ON autorzy (imie_artysty,nazwisko_artysty)
GO
--DROP INDEX autorzy.imie_nazwisko_artysty

CREATE INDEX nazwy_zespolu
ON autorzy (nazwa_zespolu)
GO
--DROP INDEX autorzy.nazwy_zespolu

CREATE INDEX tytuly
ON tytul (tytul)
GO
--DROP INDEX tytul.tytuly

CREATE UNIQUE INDEX pesel
ON dane (pesel)
GO
--DROP INDEX dane.pesel

CREATE TRIGGER upd_ocena_albumu1
ON wypozyczenie
AFTER   UPDATE 
AS 
BEGIN 
	IF UPDATE(OCENA) 
	BEGIN
	UPDATE tytul
	SET ocena_albumu = (SELECT AVG (ocena) FROM wypozyczenie WHERE wypozyczenie.tytul_id=tytul.tytul_id)
	END
END
--DROP TRIGGER upd_ocena_albumu1


SELECT * FROM tytul

UPDATE wypozyczenie
SET OCENA = 2
WHERE wypozyczenie_id = 8
UPDATE wypozyczenie
SET OCENA = 3
WHERE wypozyczenie_id = 9


SELECT imie, nazwisko, pesel, klient_id, ulica, nr_domu, nr_mieszkania, kod_pocztowy, nazwa_miasta FROM Dane_wszystkie WHERE klient_id IS NOT NULL

