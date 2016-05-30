your_json <- jsonlite::stream_in(file("manjeets_DAdata.json"))
json_data <- toJSON(your_json, pretty = TRUE)
f1_data <- fromJSON(json_data)
