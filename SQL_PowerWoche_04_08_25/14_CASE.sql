USE Northwind

-- CASE - unterscheiden wir definierte F�lle, die die Ausgabe ab�ndern

-- Wenn ein Fall gefunden wird, dann passiert xyz, wenn nicht dasnn ist das Ergebnis NULL
SELECT UnitsInStock,
CASE
	WHEN UnitsInStock < 15 THEN 'Nachbestellen!'
	WHEN UnitsInStock > 15 THEN 'Passt.'
END as Pruefung
FROM Products

-- Alternativ mit ELSE einen "Notausgang" definieren:
SELECT UnitsInStock,
CASE
	WHEN UnitsInStock < 15 THEN 'Nachbestellen!'
	WHEN UnitsInStock > 15 THEN 'Passt.'
	ELSE 'Fehler! Daf�r gibt es keine �berpr�fung'
END as Pruefung
FROM Products

-- Funktioniert auch mit UPDATE:
BEGIN TRANSACTION 

ROLLBACK

UPDATE Customers
SET City =
CASE
	WHEN Country = 'Germany' THEN 'Berlin'
	WHEN Country = 'France' THEN 'Paris'
	ELSE City
END

SELECT City, Country FROM Customers
WHERE Country IN ('Germany', 'France')

-- Auch im GROUP BY m�glich
SELECT SUM(UnitsInStock),
CASE
	WHEN UnitsInStock < 15 THEN 'Nachbestellen!'
	WHEN UnitsInStock > 15 THEN 'Passt.'
	ELSE 'Fehler! Daf�r gibt es keine �berpr�fung'
END as Pruefung
FROM Products
GROUP BY
CASE
	WHEN UnitsInStock < 15 THEN 'Nachbestellen!'
	WHEN UnitsInStock > 15 THEN 'Passt.'
	ELSE 'Fehler! Daf�r gibt es keine �berpr�fung'
END

-- Aufgabe:
-- Wenn ShippedDate kleiner als RequiredDate => "P�nktlich versendet!"
-- Wenn ShippedDate gleich 0 ist => 'Noch nicht versendet'
-- Ansonsten: "Versp�tet versendet"
SELECT OrderDate, RequiredDate, ShippedDate,
CASE
	WHEN ShippedDate IS NULL THEN 'Noch nicht versendet'
	WHEN ShippedDate <= RequiredDate THEN 'Versendet p�nktlich'
	ELSE 'Versp�tet versendet'
END as OrderStatus
FROM Orders