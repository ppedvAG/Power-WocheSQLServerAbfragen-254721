USE Northwind

-- LIKE: Für ungenaue Filterung/Suche
-- (statt Vergleichsoperatoren)

SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle LIKE 'Manager'

-- Wildcards
-- "%"-Zeichen: Beliebige Symbol, beliebig viele davon
SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle LIKE '%Manager%'

SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle LIKE '%Owner%'

-- "_"-Zeichen: EIN beliebiges Symbol
SELECT CompanyName FROM Customers
WHERE CompanyName LIKE '_l%'

-- "[]"-Zeichen: Alles in den Klammern ist ein gültiges Symbol
SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[012345]%'

-- "[a-z]" oder Gegenteil mit ^ [^a-z]
SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[0-5]%'

SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[^123]%'

SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[1-3 a-g]%'


-- Sonderfälle: % '
SELECT * FROM Customers
WHERE CompanyName LIKE '%['']%'

SELECT * FROM Customers
WHERE CompanyName LIKE '%[%]%'

-- 1. Alle ShipPostalCode's anzeigen lassen, die mit 0,2,4 beginnen
SELECT ShipPostalCode FROM Orders
WHERE ShipPostalCode LIKE '[024]%'