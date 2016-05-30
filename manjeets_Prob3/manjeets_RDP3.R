library(gdata)
library(plyr)
library(xlsx)

mtn <- read.xls("C:\\Users\\MANJEET\\Downloads\\dds_datasets\\dds_ch2_rollingsales\\rollingsales_manhattan.xls",pattern="BOROUGH")
queens <- read.xls("C:\\Users\\MANJEET\\Downloads\\dds_datasets\\dds_ch2_rollingsales\\rollingsales_queens.xls",pattern="BOROUGH")
merged_data <- merge(mtn, queens, all=TRUE)
require(gdata)
head(merged_data)
summary(merged_data)
names(merged_data) <- tolower(names(merged_data))
merged_data$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","",merged_data$sale.price))
merged_data$gross.sqft <- as.numeric(gsub("[^[:digit:]]","",merged_data$gross.square.feet))
merged_data$sale.date <- as.Date(merged_data$sale.date)
merged_data$year.built<- as.numeric(as.character(merged_data$year.built))

##keep only actual sales data
merged_data.sales <- merged_data[merged_data$SALE.PRICE.N!=0,]
plot(merged_data.sales$borough, log(merged_data.sales$sale.price.n))
library(ggplot2)
ggplot(merged_data.sales, aes(x=merged_data.sales$borough,y=log(merged_data.sales$sale.price.n), fill=merged_data.sales$neighborhood)) + geom_bar(stat="identity")
ggplot(merged_data.sales, aes(x=merged_data.sales$neighborhood,y=log(merged_data.sales$SALE.PRICE.N), fill=merged_data.sales$borough)) + geom_bar(stat="identity")
ggplot(merged_data.sales, aes(x=merged_data.sales$building.class.category,y=log(merged_data.sales$sale.price.n), fill=merged_data.sales$borough)) + geom_bar(stat="identity")
ggplot(merged_data.sales, aes(x=merged_data.sales$residential.units, fill=merged_data.sales$borough)) + geom_density(bw=0.5)
ggplot(merged_data.sales, aes(x=merged_data.sales$commercial.units, fill=merged_data.sales$borough)) + geom_density(bw=0.5)

#plot to show sales data for every neighbourhood on a yearly basis and total
library(doBy)
site_range <- function(x){c(length(x), sum(x))}
year2012 <- subset(merged_data.sales, format(merged_data.sales$sale.date, '%y')=='12')
plot(year2012$neighborhood, log(year2012$SALE.PRICE.N))
ggplot(year2012, aes(x=year2012$sale.date, y=log(year2012$SALE.PRICE.N), fill=year2012$borough)) +geom_bar(stat="identity")

year2013 <- subset(merged_data.sales, format(merged_data.sales$sale.date, '%y')=='13')
plot(year2013$neighborhood, log(year2013$SALE.PRICE.N))
ggplot(year2013, aes(x=year2013$sale.date, y=log(year2013$SALE.PRICE.N), fill=year2013$borough)) +geom_bar(stat="identity")

ggplot(merged_data.sales, aes(x=merged_data.sales$sale.date, y=log(merged_data.sales$SALE.PRICE.N), fill=merged_data.sales$borough)) +geom_bar(stat="identity")
