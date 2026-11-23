INSERT INTO Gold.FX (FXID, CurrencyFromTo, CurrencyDate, CurrencyValue, IsWorkDay)
SELECT
    ROW_NUMBER() OVER (ORDER BY Date) AS FXID,
    CurrencyConvert,
    Date,
    CurrencyValue,
    CASE 
        WHEN DATENAME(WEEKDAY, Date) IN ('Saturday', 'Sunday') THEN 0
        ELSE 1 
    END AS IsWorkDay
FROM Lakehouse.Silver.fx;