CREATE TABLE Gold.FactAirQualityDaily
(
	AQID BIGINT NOT NULL,
	Value DECIMAL(6, 3) NOT NULL,
	MeasureDateTime DATETIME2(0) NOT NULL,
	MeasureName VARCHAR(10),
	MeasureUnit VARCHAR(10),
	MeasureSensorID INT,
	MeasureLocation VARCHAR(15)
)