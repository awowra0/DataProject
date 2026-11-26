# Silver  
Silver Notebook contains PySpark cells that fetches data from Bronze Lakehouse and makes necessary changes - converting values to Integer, Long or Decimal type, formarting dates to yyyy/MM/dd or yyyy/MM/dd hh:mm:ss format, removing some columns, replacing Null values with 0 or removing them, renaming columns and adding new columns.  
  
TLC tables are appended to target table in loop and checked first for their existence.  
Other Tables overwrites target tables.
