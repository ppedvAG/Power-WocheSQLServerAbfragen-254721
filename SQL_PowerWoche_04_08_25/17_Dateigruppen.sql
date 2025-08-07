/*
	Dateigruppen:
	Datenbank aufteilen auf mehrere Dateien, und verschiedene Datenträger in weiterer Folge
	[Primary]: Hauptgruppe, existiert immer, enthält standardmäßig alle Files

	Das Hauptfile hat die Endung .mdf
	Weitere Files haben die Endung .ndf
	Log Files haben die Endung .ldf
*/

USE Demo6

/*
	Rechtsklick auf die Datenbank => Eigenschaften
		Dateigruppen
			-Hinzufuegen => Name vergeben
		Dateien
			- Hinzufuegen => Name, Dateigruppe, Vergroeßerung, Pfad, Dateiname etc vergeben.
*/

CREATE TABLE M002_FG2
(
	id int identity,
	test char(4100)
)

INSERT INTO M002_FG2
VALUES ('XYZ')
GO 20000

SELECT * FROM M002_FG2

-- Wie verschiebe ich eine Tabelle auf eine andere Dateigruppe?
-- Neu erstellen, Daten verschieben, Alte löschen
CREATE TABLE M002_FG2_2
(
	id int identity(1, 1),
	test char(4100)
) ON [Aktiv]


INSERT INTO M002_FG2_2
SELECT * FROM M002_FG2

-- Identity bearbeiten per Designer
-- Extras -> Optionen -> Designer -> Speichern von Änderungen verhindern, die die Neuerstellung
--									 der Tabelle erfordern

SELECT * FROM M002_FG2_2

-- Salamitaktik
-- Große Tabellen in kleinere Tabellen aufteilen
-- Bonus: mit Partionierter Sicht

CREATE TABLE M002_Umsatz
(
	datum date,
	umsatz float
)

BEGIN TRAN
DECLARE @i INT = 0
WHILE @i < 100000
BEGIN
		INSERT INTO M002_Umsatz VALUES
		(DATEADD(DAY, FLOOR(RAND() * 1095), '01.01.2021'), RAND() * 1000)
		SET @i += 1
END
COMMIT

SELECT * FROM M002_Umsatz
ORDER BY datum DESC

/*
	Abfragepläne:
	Zeigt den genauen Ablauf einer Abfrage + Details an
	Aktivieren mit dem Button: "Tatsächlichen Ausführungsplan einschließen"
*/

SELECT * FROM M002_Umsatz
WHERE YEAR(datum) = 2021 -- Alle 100000 Zeilen müssen durchsucht werden
-----------------------------------------------------

CREATE TABLE M002_Umsatz2021
(
	datum date,
	umsatz float
)

INSERT INTO M002_Umsatz2021
SELECT * FROM M002_Umsatz WHERE YEAR(datum) = 2021

-----------------------------------------------------
CREATE TABLE M002_Umsatz2022
(
	datum date,
	umsatz float
)

INSERT INTO M002_Umsatz2022
SELECT * FROM M002_Umsatz WHERE YEAR(datum) = 2022
-----------------------------------------------------
CREATE TABLE M002_Umsatz2023
(
	datum date,
	umsatz float
)

INSERT INTO M002_Umsatz2023
SELECT * FROM M002_Umsatz WHERE YEAR(datum) = 2023
GO

-- Partitionierte View

CREATE View UmsatzGesamt
AS
SELECT * FROM M002_Umsatz2021
UNION ALL
SELECT * FROM M002_Umsatz2022
UNION ALL
SELECT * FROM M002_Umsatz2023


SELECT * FROM UmsatzGesamt
WHERE YEAR(datum) = 2021