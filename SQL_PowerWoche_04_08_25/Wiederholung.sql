-- 1. Ist der Spediteur „Speedy Express“ 
-- über die Jahre durchschnittlich teurer geworden? (Freight pro Jahr)
SELECT CompanyName, DATEPART(YEAR, OrderDate) as Geschäftsjahr, AVG(Freight) as Durchschnitt
FROM Orders JOIN Shippers
ON Orders.ShipVia = Shippers.ShipperID
WHERE CompanyName = 'Speedy Express'
GROUP BY CompanyName, DATEPART(YEAR, OrderDate)

-- 2. Erstellen Sie einen Bericht, der die Gesamtzahl der 
-- Bestellungen nach Kunde seit dem 31. Dezember 1996 anzeigt. 
-- Der Bericht sollte nur Zeilen zurückgeben, 
-- für die die Gesamtzahl der Aufträge größer als 15 ist (5 Zeilen)
SELECT CustomerID, COUNT(OrderID) FROM Orders
WHERE OrderDate > '31.12.1996'
GROUP BY CustomerID
HAVING COUNT(OrderID) > 15
ORDER BY 2

-- 3. Wieviel Umsatz haben wir in Q1 1998 mit Kunden aus den USA gemacht? (vRechnungsDaten)
SELECT SUM(SummeBestPosi) as GesamtUmsatz FROM vRechnungsDaten
WHERE Country = 'USA' AND DATEPART(YEAR, OrderDate) = 1998 AND DATEPART(QUARTER, OrderDate) = 1

