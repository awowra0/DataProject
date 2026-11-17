let
    ApiKey = "API_KEY_VALUE",
    SensorId = "SENSOR_ID_VALUE",
    StartDate = #date(2016, 1, 1),
    EndDate = Date.From(DateTime.LocalNow()),

    MonthCount = (Date.Year(EndDate) - Date.Year(StartDate)) * 12 + (Date.Month(EndDate) - Date.Month(StartDate)),
    MonthOffsets = {0..MonthCount},
    DateRanges = List.Transform(MonthOffsets, each 
        let
            ChunkStart = Date.AddMonths(StartDate, _),
            ChunkEnd = Date.EndOfMonth(ChunkStart)
        in
            [
                From = DateTime.ToText(DateTime.From(ChunkStart), "yyyy-MM-ddTHH:mm:ss") & "Z",
                To = DateTime.ToText(DateTime.From(ChunkEnd) + #duration(0, 23, 59, 59), "yyyy-MM-ddTHH:mm:ss") & "Z"
            ]
    ),

    FetchMonth = (Range as record) =>
        let
            Source = Json.Document(
                Web.Contents(
                    "https://api.openaq.org",
                    [
                        RelativePath = "v3/sensors/" & SensorId & "/hours",
                        Headers = [#"X-API-Key" = ApiKey],
                        Query = [
                            datetime_from = Range[From],
                            datetime_to = Range[To],
                            limit = "1000",
                            page = "1"
                        ]
                    ]
                )
            ),
            Results = Source[results]
        in
            Results,

    AllResults = List.Transform(DateRanges, each FetchMonth(_)),
    CombinedList = List.Combine(AllResults),
    ToTable = Table.FromList(CombinedList, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
  #"Expanded Column1" = Table.ExpandRecordColumn(ToTable, "Column1", {"value", "flagInfo", "parameter", "period", "coordinates", "summary", "coverage"}, {"value", "flagInfo", "parameter", "period", "coordinates", "summary", "coverage"}),
  #"Expanded flagInfo" = Table.ExpandRecordColumn(#"Expanded Column1", "flagInfo", {"hasFlags"}, {"hasFlags"}),
  #"Expanded parameter" = Table.ExpandRecordColumn(#"Expanded flagInfo", "parameter", {"id", "name", "units", "displayName"}, {"id", "name", "units", "displayName"}),
  #"Expanded period" = Table.ExpandRecordColumn(#"Expanded parameter", "period", {"label", "interval", "datetimeFrom", "datetimeTo"}, {"period_label", "period_interval", "period_datetimeFrom", "period_datetimeTo"}),
  #"Expanded datetimeFrom" = Table.ExpandRecordColumn(#"Expanded period", "period_datetimeFrom", {"utc", "local"}, {"period_datetimeFrom_utc", "period_datetimeFrom_local"}),
  #"Expanded datetimeTo" = Table.ExpandRecordColumn(#"Expanded datetimeFrom", "period_datetimeTo", {"utc", "local"}, {"period_datetimeTo_utc", "period_datetimeTo_local"}),
  #"Expanded summary" = Table.ExpandRecordColumn(#"Expanded datetimeTo", "summary", {"min", "q02", "q25", "median", "q75", "q98", "max", "avg", "sd"}, {"min", "q02", "q25", "median", "q75", "q98", "max", "avg", "sd"}),
  #"Expanded coverage" = Table.ExpandRecordColumn(#"Expanded summary", "coverage", {"expectedCount", "expectedInterval", "observedCount", "observedInterval", "percentComplete", "percentCoverage", "datetimeFrom", "datetimeTo"}, {"coverage_expectedCount", "coverage_expectedInterval", "coverage_observedCount", "coverage_observedInterval", "coverage_percentComplete", "coverage_percentCoverage", "coverage_datetimeFrom", "coverage_datetimeTo"}),
  #"Expanded coverage.datetimeFrom" = Table.ExpandRecordColumn(#"Expanded coverage", "coverage_datetimeFrom", {"utc", "local"}, {"coverage_datetimeFrom_utc", "coverage_datetimeFrom_local"}),
  #"Expanded coverage.datetimeTo" = Table.ExpandRecordColumn(#"Expanded coverage.datetimeFrom", "coverage_datetimeTo", {"utc", "local"}, {"coverage_datetimeTo_utc", "coverage_datetimeTo_local"}),
  #"Changed column type" = Table.TransformColumnTypes(#"Expanded coverage.datetimeTo", {{"value", type text}, {"min", type text}, {"q02", type text}, {"q25", type text}, {"median", type text}, {"q75", type text}, {"q98", type text}, {"max", type text}, {"avg", type text}, {"sd", type text}, {"coverage_expectedCount", Int64.Type}, {"coverage_observedCount", Int64.Type}, {"coverage_percentComplete", Int64.Type}, {"coverage_percentCoverage", Int64.Type}, {"hasFlags", type logical}, {"id", Int64.Type}, {"name", type text}, {"units", type text}, {"displayName", type text}, {"period_label", type text}, {"coordinates", type text}, {"period_interval", type duration}, {"coverage_expectedInterval", type duration}, {"coverage_observedInterval", type duration}, {"period_datetimeFrom_utc", type datetime}, {"period_datetimeTo_utc", type datetime}, {"coverage_datetimeFrom_utc", type datetime}, {"coverage_datetimeTo_utc", type datetime}, {"period_datetimeFrom_local", type datetimezone}, {"period_datetimeTo_local", type datetimezone}, {"coverage_datetimeFrom_local", type datetimezone}, {"coverage_datetimeTo_local", type datetimezone}})
in
    #"Changed column type"