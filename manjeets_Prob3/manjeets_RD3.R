library(gdata)
library(plyr)

bk <- read.xls("C:\\Users\\MANJEET\\Downloads\\dds_datasets\\dds_ch2_rollingsales\\rollingsales_brooklyn.xls",pattern="BOROUGH")
require(gdata)
head(bk)
summary(bk)
names(bk) <- tolower(names(bk))
bk$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","",bk$sale.price))
bk$gross.sqft <- as.numeric(gsub("[^[:digit:]]","",bk$gross.square.feet))
bk$sale.date <- as.Date(bk$sale.date)
bk$year.built<- as.numeric(as.character(bk$year.built))

##keep only actual sales data
bk.sales <- bk[bk$SALE.PRICE.N!=0,]
plot(bk.sales$neighborhood, log(bk.sales$SALE.PRICE.N))
library(ggplot2)
ggplot(bk.sales, aes(x=bk.sales$neighborhood,y=log(bk.sales$SALE.PRICE.N), fill=bk.sales$neighborhood)) + geom_bar(stat="identity")
ggplot(bk.sales, aes(x=bk.sales$building.class.category,y=log(bk.sales$SALE.PRICE.N), fill=bk.sales$building.class.category)) + geom_bar(stat="identity")
ggplot(bk.sales, aes(x=bk.sales$neighborhood,y=bk.sales$total.units, fill=bk.sales$neighborhood)) + geom_bar(stat="identity")
ggplot(bk.sales, aes(x=bk.sales$sale.date, fill=bk.sales$neighborhood)) + geom_density(bw=7)

#plot to show sales data for every neighbourhood on a yearly basis and total
library(doBy)
siterange <- function(x){c(length(x), sum(x))}
year_2012 <- subset(bk.sales, format(bk.sales$sale.date, '%y')=='12')
plot(year_2012$neighborhood, log(year_2012$SALE.PRICE.N))
ggplot(year_2012, aes(x=year_2012$sale.date, y=log(year_2012$SALE.PRICE.N), fill=year_2012$sale.date)) +geom_bar(stat="identity")

year_2013 <- subset(bk.sales, format(bk.sales$sale.date, '%y')=='13')
plot(year_2013$neighborhood, log(year_2013$SALE.PRICE.N))
ggplot(year_2013, aes(x=year_2013$sale.date, y=log(year_2013$SALE.PRICE.N), fill=year_2013$sale.date)) +geom_bar(stat="identity")

ggplot(bk.sales, aes(x=bk.sales$sale.date, y=log(bk.sales$SALE.PRICE.N), fill=bk.sales$sale.date)) +geom_bar(stat="identity")
