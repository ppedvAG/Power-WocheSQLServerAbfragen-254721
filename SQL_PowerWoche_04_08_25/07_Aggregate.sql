USE Northwind

-- Aggregatfunktionen: Führt eine Berechnung auf einer Menge von Werten durch und gibt einen einzigen Wert zurück
-- Ausnahme: COUNT(*) ignoriert keine NULL Werte, Aggregatfunktionen schon

SELECT
SUM(Freight) as Summe,
MIN(Freight) as Minimum,
MAX(Freight) as Maximum,
AVG(Freight) as Durschnitt,
COUNT(ShippedDate) as ZähleSpalte, COUNT(*) as ZähleAlles
FROM Orders

-- AVG selber berechnen
SELECT SUM(Freight) / COUNT(*) FROM Orders

SELECT CustomerID, SUM(Freight) FROM Orders
-- Lösung über GROUP BY:
/*
	- GROUP BY - Fasst mehrere Werte in Gruppen zusammen
*/

-- Freight Summe pro CustomerID
SELECT CustomerID, Freight FROM Orders
ORDER BY CustomerID

-- Lösung GROUP BY
SELECT CustomerID, SUM(Freight) FROM Orders
GROUP BY CustomerID

-- Quantity Summe pro ProductName
-- Products - Order Details
SELECT ProductName, SUM(Quantity) as SummeStueckzahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
GROUP BY ProductName

-- Quantity Summe pro ProductName für Produkte der Kategorien 1-4
SELECT ProductName, SUM(Quantity) as SummeStueckzahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE CategoryID IN (1,2,3,4)
GROUP BY ProductName
ORDER BY SummeStueckzahl DESC
 
 -- Verkaufte Stueckzahlen pro Produkt, aber nur die ueber 1000
SELECT ProductName, SUM(Quantity) as SummeStueckzahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE CategoryID IN (1,2,3,4)
GROUP BY ProductName
ORDER BY SummeStueckzahl DESC

-- Having funktioniert 1zu1 wie WHERE, kann aber gruppierte/aggregierte Werte nachtraeglich filtern
SELECT ProductName, SUM(Quantity) as SummeStueckzahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE CategoryID IN (1,2,3,4)
GROUP BY ProductName
HAVING SUM(Quantity) > 1000
ORDER BY SummeStueckzahl DESC