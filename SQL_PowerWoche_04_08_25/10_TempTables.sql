USE Northwind

-- Temporäre Tabellen

/*
	- SELECT INTO #TableName => Ergebnisse werden in eine Temporäre Tabelle geschrieben
	- existiert nur innerhalb meiner Session (Skriptfenster / Abfragefenster)
	- werden in Systemdatenbanken => tempdb => Temporäre Tabellen gespeichert
	- Ergebnisse werden nur einmal generiert --> TempTables sehr schnell aber nicht aktuell
	- mit einem # = "lokal" => nur im Abfragefenster selbst wo sie erstellt wurde
	- mit zwei ## = "global" => In jedem Abfragefenster verfügbar

*/

-- Erstellen
SELECT * INTO #TempTable
FROM Customers
WHERE Country = 'Germany'

-- Temporäre Tabelle aufrufen
SELECT * FROM #TempTable

-- manuell löschen
DROP TABLE #TempTable

-- globale Temp Table:
SELECT * INTO ##TempTable
FROM Customers
WHERE Country = 'Germany'

--1. Hat „Andrew Fuller“ (Employee) schonmal Produkte der Kategorie 
--„Seafood“ (Categories) verkauft?
--Wenn ja, wieviel Lieferkosten sind 
--dabei insgesamt entstanden (Freight)?
--Das ganze mit Temporaere Tabellen machen
-- Tabellen: Orders - Employees - [Order Details] - Products - Categories
SELECT SUM(Freight) as Lieferkosten 
INTO #Lieferkosten
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON Products.ProductID = [Order Details].ProductID
JOIn Categories ON Categories.CategoryID = Products.CategoryID
WHERE Employees.LastName = 'Fuller' AND Categories.CategoryName = 'Seafood'

SELECT * FROM #Lieferkosten