-- 1. Verkaufte Stueckzahlen (Quantity) pro ProduktKategorie (CategoryName) (8 Ergebniszeilen)
SELECT CategoryName, SUM(Quantity) FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
JOIN Categories ON Categories.CategoryID = Products.CategoryID
GROUP BY CategoryName

-- 2. Wieviele Bestellungen hat jeder Mitarbeiter bearbeitet? (9 Ergebniszeilen)
SELECT LastName, COUNT(OrderID) as Bestellungen FROM Employees
JOIN Orders ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY LastName
ORDER BY Bestellungen DESC

-- 3. Was war das meistverkaufte Produkt im Jahr 1998 (Productname)? Wieviel Stück (Quantity)?
SELECT TOP 1 ProductName, SUM(Quantity) as Verkaufsmenge FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON [Order Details].OrderID = Orders.OrderID
WHERE DATEPART(YEAR, OrderDate) = 1998
GROUP BY ProductName
ORDER BY Verkaufsmenge DESC

-- 4. In welcher Stadt (City) waren „Wimmers gute Semmelknödel“ am beliebtesten (Quantity)?
SELECT TOP 1 City, SUM(Quantity) as Verkaufsmenge FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
WHERE ProductName = 'Wimmers gute Semmelknödel'
GROUP BY City
ORDER BY Verkaufsmenge DESC

-- 5. Welcher Spediteur (Shippers) war durchschnittlich am günstigsten? (Freight)
SELECT TOP 1 CompanyName, AVG(Freight) as AvgFreight FROM Orders
JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
GROUP BY CompanyName
ORDER BY AvgFreight

-- 6. Jahrweiser Vergleich unserer 3. Spediteure: (Shippers Tabelle): 
-- Lieferkosten (Freight) gesamt, Durchschnitt (freight)
-- pro Lieferung und Anzahl an Lieferungen
-- Tables: Orders - Shippers
-- Aggregate: SUM, AVG, COUNT
-- DATEPART() benoetigt
/*
	Ergebnis in etwa so:
	SpediteurName, Geschäftsjahr, FreightGesamt, FreightAvg, AnzBestellungen
	Sped 1		 ,1996			, xy		   , xy		   , xy
	Sped 1		 ,1997			, xy		   , xy		   , xy
	Sped 1		 ,1998			, xy		   , xy		   , xy
	usw....
*/
SELECT CompanyName as SpediteurName,
DATEPART(YEAR, OrderDate) as GeschäftsJahr,
SUM(Freight) as FreightGesamt,
AVG(Freight) as FreightAvg,
COUNT(*) as AnzBestellungen
FROM Shippers
JOIN Orders ON Orders.ShipVia = Shippers.ShipperID
GROUP BY CompanyName, DATEPART(YEAR, OrderDate)
ORDER BY GeschäftsJahr, FreightAvg
