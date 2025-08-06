USE Northwind

-- Subqueries / Unterabfragen / Nested Queries

/*
	
*/

-- Zeige mir alle Orders an, deren Freight Wert über dem Durchschnitt liegt
SELECT * FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders)

SELECT * FROM Orders
WHERE Freight > 78.2442

-- Mehrere Werte aus einer Subquery in WHERE haben, mit IN kombiniert
SELECT * FROM Orders
WHERE Freight IN (SELECT TOP 10 Freight FROM Orders)

-- 1. Schreiben Sie eine Abfrage, um eine Produktliste 
--(ID, Name, Stückpreis) mit einem überdurchschnittlichen Preis zu erhalten
SELECT ProductID, ProductName, UnitPrice FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)
ORDER BY UnitPrice
