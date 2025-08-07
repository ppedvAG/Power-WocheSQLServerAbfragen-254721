/*
	Normalerweise:
	1. Jede Zelle einen Wert haben soll
	2. Jeder Datensatz sollte einen Primärschlüssel haben
	3. Keine Beziehungen zwischen nicht-Schlüssel Spalten

	Redundanz verringern (Daten nicht doppelt speichern)
	- Weniger Speicherbedarf
	- Keine Inkonsistenz -> Doppelte können nicht unterschieden werden
	- Beziehung zwischen Tabellen
	- Große Tabelle in kleiner Tabellen aufteilen
*/

/*
	Seite:
	8192 Bytes (8kB) Größe
	8060 Bytes tatsächliche Daten
	132 Bytes für management Daten
	8 Seiten = 1 Block

	Max. 700 DS pro Seite
	Datensätze müssen komplett auf eine Seite passen
	Leerer Raum darf existieren, muss aber minimiert werden
*/

-- dbcc: Database Console Commands
-- showcontig: Zeigt Seiteninformatioen über ein Datenbankobjekt -> Seitendichte messen

-- Messungen
SET STATISTICS time, IO ON
-- Anzahl der Seiten, Dauer in MS von CPU und Gesamtausführungzeit

-- Ausführungsplan: Routenplan für meine Abfrage

CREATE DATABASE Demo6

USE Demo6

-- Ineffiziente Tabelle (gewollt)
CREATE TABLE M001_Test1
(
	id int identity,
	test char(4100)
)

INSERT INTO M001_Test1
VALUES('XYZ')
GO 20000

-- dbcc
dbcc showcontig('M001_Test1') -- Seiten: 20000 => 50,79% Seitendichte
dbcc showcontig('Orders') -- Seiten: 20 => 98,19% Seitendichte

---------------------------------------
CREATE TABLE M001_Test2
(
	id int identity,
	test varchar(4100)
)

INSERT INTO M001_Test2
VALUES ('XYZ')
GO 20000

-- 700 DS Limit getroffen 

dbcc showcontig('M001_Test2') -- Seiten: 52 => Seitendichte: 95%

--------------------------------------
CREATE TABLE M001_Test3
(
	id int identity,
	test nvarchar(MAX)
)

INSERT INTO M001_Test3
VALUES ('XYZ')
GO 20000

dbcc showcontig('M001_Test3') -- Seiten: 60 => Seitendichte: 94,70%

USE Northwind

-- alle DS der Tabelle Orders aus dem Jahr 1997 (OrderDate)
-- 3 Abfragen dazu haben
SET STATISTICS TIME, IO ON

-- am schnellsten
-- logische Lesevorgänge: 22, CPU-Zeit: 0ms, verstrichene Zeit = 57ms
SELECT * FROM Orders WHERE OrderDate LIKE '%1997%'

-- am langsamsten
-- logische Lesevorgänge: 22, CPU-Zeit: 0ms, verstrichene Zeit = 81ms
SELECT * FROM Orders WHERE OrderDate BETWEEN '01.01.1997' AND '31.12.1997 23:59:59.997'

-- auch etwas langsam
-- logische Lesevorgänge: 22, CPU-Zeit: 0ms, verstrichene Zeit = 75ms
SELECT * FROM Orders WHERE YEAR(OrderDate) = 1997

-- zweitschnellste
-- logische Lesevorgänge: 22, CPU-Zeit: 0ms, verstrichene Zeit = 62ms
SELECT * FROM Orders WHERE DATEPART(YEAR, OrderDate) = 1997

-- Statistiken für Zeit und Lesevorgänge aktivieren/deaktivieren
SET STATISTICS TIME, IO OFF

-- sys.dm_db_index_physical_stats: Gibt einen Gesamtüberblick über die Seiten der Datenbank
SELECT OBJECT_NAME(OBJECT_ID), *
FROM sys.dm_db_index_physical_stats(DB_ID(),0, -1, 0, 'DETAILED')

-- 70% Seitendichte = Ok
-- 80% Seitendichte = Gut
-- 90% Seitendichte = Sehr gut

--> Weniger Seiten -> Weniger Daten laden --> bessere Performance

USE Demo6

CREATE TABLE M001_Float
(
	id int identity,
	zahl float
)

INSERT INTO M001_Float
VALUES(2.2)
GO 20000

dbcc showcontig('M001_Float') -- Seiten: 55, Seitendichte: 94,32%

-- Decimal
CREATE TABLE M001_Decimal
(
	id int identity,
	zahl decimal(2, 1)
)

INSERT INTO M001_Decimal
SELECT zahl FROM M001_Float

SELECT * FROM M001_Decimal

dbcc showcontig('M001_Decimal') -- Seiten: 45; Seitendichte: 98,81%

----------------------------
-- Schnellere Variante zum Tabellen befuellen
CREATE TABLE M001_Float2
(
	id int identity,
	zahl float
)

BEGIN TRAN
DECLARE @i int = 0
WHILE @i < 20000
BEGIN
	INSERT INTO M001_Float2 VALUES(2.2)
	SET @i += 1
END
COMMIT

