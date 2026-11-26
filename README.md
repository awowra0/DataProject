# DataProject  
This is a project that uses Microsoft Fabric to fetch, transform and visualize open source data.  

## Used data  
NYC TLC: https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page  
OpenAQ: https://docs.openaq.org/about/about  
World Bank GDP: https://api.worldbank.org/v2/country/USA/indicator/NY.GDP.MKTP.CD?format=json  
ECB FX: https://data-api.ecb.europa.eu/service/data/EXR/D.USD.EUR.SP00.A?format=csvdata  

## Fabric workspace  
Workspace uses standard Fabric items with medallion architecture.  
  
Bronze  
- Dataflow-AQ-O3
    - fetches O3 pollution from selected NYC sensors  
-	Dataflow-AQ-PM25  
    - fetches PM25 pollution from selected NYC sensors  
-	Dataflow-FX  
    - fetches currency conversion (USD-EURO) data  
-	Dataflow-WorldBank  
    -	fetches yearly GDP for the USA  
-	Dataflow-Zones  
    -	fetches NYC locations  
-	Pipeline-TLC  
    -	fetches NYC taxi trips  
-	LakehouseBronze  
    -	keeps all fetched data  
  
Silver  
-	Notebook-Silver
    -	leans and transforms Bronze data  
-	LakehouseSilver
    -	keeps all transformed data  
  
Gold  
-	Notebook-Gold
    -	builds dimensional, fact and aggregation tables  
-	Warehouse
    -	keeps all final tables  
  
Visualization  
-	SemanticModel
    -	builds relation between tables  
-	Dashboard
    -	presents data
