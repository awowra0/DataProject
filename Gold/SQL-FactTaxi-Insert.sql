INSERT INTO Gold.FactTaxiDaily (FareID, PickupDate, PickLocation, DropDate, DropLocation, Distance, Fare, Passengers, TaxiType)
SELECT
    HASHBYTES('SHA2_256', CONCAT(PickDate, PickLocation, DropLocation, DropLocation, Fare)) AS FareID,
    PickDate,
    PickLocation,
    DropDate,
    DropLocation,
    Distance,
    COALESCE(Fare, 0),
    Passengers,
    TLCType
FROM Lakehouse.Silver.tlc