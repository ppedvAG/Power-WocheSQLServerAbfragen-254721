USE Northwind

-- CREATE / ALTER / DROP -- DDL (Data Definition Language)
-- INSERT / UPDATE / DELETE => Inhaltsoptimierung

-- Immer wenn wir Datenbankobjekte "bearbeiten" gelten diese Befehle

CREATE TABLE PurchasingOrders
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	OrderDate DATE NOT NULL,
	ProductID INT NOT NULL
)

-- Beziehung zwischen PurchasingOrders und Products anlegen über ProductID
ALTER TABLE PurchasingOrders
ADD FOREIGN KEY (ProductID) REFERENCES Products (ProductID)

-- Neue Spalte hinzufügen zu bestehender Tabelle:
ALTER TABLE PurchasingOrders
ADD TestDaten INT

SELECT * FROM PurchasingOrders

-- Spalte aus bestehender Tabelle löschen
ALTER TABLE PurchasingOrders
DROP COLUMN NeueSpalte

-- Spalte nach Datentyp ändern:
ALTER TABLE PurchasingOrders
ALTER COLUMN TestDaten FLOAT NULL

-----------------------------------------------------
-- INSERT - Hinzufügen von Datensätze

-- Alle Spalten befuellen
INSERT INTO PurchasingOrders
VALUES (GETDATE(), 5, 20.25)

SELECT * FROM PurchasingOrders

-- Explizit einzelne Spalten befuellen
INSERT INTO PurchasingOrders
(OrderDate, ProductID) VALUES(GETDATE(), 10)

-- Ergebnis einer SELECT-Abfrage können direkt Inserted werden
-- (Wenn Spaltenanzahl passt & Datentypen kompatibel sind)
INSERT INTO PurchasingOrders
SELECT GETDATE(), 3, NULL

------------------------------------------------------------
-- DELETE - Löschen von Datensätzen in einer Bestehenden Tabelle

SELECT * FROM PurchasingOrders

-- Aufpassen!  Ohne Where Filter werden ALLE Datensätze gelöscht
DELETE FROM PurchasingOrders
WHERE ID = 4

-- Primaer-/Fremdschlüsselbeziehungen verhindern das loeschen von Datensaetzen, wenn andere Datensaetze
-- sonst "ins Leere laufen wuerden"
DELETE FROM Customers
WHERE CustomerID = 'ALFKI'

--1. Trage dich selber in die Tabelle ein (Employees). Bei den folgenden Spalten: 
--LastName, FirstName, Title, TitleOfCourtesy, BirthDate, 
--HireDate, City, Region, PostalCode, Country, HomePhone, ReportsTo


-- UPDATE - Ändern von Spaltenwerten in einem vorhandenen Datensatz
SELECT * FROM PurchasingOrders

UPDATE PurchasingOrders
SET TestDaten = 9
WHERE ID = 5

-- Löschen von Werten: SET = NULL?
UPDATE PurchasingOrders
SET TestDaten = NULL
WHERE ID = 5


----------------------
-- Transactions

BEGIN TRANSACTION

UPDATE PurchasingOrders
SET TestDaten = 5
WHERE ID = 5

COMMIT		-- => Tut die Änderung übernehmen
ROLLBACK	-- => Tut die Änderung zurücksetzen

SELECT * FROM PurchasingOrders



