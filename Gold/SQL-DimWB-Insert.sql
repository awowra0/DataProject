INSERT INTO Gold.WB (WBID, DateYear, Income, CountryISO, CountryName, Indicator)
SELECT
    ROW_NUMBER() OVER (ORDER BY Year) AS WBID,
    Year,
    Income,
    CountryID,
    CountryValue,
    Indicator
FROM Lakehouse.Silver.wb;