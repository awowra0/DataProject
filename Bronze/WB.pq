let
  Source = Json.Document(Web.Contents("https://api.worldbank.org/v2/country/USA/indicator/NY.GDP.MKTP.CD?format=json")),
  Navigation = Source{1},
  #"Converted to table" = Table.FromList(Navigation, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
  #"Expanded Column1" = Table.ExpandRecordColumn(#"Converted to table", "Column1", {"indicator", "country", "countryiso3code", "date", "value", "unit", "obs_status", "decimal"}, {"indicator", "country", "countryiso3code", "date", "value", "unit", "obs_status", "decimal"}),
  #"Expanded indicator" = Table.ExpandRecordColumn(#"Expanded Column1", "indicator", {"id", "value"}, {"indicator_id", "indicator_value"}),
  #"Expanded country" = Table.ExpandRecordColumn(#"Expanded indicator", "country", {"id", "value"}, {"country_id", "country_value"}),
  #"Changed column type" = Table.TransformColumnTypes(#"Expanded country", {{"indicator_id", type text}, {"indicator_value", type text}, {"country_id", type text}, {"country_value", type text}, {"countryiso3code", type text}, {"value", type text}, {"obs_status", type text}, {"date", Int64.Type}, {"unit", Int64.Type}, {"decimal", Int64.Type}})
in
  #"Changed column type"