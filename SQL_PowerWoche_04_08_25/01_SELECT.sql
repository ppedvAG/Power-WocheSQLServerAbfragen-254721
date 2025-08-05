-- USE Datenbankname wechselt die angesprochene Datenbank
-- Alternativ "oben links" im Drop-Down Menü richtige DB auswählen
USE Northwind

-- einzeiliger Kommentar

/*
	Mehrzeiliger
	Kommentar
	block
*/

/*
	SELECT: wählt Spalten aus, die im Ergebnisfenster angezeigt werden sollen
	FROM: wählt die Tabelle aus 
*/

SELECT * FROM Customers -- * = alle Spalten in der angesprochenen Tabelle

-- "Custom" - Werte und mathematische Operationen ebenfalls nutzen

SELECT 100

SELECT 'Hallo', 100*5, 7 * 5 / 10

---------------------------------------
SELECT CompanyName, [Country] FROM [dbo].[Customers]

-- SQL ist nicht Case-Sensitive, Formatierung spielt keine Rolle
SeLeCt				cOuNtRY,

			ComPanYnAmE
	FrOm			CuStOmErS
---------------------------------------

-- Sortieren mit ORDER BY
SELECT * FROM Customers
ORDER BY City

-- Absteigend sortieren mit DESC
SELECT * FROM Customers
ORDER BY City DESC
-- ORDER BY ist syntaktisch immer am Ende
-- DESC = Descending = absteigend
-- ASC = Ascending = aufsteigend (default)

-- Auch mehrere Spalten gleichzeitig sortieren wollen
SELECT City, CompanyName FROM Customers
ORDER BY City DESC, CompanyName ASC

SELECT CompanyName, City, Country FROM Customers
ORDER BY 2 DESC
--------------------------------------

-- TOP X gibt nur die ersten X Zeilen aus
SELECT TOP 10 * FROM Customers
SELECT TOP 100 * FROM Customers

-- Geht auch mit %-Angabe
-- TOP X PERCENT
SELECT TOP 10 PERCENT * FROM Customers

-- Die 20 kleinsten Frachtwerte aus Orders raus
SELECT TOP 20 Freight FROM Orders
ORDER BY Freight ASC

-- Die 20 größten Frachtwerte aus Orders raus
SELECT TOP 20 Freight FROM Orders
ORDER BY Freight DESC

/*
	WICHTIG!: "BOTTOM" X existiert nicht, Ergebnisse einfach "umdrehen" mit ORDER BY
*/
-------------------------------------
-- Duplikate "filtern" mit SELECT DISTINCT
-- Filtert alle Ergebnisse/Datensätze deren Werte exakt gleich sind
-- DISTINCT sortiert automatisch aufsteigend

SELECT Country FROM Customers

SELECT DISTINCT Country FROM Customers

SELECT DISTINCT City, Country FROM Customers
-------------------------------------

-- UNION führt mehrere Ergebnistabellen vertikal in eine Tabelle zusammen
-- UNION macht automatisch ein DISTINCT mit
-- Spaltenanzahl muss gleich sein, Datentypen müssen kompatibel sein

SELECT * FROM Customers
UNION
SELECT * FROM Customers

-- mit UNION ALL wird KEIN DISTINCT ausgeführt
SELECT * FROM Customers
UNION ALL
SELECT * FROM Customers

-- Geht nicht
SELECT 100, 'Hallo'
UNION 
SELECT 'Test', 5, 10

-- Geht schon
SELECT 'Hallo', 100
UNION 
SELECT 'Test', 5

-- Wie kann ich des umbauen das es so klappt?
SELECT 'Test', '5'
UNION 
SELECT '100', 'Hallo'
--------------------------------------
-- Alias
-- Spalten "umbenennen" über Aliase bzw "as"
SELECT 100 as Zahl, 'Hallo' as Begrüßung
SELECT 100 Zahl, 'Hallo' Begrüßung
SELECT 100 as 'Das ist eine Zahl', 'Hallo' as 'Das ist eine Begrüßung'

SELECT City as Stadt FROM Customers

-- Aliase auch für unsere Tabellennamen vergeben
SELECT * FROM Customers AS Cus
