USE Northwind
GO -- Batchtrennzeichen => Abfragetrennstrich

/*
	Views: Erzeugt eine Virtuelle Tabelle, deren Inhalt durch eine Abfrage definiert wird

	Vorteile:
	- Um komplexere Abfragen zu speichern
	- Sicherheit: User erlauben nur die View zu lesen, aber nicht zu verändern
	- Views sind immer aktuell (aktuelel Daten)
		=> beim Aufruf einer View wird das hinterlegte Statement ausgeführt
*/

CREATE VIEW vRechnungsDaten AS
SELECT
Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName,
CAST(SUM((UnitPrice * Quantity) * (1 - Discount)) + Freight as decimal(10,2)) as SummeBestPosi 
FROM [Order Details]
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName
GO

-- Aufruf der View
SELECT * FROM vRechnungsDaten
GO


-- View loeschen
--DROP VIEW vRechnungsDaten

-- View abändern:
--ALTER VIEW vRechnungsDaten AS
--SELECT
--Orders.OrderID, 
--Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
--Orders.Freight, Orders.OrderDate,
--Employees.LastName,
--CAST(SUM((UnitPrice * Quantity) * (1 - Discount)) + Freight as decimal(10,2)) as SummeBestPosi 
--FROM [Order Details]
--JOIN Orders ON Orders.OrderID = [Order Details].OrderID
--JOIN Customers ON Customers.CustomerID = Orders.CustomerID
--JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
--GROUP BY Orders.OrderID, 
--Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
--Orders.Freight, Orders.OrderDate,
--Employees.LastName
--GO


-- 1. Wieviel Umsatz haben wir in jedem Geschäftsjahr insgesamt gemacht?
-- Benoetigt: SUM(SummeBestPosi)
-- View: vRechnungsDaten
-- => Ergebnis der Abfrage in eine View Speichern "vRechnungsDaten_Umsatz"
-- 1996	|	5000
CREATE VIEW vRechnungsDaten_Umsatz AS
SELECT TOP 3 DATEPART(YEAR, OrderDate) as GeschäftsJahr,
SUM(SummeBestPosi) as GesamtUmsatz FROM vRechnungsDaten
GROUP BY DATEPART(YEAR, OrderDate)
ORDER BY 1
GO

SELECT * FROM vRechnungsDaten_Umsatz