CREATE TABLE Gold.AggDailyAirQuality AS
SELECT
    CAST(MeasureDateTime AS DATE) AS Date,
    MeasureLocation,
    MeasureName,
    COALESCE(AVG(Value), 0) AS MeasureValue
FROM Gold.FactAirQualityDaily
GROUP BY CAST(MeasureDateTime AS DATE), MeasureLocation, MeasureName