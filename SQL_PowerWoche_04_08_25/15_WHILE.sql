USE Northwind

-- Variablen allgemein

DECLARE @OrderID INT = 10250

SELECT * FROM Orders
WHERE OrderID = @OrderID

SET @OrderID = 10251

SELECT * FROM Orders
WHERE OrderID = @OrderID

----------------------------------------
-- WHILE - leitet eine Schleifenanweisung an


-- WHILE = Eine Schleife
DECLARE @Counter INT = 0

WHILE @Counter <= 5
BEGIN
SELECT 'Hallo'
SET @Counter += 1
END

-- Endlosschleife, aufpassen auf den Computer
WHILE 1=1
BEGIN
SELECT 'Hallo'
END


-- Zusätzliche IF Prüfung innerhalb der WHILE Schleife:
DECLARE @CounterTwo INT = 0

WHILE @CounterTwo <= 5
BEGIN
	IF @CounterTwo = 2
		BEGIN
			SELECT 'Bin bei 2' 
		END
	ELSE
		BEGIN 
			SELECT @CounterTwo 
		END
SET @CounterTwo += 1
END
SELECT 'Ende'