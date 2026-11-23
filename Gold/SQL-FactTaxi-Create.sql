CREATE TABLE Gold.FactTaxiDaily
(
    FareID BIGINT NOT NULL,
    PickupDate DATETIME2(0) NOT NULL,
    PickLocation INT NOT NULL,
    DropDate DATETIME2(0) NOT NULL,
    DropLocation INT NOT NULL,
    Distance DECIMAL(8,3),
    Fare DECIMAL(8,2) NOT NULL,
    Passengers INT,
    TaxiType VARCHAR(7)
);