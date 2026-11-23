CREATE TABLE Gold.FX
(
    FXID INT NOT NULL,
    CurrencyFromTo VARCHAR(20) NOT NULL,
    CurrencyDate DATE NOT NULL,
    CurrencyValue DECIMAL(10,4) NOT NULL,
    IsWorkDay BIT
);