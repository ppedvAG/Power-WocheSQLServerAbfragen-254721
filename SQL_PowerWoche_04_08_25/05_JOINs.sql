USE Northwind

-- Die Customers und Orders Tabelle in einem Ergebnisfenster joinen

/*
	SELECT * FROM Tabelle A
	INNER JOIN Tabelle B ON A.KeySpalte = B.KeySpalte
*/

SELECT * FROM Orders
INNER JOIN Customers ON Customers.CustomerID = Orders.CustomerID

SELECT Orders.CustomerID, Customers.CustomerID FROM Orders
JOIN Customers ON Customers.CustomerID = Orders.CustomerID

SELECT CompanyName, ContactName, Ord.* FROM Customers as cus
JOIN Orders as Ord ON cus.CustomerID = Ord.CustomerID

-- Customers - Orders - Order Details
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID

-- OUTER Joins

-- LEFT Join:
SELECT * FROM Orders
LEFT JOIN Customers ON Orders.CustomerID = Customers.CustomerID

-- RIGHT Join: Z. 189 & 502
-- Kunden ohne Bestellungen
SELECT * FROM Orders
RIGHT JOIN Customers ON Orders.CustomerID = Customers.CustomerID

-- FULL OUTER Join:
SELECT * FROM Orders
FULL OUTER JOIN Customers ON Orders.CustomerID = Customers.CustomerID

-- Invertieren = gegenfall
SELECT * FROM Orders
FULL OUTER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Orders.OrderID IS NULL OR Customers.CustomerID IS NULL

-- CROSS JOIN: Erstellt karthesisches Produkt zweier Tabellen (A x B) 91 x 830
SELECT * FROM Orders CROSS JOIN Customers

-- SELF JOIN
SELECT E1.EmployeeID, E1.LastName as Vorgesetzer, E2.EmployeeID, E2.LastName as Angestellter
FROM Employees as E1
JOIN Employees as E2 ON E1.EmployeeID = E2.ReportsTo
