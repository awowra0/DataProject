CREATE TABLE Gold.Zones
(
    ZoneID INT NOT NULL,
    LocationID INT NOT NULL,
    Neighborhood VARCHAR(15),
    ZoneName VARCHAR(60) NOT NULL,
    ServiceZone VARCHAR(15),
    IsAirport BIT
)