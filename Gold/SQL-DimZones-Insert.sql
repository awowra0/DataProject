INSERT INTO Gold.Zones (ZoneID, LocationID, Neighborhood, ZoneName, ServiceZone, IsAirport)
SELECT
    LocationID,
    LocationID,
    Neighborhood,
    ZoneName,
    ServiceZone,
    IsAirport
FROM Lakehouse.Silver.zones