/*
	Partitionierung:
	Aufteilung in "mehrere" Tabellen
	Einzelne Tabelle bleibt bestehen, aber intern werden die Daten partitioniert
*/

-- Anforderung
-- Partitionsfunktion: Stellt die Bereiche dar (0-100, 101-200, 201-Ende)
-- Partitionsschema: Weist die einzelnen Partitionen auf Dateigruppen zu

-- 0-100-200-Ende
-- Partitionsfunktion:
CREATE PARTITION FUNCTION pf_Zahl(int) AS
RANGE LEFT FOR VALUES(100, 200)

-- z.B Falsch Geschrieben
--DROP PARTITION FUNCTION pf_Zahl
--DROP PARTITION SCHEME sch_ID

-- Für ein Partitionsschmea muss immer eine extra Dateigruppe existieren
CREATE PARTITION SCHEME sch_ID AS
PARTITION pf_Zahl TO (P1, P2, P3)

-- Dateigruppe und Dateien erstellen
ALTER DATABASE Demo6 ADD FILEGROUP P1

-- Datei erstellen
ALTER DATABASE Demo6
ADD FILE
(
	NAME = N'P1_Demo6',
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLKURS\MSSQL\DATA\P1_Demo6.ndf',
	SIZE = 8192KB,
	FILEGROWTH = 65536KB
)
TO FILEGROUP P1
----------------------------------------
ALTER DATABASE Demo6 ADD FILEGROUP P2

-- Datei erstellen
ALTER DATABASE Demo6
ADD FILE
(
	NAME = N'P2_Demo6',
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLKURS\MSSQL\DATA\P2_Demo6.ndf',
	SIZE = 8192KB,
	FILEGROWTH = 65536KB
)
TO FILEGROUP P2
----------------------------------------
ALTER DATABASE Demo6 ADD FILEGROUP P3

-- Datei erstellen
ALTER DATABASE Demo6
ADD FILE
(
	NAME = N'P3_Demo6',
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLKURS\MSSQL\DATA\P3_Demo6.ndf',
	SIZE = 8192KB,
	FILEGROWTH = 65536KB
)
TO FILEGROUP P3

----------------------------------------

-- Hier muss die Tabelle auf das Schema gelegt werden
CREATE TABLE M003_Test
(
	id int identity,
	zahl float
) ON sch_ID(id)

BEGIN TRAN
DECLARE @i int = 0
WHILE @i < 1000
BEGIN 
	INSERT INTO M003_Test values (RAND() * 1000)
	SET @i += 1
END
COMMIT

-- Nichts besonderes zu sehen
SELECT * FROM M003_Test

-- Hier wird nur die unterste Partition durchsucht (100DS)
SELECT * FROM M003_Test
WHERE ID < 50

-- Hier wird nur die oberste Partition durchsucht (800DS)
SELECT * FROM M003_Test
WHERE ID > 500

-- Übersicht über Partition verschaffen
SELECT OBJECT_NAME(object_id), * FROM sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED')

dbcc showcontig('M003_Test')
SET STATISTICS TIME, IO OFF

-- Testbefehl ob das Schema wirklich gesetzt ist
SELECT $partition.pf_Zahl(50)
SELECT $partition.pf_Zahl(150)
SELECT $partition.pf_Zahl(250)

SELECT $partition.pf_Zahl(id), COUNT(*), AVG(zahl) FROM M003_Test
GROUP BY $partition.pf_Zahl(id)

-- Verwaltungssicht zu all deinen Dateigruppen zur Datenbank mit der du gerade verbunden bist
SELECT * FROM sys.filegroups

SELECT * FROM sys.allocation_units

-- Pro Datensatz die Partition + Filegroup anhängen
SELECT * FROM M003_Test as t
JOIN
(
	SELECT name, ips.partition_number
	FROM sys.filegroups as fg

	JOIN sys.allocation_units as au
	ON fg.data_space_id = au.data_space_id

	JOIN sys.dm_db_index_physical_stats(db_id(), 0, -1, 0, 'DETAILED') as ips
	ON ips.hobt_id = au.container_id

	WHERE OBJECT_name(ips.object_id) = 'M003_Test'
) x
ON $partition.pf_Zahl(t.id) = x.partition_number