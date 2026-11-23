CREATE TABLE Gold.Dates
(
    DateID INT NOT NULL,
    Date DATE,
    Year SMALLINT,
    Interval SMALLINT,
    IntervalName CHAR(7),
    Month SMALLINT,
    MonthName VARCHAR(15),
    YearMonth CHAR(7),
    Day SMALLINT,
    DayOfWeek SMALLINT,
    DayName VARCHAR(10),
    IsWorkDay BIT,
    IsWeekend BIT
)