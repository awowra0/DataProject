# Gold
Gold Notebook contains all scripts used to build and populate tables in Warehouse.  
Single SQL scripts achieve similar results.

## Tables
Warehouse contain dimensional tables (Dim), fact tables (Fact) and aggregates (Agg).  
  
DimDate  
-  contains date records with various formats - full date, year, month, day, workday, ...  

DimFX
-  contains workday conversion values from USD to EURO  

DimWB  
-  contains USA GDP across years  

DimZones  
-  contains all NYC TLC locations information

FactAQ  
-  contains measurements from selected sensors

FactTaxi  
-  contains all registered taxi fares in NYC

AggAQ  
-  aggregates FactAQ values, groups by date, location (district) and type of pollution  

AggDailyTaxi  
-  aggregates FactDailyTaxi, groups by date, taxi, pickup location and dropout location  
