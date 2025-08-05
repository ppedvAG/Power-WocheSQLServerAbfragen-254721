USE Northwind

-- WHERE: filtert Ergebniszeilen
SELECT * FROM Customers
WHERE Country = 'Germany'

-- = wird nach exakten Treffern gefiltert
SELECT * FROM Customers
WHERE Country = ' Germany'

SELECT * FROM Customers
WHERE Country = 'Germany '

SELECT * FROM Orders
WHERE Freight = 100

-- alle boolschen Vergleichsoperatoren verwenden
-- (=, <, >, >=, <=, != bzw. <>)

SELECT * FROM Orders
WHERE Freight > 500

SELECT * FROM Orders
WHERE Freight < 500

SELECT * FROM Customers
WHERE Country != 'Germany'


-- Kombinieren von WHERE Ausdrücken mit AND oder OR
SELECT * FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'

SELECT * FROM Customers
WHERE Country = 'Germany' OR City = 'Berlin'

-- AND = "Beide" Bedingungen müssen "wahr" sein (true oder 1)
-- OR = Ein Ausdruck muss wahr sein
-- Können beliebig oft kombiniert werden

-- Vorsicht bei Kombination aus AND und OR
SELECT * FROM Customers
WHERE (City = 'Paris' OR City = 'Berlin') AND Country = 'Germany'
-- AND "ist stärker bindent" als OR; Notfalls Klammern setzen!

SELECT * FROM Orders
WHERE Freight >= 100 AND Freight <= 500

-- Alternativ mit BETWEEN, Randwerte mit inbegriffen
SELECT * FROM Orders
WHERE Freight BETWEEN 100 AND 500

SELECT * FROM Customers
WHERE Country = 'Brazil' OR COuntry = 'Germany' OR Country = 'France'

-- Alternativ IN (Wert1, Wert2, Wert3)
SELECT * FROM Customers
WHERE Country IN ('Brazil', 'Germany', 'France')

-- IN verbindet mehrere OR Bedingungen die sich auf die Selbe Spalte beziehen

-- Übung:
---------------------------------------------------------
-- 1. Alle ContactNames die als Title "Owner" haben
SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle = 'Owner'

-- 2. Alle Order Details die ProductID 43 bestellt haben
SELECT * FROM [Order Details]
WHERE ProductID = 43

-- 3. Alle Kunden aus Paris, Berlin, Madrid und Brazilien
SELECT * FROM Customers
WHERE City IN ('Paris', 'Berlin', 'Madrid') OR Country = 'Brazil'

-- 4. Alle Kunden die eine Fax Nummer haben
SELECT * FROM Customers
WHERE FAX != 'NULL'

SELECT * FROM Customers
WHERE FAX IS NOT NULL

-- 5. Haben wir Produkteinheiten im Lager (UnitsInStock), die aber nicht
-- mehr verkauft werden (Discontinued)? Wenn ja, wieviel "Geld" liegt dort im Lager?
-- Rechnung: UnitsInStock * UnitPrice
SELECT ProductName, UnitsInStock * UnitPrice FROM Products
WHERE Discontinued = 1 AND UnitsInStock != 0
ORDER BY 2