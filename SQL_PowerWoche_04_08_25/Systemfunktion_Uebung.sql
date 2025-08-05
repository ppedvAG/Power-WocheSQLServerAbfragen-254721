-- Übungen:
-- 1. Alle Bestellungen (Orders) aus Q2 in 1997
SELECT * FROM Orders
WHERE DATEPART(YEAR, OrderDate) = 1997 AND DATEPART(QUARTER,OrderDate) = 2

-- 2. Alle Produkte (ProductName) die um Weihnachten herum (+-10 Tage) in
-- 1996 verkauft wurden 
SELECT ProductName FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE OrderDate BETWEEN '14.12.1996' AND '03.01.1997'

-- 3. Alle Bestellungen (Orders) aus den USA (Customers Country) die im Jahr 1997 aufgegeben wurden
--> Customers - Orders
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'USA' AND DATEPART(YEAR, OrderDate) = 1997

--4. Welches Produkt (ProductName) hatte die groeßte Bestellmenge (Quantity in OD) im Februar 1998?
SELECT TOP 1 ProductName FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE DATEPART(YEAR, OrderDate) = 1998 AND DATEPART(MONTH, OrderDate) = 2
ORDER BY Quantity DESC

--5. Wieviele Bestellungen kamen aus Spain (Customers) in Quartal 2 1997?
--   Sind es mehr oder weniger als aus Frankreich? (2. Abfragen oder in 1 Möglich)

-- Espaniola
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'Spain' AND DATEPART(QUARTER, OrderDate) = 2 AND
DATEPART(YEAR, OrderDate) = 1997
UNION
-- France
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'France' AND DATEPART(QUARTER, OrderDate) = 2 AND
DATEPART(YEAR, OrderDate) = 1997

--6. Gab es Bestellungen (OrderID) an Wochenendtagen (OrderDate)?
SELECT OrderID, DATEPART(WEEKDAY, OrderDate) as Wochentag FROM Orders
WHERE DATEPART(WEEKDAY, OrderDate) IN (6, 7)
ORDER BY Wochentag DESC


-- 7. Hatten wir Bestellungen, die wir zu spaet ausgeliefert haben? Wenn 
-- ja, welche OrderIDs waren das und wieviele Tage
-- waren wir zu spaet dran? (Verzoegerung = Unterschied zwischen Shipped 
-- & Required Date in Orders) Tipp: DATEDIFF & ISNULL
-- ISNULL prueft auf Null Werte und ersetzt diese wenn gewuenscht
-- SELECT ISNULL(Fax, 'Nicht vorhanden!') as KeineFax, Fax FROM Customers
/* 37
OrderID, "TageZuSpaet"
OrderID, "TageZuSpaet"
OrderID, "TageZuSpaet"
usw...
*/
SELECT OrderID, DATEDIFF(DAY, RequiredDate, ISNULL(ShippedDate, GETDATE())) as TageVerzoegerung
FROM Orders
WHERE DATEDIFF(DAY, RequiredDate, ISNULL(ShippedDate, GETDATE())) > 0
ORDER BY TageVerzoegerung DESC

-- 8. „Zensiere“ alle Telefonnummern der Kunden (Phone): 
-- Es sollen immer nur noch die letzten 4 Ziffern/Symbole angezeigt werden. 
-- Alles davor soll mit einem X pro Symbol ersetzt werden.
-- Beispiel: Phone „08677 9889 0“; danach „XXXXXXXX89 0“
SELECT REPLICATE('X', LEN(Phone) - 4) + RIGHT(Phone, 4) as NeueNummer FROM Customers
SELECT STUFF(Phone, 1, LEN(Phone) - 4, REPLICATE('X', LEN(Phone) - 4)) FROM Customers