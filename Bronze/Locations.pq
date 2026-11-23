let
  Source = Csv.Document(Web.Contents("https://d37ci6vzurychx.cloudfront.net/misc/taxi_zone_lookup.csv"), [Delimiter = ",", Columns = 4, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"LocationID", Int64.Type}, {"Borough", type text}, {"Zone", type text}, {"service_zone", type text}})
in
  #"Changed column type"
