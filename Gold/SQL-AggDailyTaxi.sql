CREATE TABLE Gold.AggDailyTaxi AS
SELECT
    CONVERT(DATE, PickupDate) AS Date,
    TaxiType,
    SUM(Fare) AS FareSUM,
    COALESCE(AVG(NULLIF(Fare, 0)),0) AS FareAVG,
    COUNT(*) AS FareCOUNT,
    SUM(Distance) AS DistanceSUM,
    COALESCE(AVG(CASE WHEN Distance = 0 AND Fare = 0 THEN NULL ELSE Distance END), 0) AS DistanceAVG,
    SUM(Passengers) AS PassengersSUM,
    ROUND(COALESCE(AVG(NULLIF(CAST(Passengers AS FLOAT), 0)), 0), 3) AS PassengersAVG,
    DropLocation,
    PickLocation
FROM Gold.FactTaxiDaily
GROUP BY CONVERT(DATE, PickupDate), TaxiType, DropLocation, PickLocation