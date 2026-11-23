INSERT INTO Gold.FactAirQualityDaily (AQID, Value, MeasureDateTime, MeasureName, MeasureUnit, MeasureSensorID, MeasureLocation)
SELECT
    HASHBYTES('SHA2_256', CONCAT(MeasureDateTime, MeasureValue)) AS AQID,
    MeasureValue,
    MeasureDateTime,
    MeasureName,
    Unit,
    SensorID,
    MeasureLocation
FROM Lakehouse.Silver.openaq