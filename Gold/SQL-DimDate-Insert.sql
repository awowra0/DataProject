WITH DateGenerator AS (
    SELECT 
        DATEADD(DAY, value, CAST('1999-01-01' AS DATE)) AS FullDate
    FROM GENERATE_SERIES(0, DATEDIFF(DAY, '1999-01-01', '2026-12-31'), 1)
)
INSERT INTO Warehouse.Gold.Dates (DateID, Date, Year, Interval, IntervalName, Month, MonthName, YearMonth, Day, DayOfWeek, DayName, IsWorkDay, IsWeekend)
SELECT
    CAST(FORMAT(FullDate, 'yyyyMMdd') AS INT),
    FullDate,
    CAST(YEAR(FullDate) AS SMALLINT),
    CAST(DATEPART(QUARTER, FullDate) AS SMALLINT),
    CAST(CONCAT('Q', DATEPART(QUARTER, FullDate), ' ', DATEPART(YEAR, FullDate)) AS CHAR(7)),
    CAST(MONTH(FullDate) AS SMALLINT),
    CAST(DATENAME(MONTH, FullDate) AS VARCHAR(15)),
    CAST(FORMAT(FullDate, 'yyyy-MM') AS CHAR(7)),
    CAST(DAY(FullDate) AS TINYINT),
    CAST(DATEPART(WEEKDAY, FullDate) AS TINYINT),
    CAST(DATENAME(WEEKDAY, FullDate) AS VARCHAR(15)),
    CASE WHEN DATEPART(WEEKDAY, FullDate) IN (1, 7) THEN 0 ELSE 1 END,
    CASE WHEN DATEPART(WEEKDAY, FullDate) IN (1, 7) THEN 1 ELSE 0 END
FROM DateGenerator;
