library(jsonlite)
library(curl)

download.file(url = "http://ergast.com/api/f1/2012/results.json" , destfile = "manjeets_DAdata.json")
