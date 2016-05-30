library(ggplot2)
library(plyr)
library(doBy)
#read the csv data
alldata <- read.csv(url("https://www.quandl.com/api/v3/datasets/ZILL/C00001_A.csv"))
price_to_rent <- read.csv(url("https://www.quandl.com/api/v3/datasets/ZILL/C00001_PRR.csv"))
increasing_value <- read.csv(url("https://www.quandl.com/api/v3/datasets/ZILL/C00001_IV.csv"))
homes_to_rent <- read.csv(url("https://www.quandl.com/api/v3/datasets/ZILL/C00001_HR.csv"))
sold_for_gain <- read.csv(url("https://www.quandl.com/api/v3/datasets/ZILL/C00001_SFG.csv"))
turnover_values <- read.csv(url("https://www.quandl.com/api/v3/datasets/ZILL/C00001_SPY.csv"))

summary(alldata)
#plot a histogram and box plot for the entire data for NYC
ggplot(alldata, aes(x=alldata$Date, y=alldata$Value, fill=alldata$Date)) + geom_bar(stat="identity")
plot(alldata$Date, alldata$Value)

summary(price_to_rent)
plot(price_to_rent$Date, price_to_rent$Value)
ggplot(price_to_rent, aes(x=price_to_rent$Date, y=price_to_rent$Value, fill=price_to_rent$Date)) + geom_bar(stat="identity")

summary(increasing_value)
plot(increasing_value$Date, increasing_value$Value)
ggplot(increasing_value, aes(x=increasing_value$Date, y=increasing_value$Value, fill=increasing_value$Date)) + geom_bar(stat="identity")

summary(homes_to_rent)
plot(homes_to_rent$Date, homes_to_rent$Value)
ggplot(homes_to_rent, aes(x=homes_to_rent$Date, y=homes_to_rent$Value, fill=homes_to_rent$Date)) + geom_bar(stat="identity")

summary(sold_for_gain)
plot(sold_for_gain$Date, sold_for_gain$Value)
ggplot(sold_for_gain, aes(x=sold_for_gain$Date, y=sold_for_gain$Value, fill=sold_for_gain$Date)) + geom_bar(stat="identity")

summary(turnover_values)
plot(turnover_values$Date, turnover_values$Value)
ggplot(turnover_values, aes(x=turnover_values$Date, y=turnover_values$Value, fill=turnover_values$Date)) + geom_bar(stat="identity")

