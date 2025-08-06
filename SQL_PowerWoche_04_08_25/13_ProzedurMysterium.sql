-- Versuch Nr.1
-- Eine Beliebige Variable mit VARCHAR(20) => Default Value muss Hoeher sein als 20 Zeichen
-- @CustomerID = char(5), @CompanyName von varchar(40)
-- @Country varchar(20), @City = varchar(30)
-- Default Wert benoetigt!!!, Country Default Wert muss die 20 Zeichenketten ueberschreiben
CREATE PROCEDURE sp_Test1
@CustomerID CHAR(5) = '12345', @CompanyName VARCHAR(40) = 'Testunternehmen',
@Country VARCHAR(20) = 'GermanyGermanyGermanyGermany', @City VARCHAR(30) = 'Berlin'
AS
INSERT INTO Customers (CustomerID, CompanyName, Country, City)
VALUES (@CustomerID, @CompanyName, @Country, @City)
GO

EXEC sp_Test1

SELECT * FROM Customers
GO
------------------------------------------
-- Versuch Nr.2
-- Keine Defaultwerte:
-- @CustomerID = char(5), @CompanyName von varchar 40
-- @Country varchar(20), @City = varchar(30)
-- Beim Exec muss der WERT größer sein als der Datentyp es zulässt
CREATE PROCEDURE sp_Test2
@CustomerID CHAR(5), @CompanyName VARCHAR(40),
@Country VARCHAR(20), @City VARCHAR(30)
AS
INSERT INTO Customers (CustomerID, CompanyName, Country, City)
VALUES (@CustomerID, @CompanyName, @Country, @City)
GO

EXEC sp_Test2 12345, TestUnternehmen, GermanyGermanyGermanyGermany, Berlin

SELECT * FROM Customers
GO
------------------------------------------
-- Versuch Nr.3
-- Keine Defaultwerte:
-- @CustomerID = char(5), @CompanyName von varchar 40
-- @Country varchar(10), @City = varchar(30)
-- Beim Exec muss der WERT größer sein als der Datentyp es zulässt
CREATE PROCEDURE sp_Test3
@CustomerID CHAR(5), @CompanyName VARCHAR(40),
@Country VARCHAR(10), @City VARCHAR(30)
AS
INSERT INTO Customers (CustomerID, CompanyName, Country, City)
VALUES (@CustomerID, @CompanyName, @Country, @City)
GO

EXEC sp_Test3 12345, TestUnternehmen, GermanyGermanyGermanyGermany, Berlin

SELECT * FROM Customers
GO

------------------------------------------
-- Versuch Nr.4
-- Defaultwerte:
-- @CustomerID = char(5), @CompanyName von varchar 40
-- @Country varchar(10), @City = varchar(30)
-- Beim Exec muss der WERT größer sein als der Datentyp es zulässt
CREATE PROCEDURE sp_Test4
@CustomerID CHAR(5) = '67890', @CompanyName VARCHAR(40) = 'Testunternehmen',
@Country VARCHAR(10) = 'GermanyGermanyGermanyGermany', @City VARCHAR(30) = 'Berlin'
AS
INSERT INTO Customers (CustomerID, CompanyName, Country, City)
VALUES (@CustomerID, @CompanyName, @Country, @City)
GO

EXEC sp_Test4

SELECT * FROM Customers
GO