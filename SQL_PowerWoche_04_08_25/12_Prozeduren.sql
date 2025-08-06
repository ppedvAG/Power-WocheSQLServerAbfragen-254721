USE Northwind
GO

-- Stored Procedures / gespeicherte Prozeduren

/*
	- Sind gespeicherte SQL Anweisungen (nicht nur SELECT, sondern auch alles andere)
	- Arbeiten mit Variablen
	- Praktisch zum "automatisieren" von Code
	- Prozeduren verwenden ihren Abfrageplan jedes mal wieder
*/

CREATE PROCEDURE spOrderID @OrderID INT
AS
SELECT * FROM Orders
WHERE OrderID = @OrderID

-- Prozedur ausfuehren
EXEC spOrderID 10253
GO

-- Zweite Prozedur
CREATE PROCEDURE spOrderIDZwei @OrderID INT, @OrderIDZwei INT
AS
SELECT * FROM Orders
WHERE OrderID = @OrderID
SELECT * FROM Orders
WHERE OrderID = @OrderIDZwei

EXEC spOrderIDZwei 10250, 10251
GO


--Eine Prozedur, welche neue Kunden hinzufügt
CREATE PROCEDURE spNewCustomer
@CustomerID CHAR(5), @CompanyName VARCHAR(40),
@Country VARCHAR(30), @City VARCHAR(30)
AS
INSERT INTO Customers (CustomerID, CompanyName, Country, City)
VALUES (@CustomerID, @CompanyName, @Country, @City)

EXEC spNewCustomer 'PPEDV', 'ppedv AG', 'Germany', 'Burghausen'
EXEC spNewCustomer LIDLI, LidlGmbH, Germany, Burghausen

SELECT * FROM Customers
GO


-- Default Werte
CREATE PROCEDURE spKundenNachLandCity
@Country VARCHAR(50) = 'Germany', @City VARCHAR(50) = 'Berlin'
AS 
SELECT * FROM Customers
WHERE Country = @Country AND City = @City

EXEC spKundenNachLandCity France, Paris
EXEC spKundenNachLandCity DEFAULT, Köln
GO

-- 1. Erstelle eine Procedure, der man als Parameter eine OrderID übergeben kann.
--Bei Ausführung soll der Rechnungsbetrag dieser Order ausgegeben werden 
-- SUM(Quantity * UnitPrice + Freight) = RechnungsSumme.
CREATE PROCEDURE sp_RechnungsSumme @OrderID INT
AS
SELECT Orders.OrderID, SUM(Quantity * UnitPrice + Freight) AS RechnungsSumme
FROM Orders JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
WHERE Orders.OrderID = @OrderID
GROUP BY Orders.OrderID

EXEC sp_RechnungsSumme 10250