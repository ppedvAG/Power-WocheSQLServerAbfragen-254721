USE Northwind
-- String Funktionen bzw. Text-Datentypen manipulieren

-- LEN gibt die laenge des String zurück (Anzahl der Zeichen) als int
SELECT CompanyName, LEN(CompanyName) FROM Customers

-- LEFT/RIGHT geben die "linken" bzw "rechten" x Zeichen eines Strings zurueck
SELECT CompanyName, LEFT(CompanyName, 5) as LinkeSeite, RIGHT(CompanyName, 5) as RechteSeite FROM Customers

-- SUBSTRING(Spalte, Position, Zeichenausgabe) springt zur Position und gibt dann verschiedene Zeichen aus
SELECT CompanyName, SUBSTRING(CompanyName, 5, 5) FROM Customers

-- STUFF(Spalte, x, y, replace) ersetzt y Zeichen eines Strings ab Position x mit "replace Wert" (optional)
SELECT STUFF(Phone, LEN(Phone) - 4, 5, 'XXXXX') FROM Customers

-- PATINDEX sucht nach "Schema" (wie LIKE) in einem String und gibt Position aus 
-- an der das Schema das erste Mal gefunden wurde
SELECT PATINDEX('%m%', CompanyName), CompanyName FROM Customers

-- CONCAT fügt mehrere Strings in die selbe Spalte zusammen
SELECT CONCAT(FirstName, ' ', LastName) as 'Full Name' FROM Employees
SELECT FirstName + ' ' + LastName as FullName FROM Employees

-- Datumsfunktionen
SELECT GETDATE(), CURRENT_TIMESTAMP -- aktuelle Systemzeit mit Zeitstempel

SELECT Year(OrderDate) as Jahr, MONTH(OrderDate) as Monat, DAY(OrderDate) as Tag,
OrderDate from Orders

-- "Zieht" ein gewünschtes Intervall aus einem Datum
SELECT
DATEPART(YEAR, OrderDate) as Jahr,
DATEPART(QUARTER, OrderDate) as Quartal,
DATEPART(WEEK, OrderDate) as KW,
DATEPART(WEEKDAY, OrderDate) as Wochentag,
DATEPART(HOUR, OrderDate) as Stunde
FROM Orders

-- Zieht den Intervall Namen aus einem Datum
SELECT DATENAME(MONTH, OrderDate), DATENAME(WEEKDAY, OrderDate),
DATEPART(WEEKDAY, OrderDate), OrderDate FROM Orders

-- Intervall zu einem Datum addieren/subtrahieren
SELECT DATEADD(DAY, 14, GETDATE())
SELECT DATEADD(DAY, -14, GETDATE())

-- Differenz in Intervall zwischen 2 Datum
SELECT DATEDIFF(YEAR,'13.02.2005', GETDATE()), GETDATE()
SELECT DATEDIFF(YEAR, OrderDate, GETDATE()), OrderDate FROM Orders
----------------------------------------------------------------------

-- CAST oder Convert, wandeln Datentypen in der Ausgabe um
-- konvertierung von datetime => date
SELECT CAST(OrderDate as date), OrderDate FROM Orders
SELECT CONVERT(date, OrderDate) FROM Orders

-- ISNULL prüft auf NULL Werte und ersetzt diese wenn gewünscht
SELECT ISNULL(Fax, 'Nicht vorhanden!') as KeineFax, Fax FROM Customers

-- Datumskonvertierung
DECLARE @d AS DATE = '08/09/2024';

SELECT FORMAT(@d, 'd', 'en-US') AS 'US English',
       FORMAT(@d, 'd', 'en-gb') AS 'British English',
       FORMAT(@d, 'd', 'de-de') AS 'German',
       FORMAT(@d, 'd', 'zh-cn') AS 'Chinese Simplified (PRC)';

SELECT FORMAT(@d, 'D', 'en-US') AS 'US English',
       FORMAT(@d, 'D', 'en-gb') AS 'British English',
       FORMAT(@d, 'D', 'de-de') AS 'German',
       FORMAT(@d, 'D', 'zh-cn') AS 'Chinese Simplified (PRC)';

SELECT FORMAT(OrderDate, 'D', 'en-US'), OrderDate FROM Orders

-- Zahlen formatieren
SELECT TOP 5 Freight,
	FORMAT(Freight, 'N', 'de-de'), -- Numeric Format
	FORMAT(Freight, 'G', 'de-de'), -- Global Format
	FORMAT(Freight, 'C', 'de-de')  -- Currency Format
FROM Orders

-- REPLACE(x, y, z) => "y" sucht in "x" den String um Ihn mit "z" zu ersetzen
SELECT REPLACE('Hallo Welt!', 'Welt!', 'und Willkommen!')

-- REPLICATE(x, y) => Setze "y" mal die "x" vor der Spalte Phone
SELECT REPLICATE('0', 3) + Phone FROM Customers
SELECT '000' + Phone FROM Customers

-- REVERSE(Spaltenname) => z.B "Hallo" wird "ollaH"
SELECT CompanyName, REVERSE(CompanyName) FROM Customers

-- UPPER(Spaltenname) => alles in Großbuchstaben
SELECT CompanyName, UPPER(CompanyName) FROM Customers

-- LOWER(Spaltenname) => alles in Kleinbuchstaben
SELECT CompanyName, LOWER(CompanyName) FROM Customers

-- TRANSLATE(inputString, chars, replace)
-- => Gebe deinen InputString an, wähle die "chars" aus, die im "inputString" ersetzt werden sollen mit "replace"
SELECT TRANSLATE('2*[3+4]/{7-2}', '[]{}', '()()')